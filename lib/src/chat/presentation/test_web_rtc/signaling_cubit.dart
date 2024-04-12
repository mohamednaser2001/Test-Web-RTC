import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:meta/meta.dart';
part 'signaling_state.dart';

typedef void StreamStateCallback(MediaStream stream);

/// TODO: 3 ways to handle mic and camera.
/// 1) data channel.
/// 2) firebase (custom).
/// 3) update stream in room endpoint.

class SignalingCubit extends Cubit<SignalingStates> {

  SignalingCubit({required this.roomId, required this.isCaller}) : super(SignalingInitialState()) {

    initAndStartCall();

  }

  SignalingCubit get(context)=> BlocProvider.of(context);
  // String? roomId;

  Future<void> initAndStartCall() async{
    await localRenderer.initialize();
    await remoteRenderer.initialize();

    onAddRemoteStream = ((stream) {
      print('===========================ooo=====================');
      remoteRenderer.srcObject = stream;
    });
    listenForAntherPeerAudio();

    await openUserMedia(localRenderer, remoteRenderer);
    if(isCaller){
      await createRoom(remoteRenderer);
    }else{
      print('==join room ');
      await joinRoom(roomId, remoteRenderer);
    }


  }

  Future<void> getDeviceToken() async{
    await FirebaseMessaging.instance.getToken().then((value) {
      print('token: $value');
    });
  }



  Map<String, dynamic> configuration = {
    'iceServers': [
      {
        'urls': [
          'stun:stun1.l.google.com:19302',
          'stun:stun2.l.google.com:19302'
        ]
      }
    ]
  };

  RTCVideoRenderer localRenderer = RTCVideoRenderer();
  RTCVideoRenderer remoteRenderer = RTCVideoRenderer();

  RTCPeerConnection? peerConnection;
  MediaStream? localStream;
  MediaStream? remoteStream;
  String roomId;
  String? currentRoomText;
  StreamStateCallback? onAddRemoteStream;
  bool antherPeerConnected= true;
  bool isCaller= true;



  Future<String> createRoom(RTCVideoRenderer remoteRenderer) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    DocumentReference roomRef = db.collection('rooms').doc(this.roomId);

    print('Create PeerConnection with configuration: $configuration');

    peerConnection = await createPeerConnection(configuration);

    /// Create data channel
    await createDataChannel();
    // // listenForRemoteStatus();


    registerPeerConnectionListeners();

    ///Add local video tracks to PeerConnection.
    localStream?.getTracks().forEach((track) {
      peerConnection?.addTrack(track, localStream!);
    });

    // Code for collecting ICE candidates below
    var callerCandidatesCollection = roomRef.collection('callerCandidates');

    peerConnection?.onIceCandidate = (RTCIceCandidate candidate) {
      print('Got candidate: ${candidate.toMap()}');
      callerCandidatesCollection.add(candidate.toMap());
    };
    // Finish Code for collecting ICE candidate

    // Add code for creating a room
    RTCSessionDescription offer = await peerConnection!.createOffer();
    await peerConnection!.setLocalDescription(offer);
    print('Created offer: $offer');

    Map<String, dynamic> roomWithOffer = {'offer': offer.toMap()};

    await roomRef.set(roomWithOffer);
    var roomId = roomRef.id;
    print('New room created with SDK offer. Room ID: $roomId');
    currentRoomText = 'Current room is $roomId - You are the caller!';
    // Created a Room

    peerConnection?.onTrack = (RTCTrackEvent event) {
      print('Got remote track: ${event.streams[0]}');

      event.streams[0].getTracks().forEach((track) {
        print('Add a track to the remoteStream $track');
        remoteStream?.addTrack(track);
      });
    };

    // Listening for remote session description below
    roomRef.snapshots().listen((snapshot) async {
      print('Got updated room: ${snapshot.data()}');

      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      if (peerConnection?.getRemoteDescription() != null &&
          data['answer'] != null) {
        var answer = RTCSessionDescription(
          data['answer']['sdp'],
          data['answer']['type'],
        );

        print("Someone tried to connect");
        await peerConnection?.setRemoteDescription(answer);
      }
    });
    // Listening for remote session description above

    // Listen for remote Ice candidates below
    roomRef.collection('calleeCandidates').snapshots().listen((snapshot) {
      snapshot.docChanges.forEach((change) {
        if (change.type == DocumentChangeType.added) {
          Map<String, dynamic> data = change.doc.data() as Map<String, dynamic>;
          print('Got new remote ICE candidate: ${jsonEncode(data)}');
          peerConnection!.addCandidate(
            RTCIceCandidate(
              data['candidate'],
              data['sdpMid'],
              data['sdpMLineIndex'],
            ),
          );
        }
      });
    });

