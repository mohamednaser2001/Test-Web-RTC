

 import 'package:order_now/core/utils/enums.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/custom_text.dart';

void showSnackBar({
  required BuildContext context,
  required String title,
  String? text,
  required ResponseState responseState,
})=> ScaffoldMessenger.of(context).showSnackBar(
   SnackBar(
     content: Container(
       padding: EdgeInsetsDirectional.only(start: 40.w, end: 10.w, top: 10.h, bottom: 10.h),
       width: double.infinity,
       decoration: BoxDecoration(
         borderRadius: BorderRadius.circular(12),
         color: checkSnackColor(responseState),
       ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           CustomText(
             text: title,
             size: 14.sp,
             color: Colors.white,
             fontWeight: FontWeight.w600,
           ),
           if(text!=null)
             CustomText(
             text: text,
             size: 12.sp,
             color: Colors.white,
             fontWeight: FontWeight.w400,
           ),
         ],
       ),
     ),
     dismissDirection: DismissDirection.up,
     elevation: 0.0,
     backgroundColor: Colors.transparent,
     duration: const Duration(milliseconds: 1000),
   ),
 );

Color checkSnackColor(ResponseState state){
  switch(state){
    case ResponseState.success:
      return Colors.green;
    case ResponseState.warning:
      return const Color(0xffFFCC00);
    case ResponseState.error:
      return Colors.red;
  }
}