import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:order_now/core/methods/navigation_method.dart';
import 'package:order_now/src/chat/presentation/test_web_rtc/webretc_screen.dart';
import 'package:uuid/uuid.dart';
class RingingScreen extends StatelessWidget {
  RingingScreen({Key? key}) : super(key: key);



  TextEditingController controller= TextEditingController();

  @override
  Widget build(BuildContext context) {

    listenToCalls(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [


              ElevatedButton(
                onPressed: () async{

                  String roomId= const Uuid().v4();
                  final message = {
                    'notification': {
                      'title': 'Title of the Notification',
                      'body': 'Body of the Notification',
                    },
                    'data': {
                      'roomId': roomId,
                      'type': 'Call',
                    },
                    'to': 'dPbsH4HURTWF8CDj6tGGcp:APA91bGLCK6Fh3dc2v94AasbolySQtbVQzh8BQkiOO6Q_xqZ5AHORmNw9REUBWy7YJMcJwEWtL_-CC55N9k8V32IUKJcKPYAETFo8fuxoJ_B0wpDpsqx5N_61mwlqBdQWQ_4kyhxw74u', // Pass the device token here
                  };

                  print('===res response $roomId');

                  // navigateTo(context, MyHomePage(roomId: '18e851fa-db62-4bd9-a4e5-e25a7021d943', isCaller: false));
                  Map<String, String> headers= {
                    'Authorization': 'key=AAAAZAEt1FU:APA91bEPO-iZKxT8Ip7zR-O5JNmaP_IG_Ud9Zgi4HFKRapIphPHveYPxc8Or4P_LUhnf3-eJFy683SAnFiAAzV3wHNad87ZEYHR2d9FXQGSfEuFalv2Nl_RCpyvtEOa4dyun8LtbBjWt',
                    'Content-Type': 'application/json'
                  };
                  // Send the message using your server or Firebase Cloud Messaging API
                  // HTTP POST request to FCM endpoint with the message payload
                  // Example: Use package like http to make the POST request
                  Uri url= Uri.parse('https://fcm.googleapis.com/fcm/send');
                  http.Response response= await http.post(url, body: json.encode(message), headers: headers);
                  print('===res response $response');
                  print('===res response ${response.statusCode}');
                  print('===res response ${jsonDecode(response.body)}');
                  if(response.statusCode==200 || response.statusCode==201){
                    navigateTo(context, MyHomePage(roomId: roomId, isCaller: true,));
                  }else{
                    print('Error when sending notification');
                  }

                },
                child: Text("Call User"),
              ),
            ],
          ),
        ),
      ),
    );
  }


  listenToCalls(BuildContext context){
    FlutterCallkitIncoming.onEvent.listen((CallEvent? event) {
      switch (event!.event) {
        case Event.actionCallIncoming:
        // TODO: received an incoming call
          print('==call actionCallIncoming');
          break;
        case Event.actionCallStart:
          print('==call actionCallStart');
          // TODO: started an outgoing call
          // TODO: show screen calling in Flutter

          break;
        case Event.actionCallAccept:
        // TODO: accepted an incoming call
        // TODO: show screen calling in Flutter
          print('==call actionCallAccept ${event.body['extra']['roomId']}');
          navigateTo(context, MyHomePage(isCaller: false, roomId: event.body['extra']['roomId'],));
          break;
        case Event.actionCallDecline:
        // TODO: declined an incoming call
          print('==call actionCallDecline');
          print('==call ${event.body['extra']['roomId']}');
          FlutterCallkitIncoming.endAllCalls();


          break;
        case Event.actionCallEnded:
        // TODO: ended an incoming/outgoing call
          break;
        case Event.actionCallTimeout:
        // TODO: missed an incoming call
          break;
        case Event.actionCallCallback:
        // TODO: only Android - click action `Call back` from missed call notification
          break;
        case Event.actionCallToggleHold:
        // TODO: only iOS
          break;
        case Event.actionCallToggleMute:
        // TODO: only iOS
          break;
        case Event.actionCallToggleDmtf:
        // TODO: only iOS
          break;
        case Event.actionCallToggleGroup:
        // TODO: only iOS
          break;
        case Event.actionCallToggleAudioSession:
        // TODO: only iOS
          break;
        case Event.actionDidUpdateDevicePushTokenVoip:
        // TODO: only iOS
          break;
        case Event.actionCallCustom:
        // TODO: for custom action
          break;
      }
    });
  }

}
