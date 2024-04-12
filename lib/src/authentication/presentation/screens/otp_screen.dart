import 'dart:async';
import 'package:order_now/core/widgets/custom_button.dart';
import 'package:order_now/core/widgets/custom_text.dart';
import 'package:order_now/core/widgets/custom_text_button.dart';
import 'package:order_now/core/services/services_locator.dart';
import 'package:order_now/core/utils/color_manger.dart';
import 'package:order_now/src/authentication/presentation/controllers/otp/otp_bloc.dart';
import 'package:order_now/src/authentication/presentation/controllers/otp/otp_event.dart';
import 'package:order_now/src/authentication/presentation/controllers/otp/otp_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';




class OTPScreen extends StatelessWidget {

  TextEditingController pinFieldController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context)=> sl<OtpBloc>()..startTimer(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 20.h,),
                      CustomText(
                        size: 18.sp,
                        text: 'OTP VERIFICATION',
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      SizedBox(height: 40.h,),
                      CustomText(
                        size: 14.sp,
                        text: 'Enter the OTP sent to: ',
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                      CustomText(
                        size: 14.sp,
                        text: 'mohamed@gmail.com',
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),

                      SizedBox(height: 24.h,),

                      Form(
                        key: formKey,
                        child: PinCodeTextField(
                          appContext: context,
                          pastedTextStyle:const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                          length: 6,

                          animationType: AnimationType.fade,
                          validator: (v) {
                            if (v!.length < 6) {
                              return "Enter 4 numbers";
                            } else {
                              return null;
                            }
                          },
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.box,
                            borderRadius: BorderRadius.circular(6.r),
                            activeFillColor: Colors.white,
                            activeColor: Colors.black,
                            inactiveColor: Colors.grey,
                            selectedColor: AppColors.primaryColor,
                          ),
                          cursorColor: Colors.black,
                          animationDuration: const Duration(milliseconds: 300),
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20.sp,
                          ),
                          errorAnimationController: errorController,
                          controller: pinFieldController,
                          keyboardType: TextInputType.number,
                          onCompleted: (v) {

                          },

                          onChanged: (value) {

                          },
                          beforeTextPaste: (text) {
                            return true;
                          },
                        ),
                      ),

                      BlocBuilder<OtpBloc, OtpStates>(
                          buildWhen: (context, state)=> state is ChangeTimerState,
                          builder: (context, state) {
                          return CustomText(
                            size: 14.sp,
                            text: sl<OtpBloc>().remainingTime,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          );
                        }
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomText(
                            size: 14.sp,
                            text: 'Do\'t receive it? ',
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),

                          BlocBuilder<OtpBloc, OtpStates>(
                            builder:(context, state)=> CustomTextButton(
                            onPressed: (){
                              if(sl<OtpBloc>().remainingTime=='00:00'){
                                sl<OtpBloc>().startTimer();
                                print('object');
                              }
                            },
                            text: 'Resend',
                            textColor: sl<OtpBloc>().remainingTime!='00:00'? Colors.grey[600]! : Colors.grey[900]!,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h,),
                      CustomButton(
                        text: 'Verify',
                        elevation: 0.0,
                        radius: 10.r,
                        function: (){},
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.25.h,
                      ),

                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}