    emit(CreateRoomState());
    return roomId;
  }

  Future<void> joinRoom(String roomId, RTCVideoRenderer remoteVideo) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    print(roomId);
    DocumentReference roomRef = db.collection('rooms').doc(roomId);
    var roomSnapshot = await roomRef.get();
    print('Got room ${roomSnapshot.exists}');

    if (roomSnapshot.exists) {
      print('Create PeerConnection with configuration: $configuration');
      peerConnection = await createPeerConnection(configuration);

      /// Create data channel
      // await createDataChannel();
      // listenForRemoteStatus();


      registerPeerConnectionListeners();

      /// add tracks for me in firebase, to tell the anther user that i have opened the mic and camera.
      localStream?.getTracks().forEach((track) {
        peerConnection?.addTrack(track, localStream!);
      });

      // Code for collecting ICE candidates below
      var calleeCandidatesCollection = roomRef.collection('calleeCandidates');
      peerConnection!.onIceCandidate = (RTCIceCandidate? candidate) {
        if (candidate == null) {
          print('onIceCandidate: complete!');
          return;
        }
        print('onIceCandidate: ${candidate.toMap()}');
        calleeCandidatesCollection.add(candidate.toMap());
      };
      // Code for collecting ICE candidate above

      peerConnection?.onTrack = (RTCTrackEvent event) {
        print('Got remote track: ${event.streams[0]}');
        event.streams[0].getTracks().forEach((track) {
          print('Add a track to the remoteStream: $track');
          remoteStream?.addTrack(track);
        });
      };

      // Code for creating SDP answer below
      var data = roomSnapshot.data() as Map<String, dynamic>;
      print('Got offer $data');
      var offer = data['offer'];
      await peerConnection?.setRemoteDescription(
        RTCSessionDescription(offer['sdp'], offer['type']),
      );
      var answer = await peerConnection!.createAnswer();
      print('Created Answer $answer');

      await peerConnection!.setLocalDescription(answer);

      Map<String, dynamic> roomWithAnswer = {
        'answer': {'type': answer.type, 'sdp': answer.sdp}
      };

      await roomRef.update(roomWithAnswer);
      // Finished creating SDP answer

      // Listening for remote ICE candidates below
      roomRef.collection('callerCandidates').snapshots().listen((snapshot) {
        snapshot.docChanges.forEach((document) {
          var data = document.doc.data() as Map<String, dynamic>;
          print(data);
          print('Got new remote ICE candidate: $data');
          peerConnection!.addCandidate(
            RTCIceCandidate(
              data['candidate'],
              data['sdpMid'],
              data['sdpMLineIndex'],
            ),
          );
        });
      });
    }
    emit(JoinMeetingState());
  }

  Future<void> openUserMedia(
      RTCVideoRenderer localVideo,
      RTCVideoRenderer remoteVideo,
      {
        bool cameraOpen= true,
        bool micOpen= true,
      }) async {
    var stream = await navigator.mediaDevices
        .getUserMedia({'video': cameraOpen, 'audio': micOpen});

    localVideo.srcObject = stream;
    localStream = stream;

    remoteVideo.srcObject = await createLocalMediaStream('key');
    await setStatusOfMicAndCamera(micStatus: isAudioOn, cameraStatus: isVideoOn);
  }

  Future<void> hangUp(RTCVideoRenderer localVideo) async {
    await setStatusOfMicAndCamera(micStatus: true, cameraStatus: false);
    List<MediaStreamTrack> tracks = localVideo.srcObject!.getTracks();
    tracks.forEach((track) {
      track.stop();
    });

    if (remoteStream != null) {
      remoteStream!.getTracks().forEach((track) async => await track.stop());
    }
    if (peerConnection != null) await peerConnection!.close();

    if (roomId != null) {
      var db = FirebaseFirestore.instance;
      var roomRef = db.collection('rooms').doc(roomId);
      var calleeCandidates = await roomRef.collection('calleeCandidates').get();
      calleeCandidates.docs.forEach((document) => document.reference.delete());

      var callerCandidates = await roomRef.collection('callerCandidates').get();
      callerCandidates.docs.forEach((document)async => await document.reference.delete());

      await roomRef.delete();
    }

    localStream!.dispose();
    remoteStream?.dispose();
  }

  void registerPeerConnectionListeners() {



    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE gathering state changed: $state');
      antherPeerConnected= false;
    };

    peerConnection?.onConnectionState = (RTCPeerConnectionState state) {
      print('Connection state change: ${state.name}');
      antherPeerConnected= false;
      emit(PeerDisconnectState());
    };

    peerConnection?.onSignalingState = (RTCSignalingState state) {
      print('Signaling state change: $state');
    };

    peerConnection?.onIceGatheringState = (RTCIceGatheringState state) {
      print('ICE connection state change: $state');
    };

    peerConnection?.onAddStream = (MediaStream stream) {
      print("Add remote stream");
      // if(stream.active==true){
      //   print('====active');
      // }else{
      //   print('====active noooooooooooo');
      // }
        print('====active ${stream.getAudioTracks()}');

      onAddRemoteStream?.call(stream);
      remoteStream = stream;
      emit(ListenOnEventState());
    };

    peerConnection?.onTrack = (RTCTrackEvent event) {
      print('===got remote track: ${event.streams[0]}');

      event.streams[0].getTracks().forEach((track) {
        print('===got trackkkk ${track.muted}');

      });
    };

    emit(ListenOnEventState());
  }



  RTCDataChannel? dataChannel;

  Future<void> createDataChannel() async{
    RTCDataChannelInit config = RTCDataChannelInit();
    dataChannel = await peerConnection?.createDataChannel('cameraMicStatus', config);

    // Set up event listeners for the data channel
    dataChannel?.onMessage = (RTCDataChannelMessage message) {
      // Handle incoming messages related to camera/mic status
      // Parse the message and take action accordingly
      print('==============data channel create ${message}');
    };

  }


  // Sending data via data channel.
  Future<void> sendCameraMicStatus(bool cameraOpen, bool micOpen)async {
    Map<String, dynamic> status = {
      'cameraOpen': cameraOpen,
      'micOpen': micOpen,
    };
    String statusMessage = jsonEncode(status);

    // Create an RTCDataChannelMessage with the status message
    RTCDataChannelMessage message = RTCDataChannelMessage(statusMessage);

    print('=================data sending');
    // Send the message through the DataChannel
    await dataChannel?.send(message);
  }


  bool antherPeerMicOpen= false;
  bool antherPeerCameraOpen= false;
  // Receiving data from data channel.
  void listenForAntherPeerAudio() {
    FirebaseFirestore.instance.collection(isCaller? 'mobile' : 'emulator')
        .doc('micStatus').snapshots().listen((event) {
      print('=============camera miccccc Status ${event.data()!['micStatus']}');
      if(event.exists){
        if(event.data()!['micStatus']== true){
          antherPeerMicOpen= true;
        }else{
          antherPeerMicOpen= false;
        }
        emit(ListenForMicState());
      }else {
        antherPeerMicOpen= false;
        emit(ListenForMicState());
      }
    });
    // FirebaseDatabase.instance.ref(isCaller? 'mobile' : 'emulator').child('micStatus')
    //     .onValue.listen((event) {
    //
    //     });

    FirebaseFirestore.instance.collection(isCaller? 'mobile' : 'emulator')
        .doc('micStatus').snapshots().listen((event) {
      if(event.exists){
        print('=============camera Status ${event.data()!['cameraStatus']}');
        if(event.data()!['cameraStatus']== true){
          antherPeerCameraOpen= true;
        }else{
          antherPeerCameraOpen= false;
        }
        emit(ListenForCameraState());
      }else {
        antherPeerCameraOpen= false;
        emit(ListenForCameraState());
      }
    });
  }


  /// mobile => mic , cam
  Future<void> setStatusOfMicAndCamera({required bool micStatus, required bool cameraStatus})async{
    FirebaseFirestore.instance.collection(isCaller? 'emulator' : 'mobile')
        .doc('micStatus').set({
      'micStatus': micStatus,
      'cameraStatus': cameraStatus,
    });
  }



  bool isAudioOn= true;
  toggleMic() {
    setStatusOfMicAndCamera(micStatus: !isAudioOn, cameraStatus: isVideoOn).then((value) {
      // change status
      isAudioOn = !isAudioOn;
      // enable or disable audio track
      localStream?.getAudioTracks().forEach((track) {
        track.enabled = isAudioOn;
      });

      emit(ToggleMicState());
    });
  }

  bool isVideoOn= true;
  toggleCamera() {
    setStatusOfMicAndCamera(micStatus: isAudioOn, cameraStatus: !isVideoOn).then((value){
      // change status
      isVideoOn = !isVideoOn;
      // enable or disable video track
      localStream?.getVideoTracks().forEach((track) {
        track.enabled = isVideoOn;
      });

      emit(ToggleCameraState());
    });
  }


  void dispose() {
    localRenderer.dispose();
    remoteRenderer.dispose();
    peerConnection!.dispose();
  }
// void listenToAudio(){
//   remoteStream!.onRemoveTrack!(MediaStreamTrack as MediaStreamTrack ){
//
//   };
// }
}
