import 'package:order_now/core/widgets/custom_button.dart';
import 'package:order_now/core/widgets/custom_text.dart';
import 'package:order_now/core/widgets/custom_text_button.dart';
import 'package:order_now/core/widgets/custom_text_form_field.dart';
import 'package:order_now/core/utils/color_manger.dart';
import 'package:order_now/core/utils/enums.dart';
import 'package:order_now/src/authentication/presentation/controllers/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_now/core/services/services_locator.dart';
import '../controllers/login/login_event.dart';
import '../controllers/login/login_state.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<LoginBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Login',
                    size: 28.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: 'Welcome Back!',
                    size: 15.sp,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CustomText(
                      text: 'Email',
                      size: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    verticalPadding: 12.h,
                    enabledBorderColor: AppColors.tffBorderColor,
                    radius: 6,
                    hintColor: Colors.black,
                    horizontalPadding: 2.w,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter email address';
                      } else {
                        return null;
                      }
                    },
                    context: context,
                  ),
                  SizedBox(
                    height: 20.0.h,
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: CustomText(
                      text: 'Password',
                      size: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    verticalPadding: 12.h,
                    enabledBorderColor: AppColors.tffBorderColor,
                    radius: 6,
                    hintColor: Colors.black,
                    horizontalPadding: 2.w,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      } else {
                        return null;
                      }
                    },
                    context: context,
                  ),
                  SizedBox(
                    height: 50.0.h,
                  ),
                  CustomButton(
                    text: 'Login',
                    radius: 8.r,
                    height: 40.h,
                    function: () {
                      // if (formKey.currentState!.validate()) {
                        sl<LoginBloc>().add(LoginEvent(
                          context: context,
                            email: emailController.text.trim(),
                            password: passwordController.text.trim()));
                      // }
                    },
                  ),
                  BlocBuilder<LoginBloc, LoginStates>(
                    builder: (context, state) {
                      return state.loginState== RequestState.loading? Column(
                        children: [
                          SizedBox(
                            height: 6.0.h,
                          ),
                          const LinearProgressIndicator(
                            color: Colors.black,
                          ),
                        ],
                      ) : const SizedBox();
                    },
                  ),

                  SizedBox(
                    height: 20.0.h,
                  ),
                  Row(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: CustomText(
                          text: 'Don\'t have an account? ',
                          size: 14.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      CustomTextButton(
                          text: 'Register',
                          onPressed: (){

                          }),
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
