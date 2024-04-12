import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:order_now/core/methods/navigation_method.dart';
import 'package:order_now/src/chat/presentation/test_web_rtc/ringing_screen.dart';
import 'package:order_now/src/chat/presentation/test_web_rtc/signaling.dart';
import 'package:order_now/src/chat/presentation/test_web_rtc/signaling_cubit.dart';
import 'package:http/http.dart' as http;



class TestWebRTCScreen extends StatelessWidget with WidgetsBindingObserver  {
  // This widget is the root of your application.
  static final navKey = GlobalKey<NavigatorState>();



  getCurrentCall() async {
    //check current call from pushkit if possible
    var calls = await FlutterCallkitIncoming.activeCalls();
    final objCalls = json.decode(calls);
    if (objCalls is List) {
      if (objCalls.isNotEmpty) {
        // this._currentUuid = objCalls[0]['id'];
        return objCalls[0];
      } else {
        // this._currentUuid = "";
        return null;
      }
    }
  }

  checkAndNavigationCallingPage() async {
    var currentCall = await getCurrentCall();
    if (currentCall != null) {
      navigateTo(navKey, TestWebRTCScreen());
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {

    if (state == AppLifecycleState.resumed) {
      //Check call when open app from background
      checkAndNavigationCallingPage();
    }
  }


  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Web RTC Demo',
          home: child,
        );
      },
      child:  RingingScreen(),
    );
  }
}

class MyHomePage extends StatelessWidget {

  String roomId;
  bool isCaller;
  TextEditingController textEditingController = TextEditingController(text: '');

  MyHomePage({super.key, required this.roomId, required this.isCaller});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignalingCubit(roomId: roomId, isCaller: isCaller),
  child: Scaffold(

      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [


            Stack(
              children: [
                SizedBox(
                    // color: Colors.red,
                    height: double.infinity,
                    width: double.infinity,
                    child: BlocConsumer<SignalingCubit, SignalingStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          return context.read<SignalingCubit>().antherPeerCameraOpen
                              ? RTCVideoView(
                            objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                              context
                                  .read<SignalingCubit>()
                                  .remoteRenderer)
                              : Container(
                            color: Colors.grey,
                            width: double.infinity,
                            height: double.infinity,
                            child: Image.asset('assets/icons/user.png'),
                          );
                        }
                    )),

                BlocConsumer<SignalingCubit, SignalingStates>(
                    listener: (context, state) {},
                    builder: (context, state) {
                      return context.read<SignalingCubit>().antherPeerMicOpen
                          ? const SizedBox()
                          :Positioned(
                        top: 10,
                        left: 10,
                        child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            radius: 14.r,
                            child: Icon(Icons.mic_off_rounded,
                              color: Colors.grey, size: 16.r,)
                        ),
                      );
                    }
                )
              ],
            ),


            /// Current peer
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30.0.h, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  BlocConsumer<SignalingCubit, SignalingStates>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        return Container(
                          width: 100.w,
                          height: 200.h,
                          // padding: EdgeInsets.all(20),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10)),
                          child: context.read<SignalingCubit>().isVideoOn
                              ? RTCVideoView(
                            objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                              context
                                  .read<SignalingCubit>()
                                  .localRenderer,
                              mirror: true)
                              : Container(
                            color: Colors.green[500],
                            width: double.infinity,
                            height: double.infinity,
                            padding: EdgeInsets.all(20.w),
                            child: Image.asset('assets/icons/user.png'),
                          ));
                    }
                  ),

                  SizedBox(height: 20.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocConsumer<SignalingCubit, SignalingStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                context.read<SignalingCubit>().toggleMic();
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[600],
                                child: Icon(context.read<SignalingCubit>().isAudioOn
                                    ? Icons.mic_rounded
                                    : Icons.mic_off_rounded,
                                  color: Colors.white, size: 20.r,
                                ),
                              ),
                            );
                          }),
                      SizedBox(
                        width: 20.w,
                      ),
                      BlocConsumer<SignalingCubit, SignalingStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return InkWell(
                              onTap: () {
                                context.read<SignalingCubit>().toggleCamera();
                              },
                              child: CircleAvatar(
                                backgroundColor: Colors.grey[600],
                                child: Icon(context.read<SignalingCubit>().isVideoOn
                                  ? Icons.videocam
                                  : Icons.videocam_off_outlined, color: Colors.white, size: 20.r,)
                              ),
                            );
                          }),

                      SizedBox(
                        width: 20.w,
                      ),
                      BlocConsumer<SignalingCubit, SignalingStates>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return InkWell(
                            onTap: () async{
                              await context.read<SignalingCubit>().hangUp(context.read<SignalingCubit>().localRenderer);
                              Navigator.pop(context);
                              },
                            child: CircleAvatar(
                                backgroundColor: Colors.redAccent,
                                child: Icon(Icons.call_end, color: Colors.white, size: 20.r,)
                            ),
                          );
                        }
                      )
                    ],
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    ),
);
  }
}
