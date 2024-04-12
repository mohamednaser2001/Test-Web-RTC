import 'package:order_now/configrations/routes/app_routes.dart';
import 'package:order_now/core/widgets/custom_button.dart';
import 'package:order_now/core/widgets/custom_text.dart';
import 'package:order_now/core/widgets/custom_text_button.dart';
import 'package:order_now/core/widgets/custom_text_form_field.dart';
import 'package:order_now/core/utils/color_manger.dart';
import 'package:order_now/core/utils/enums.dart';
import 'package:order_now/src/authentication/presentation/controllers/register/register_bloc.dart';
import 'package:order_now/src/authentication/presentation/controllers/register/register_event.dart';
import 'package:order_now/src/authentication/presentation/controllers/register/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:order_now/core/services/services_locator.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  // var phoneController = TextEditingController();
  // var lastNameController = TextEditingController();
  var firstNameController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RegisterBloc>(),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.w),
              child: ListView(

                children: [
                  CustomText(
                    text: 'Register',
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

                  CustomText(
                    text: 'First Name',
                    size: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  CustomTextFormField(
                    controller: firstNameController,
                    verticalPadding: 10.h,
                    enabledBorderColor: AppColors.tffBorderColor,
                    radius: 6,
                    hintColor: Colors.black,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your first name';
                      } else {
                        return null;
                      }
                    },
                    context: context,
                  ),


                  SizedBox(
                    height: 10.0.h,
                  ),

                  // CustomText(
                  //   text: 'Last Name',
                  //   size: 13.sp,
                  //   color: Colors.black,
                  //   fontWeight: FontWeight.w600,
                  // ),
                  // SizedBox(
                  //   height: 2.0.h,
                  // ),
                  // CustomTextFormField(
                  //   controller: lastNameController,
                  //   verticalPadding: 10.h,
                  //   enabledBorderColor: AppColors.tffBorderColor,
                  //   radius: 6,
                  //   hintColor: Colors.black,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Enter your last name';
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  //   context: context,
                  // ),

                  SizedBox(
                    height: 10.0.h,
                  ),
                  // CustomText(
                  //   text: 'Phone',
                  //   size: 13.sp,
                  //   color: Colors.black,
                  //   fontWeight: FontWeight.w600,
                  // ),
                  // SizedBox(
                  //   height: 2.0.h,
                  // ),
                  // CustomTextFormField(
                  //   controller: phoneController,
                  //   inputType: TextInputType.phone,
                  //   verticalPadding: 10.h,
                  //   textType: InputType.number,
                  //   enabledBorderColor: AppColors.tffBorderColor,
                  //   radius: 6,
                  //   hintColor: Colors.black,
                  //   validator: (value) {
                  //     if (value!.isEmpty) {
                  //       return 'Enter your phone';
                  //     } else if (value.length != 11) {
                  //       return 'Phone number must be 11 number';
                  //     } else{
                  //       return null;
                  //     }
                  //   },
                  //   context: context,
                  // ),
                  //
                  // SizedBox(
                  //   height: 10.0.h,
                  // ),

                  CustomText(
                    text: 'Email',
                    size: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  CustomTextFormField(
                    controller: emailController,
                    inputType: TextInputType.emailAddress,
                    verticalPadding: 10.h,
                    enabledBorderColor: AppColors.tffBorderColor,
                    radius: 6,
                    hintColor: Colors.black,
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
                    height: 10.0.h,
                  ),


                  CustomText(
                    text: 'Password',
                    size: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  CustomTextFormField(
                    controller: passwordController,
                    verticalPadding: 10.h,
                    enabledBorderColor: AppColors.tffBorderColor,
                    radius: 6,
                    hintColor: Colors.black,
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
                    height: 10.0.h,
                  ),
                  CustomText(
                    text: 'Confirm Password',
                    size: 13.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 2.0.h,
                  ),
                  CustomTextFormField(
                    controller: confirmPasswordController,
                    verticalPadding: 10.h,
                    enabledBorderColor: AppColors.tffBorderColor,
                    radius: 6,
                    hintColor: Colors.black,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter your password';
                      } else if(value.trim() != passwordController.text.trim()){
                        return 'Not the same password';
                      }else {
                        return null;
                      }
                    },
                    context: context,
                  ),


                  SizedBox(
                    height: 50.0.h,
                  ),
                  CustomButton(
                    text: 'Register',
                    radius: 8.r,
                    height: 40.h,
                    function: () {
                      // if (formKey.currentState!.validate()) {
                        sl<RegisterBloc>().add(RegisterEvent(
                          name: firstNameController.text.trim(),
                          // lName: lastNameController.text.trim(),
                          // phone: phoneController.text.trim(),
                          email: emailController.text.trim(),
                          password: passwordController.text.trim(),
                          context: context,
                        ));
                      // }
                    },
                  ),
                  BlocBuilder<RegisterBloc, RegisterStates>(
                    builder: (context, state) {
                      return state.registerState == RequestState.loading? Column(
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
                    height: 10.0.h,
                  ),
                  Row(
                    children: [
                      CustomText(
                        text: 'Have an account? ',
                        size: 13.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),

                      CustomTextButton(
                          text: 'Login',
                          onPressed: (){
                            Navigator.pushNamed(context, Routes.loginRoute);
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
