

import 'package:order_now/src/authentication/presentation/screens/login_screen.dart';
import 'package:order_now/src/authentication/presentation/screens/otp_screen.dart';
import 'package:order_now/src/authentication/presentation/screens/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:order_now/src/chat/presentation/screens/chat_screen.dart';
import 'package:order_now/src/chat/presentation/screens/messages_screen.dart';

class Routes {
  static const String registerRoute= '/';
  static const String loginRoute= '/login';
  static const String otpRoute= '/otp';
  static const String chat= '/chat';
  static const String messagesScreen= '/messages';
}



class AppRoutes {
  static Route<dynamic>? onGeneratedRoute(RouteSettings routeSettings){
    switch(routeSettings.name){
      case Routes.registerRoute: return MaterialPageRoute(builder: (context)=> RegisterScreen());
      case Routes.loginRoute: return MaterialPageRoute(builder: (context)=> LoginScreen());
      case Routes.otpRoute: return MaterialPageRoute(builder: (context)=> OTPScreen());
      case Routes.chat: return MaterialPageRoute(builder: (context)=> ChatScreen());
      case Routes.messagesScreen: return MaterialPageRoute(builder: (context)=> MessagesScreen());

      //default: return undefinedRoute();
    }
  }


  static Route<dynamic> undefinedRoute(){
    return MaterialPageRoute(builder:  (context)=> const Scaffold(
      body: Text('No page founded'),
    ));
  }
}