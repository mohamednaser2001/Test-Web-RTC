import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:order_now/configrations/routes/app_routes.dart';
import 'package:order_now/core/methods/navigation_method.dart';
import 'package:order_now/core/services/services_locator.dart';
import 'package:order_now/src/authentication/data/authentication_datasource/authentication_remote_datasource.dart';
import 'package:order_now/src/authentication/data/authentication_repository_imp/authentication_repository.dart';
import 'package:order_now/src/authentication/domain/repositories/base_authentication_repository.dart';
import 'package:order_now/src/authentication/domain/usecases/login_usecase.dart';
import 'package:order_now/src/authentication/presentation/screens/login_screen.dart';
import 'package:order_now/src/authentication/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_now/src/chat/presentation/test_web_rtc/webretc_screen.dart';

import 'core/services/call_kit_service.dart';
import 'src/authentication/presentation/screens/otp_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  await CallKitService.displayCallDialog({
    'roomId': message.data['roomId'],
    'type': message.data['type'],
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  ServicesLocator().init();
  // Bloc.observer = MyBlocObserver();


  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAAqr3atbKemRZsnqpQlJO4xe2F0Em-BnM",
        authDomain: "order-now-8c866.firebaseapp.com",
        projectId: "order-now-8c866",
        storageBucket: "order-now-8c866.appspot.com",
        messagingSenderId: "429516510293",
        appId: "1:429516510293:web:4718dd4a93856ad18830dc"),
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Received message while app is in the foreground:');
    print('Message data: ${message.data}');
    print('Notification title: ${message.notification?.title}');
    print('Notification body: ${message.notification?.body}');

    CallKitService.displayCallDialog({
      'roomId': message.data['roomId'],
      'type': message.data['type'],
    });
    // Handle the incoming message as needed
  });


  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);



  await FirebaseMessaging.instance.getToken().then((value) {
    print('token: $value');
  });


  runApp(TestWebRTCScreen());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.registerRoute,
          onGenerateRoute: AppRoutes.onGeneratedRoute,
          title: 'Order Now',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      //child: RegisterScreen(),
    );
  }
}
