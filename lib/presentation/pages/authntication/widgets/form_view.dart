import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/presentation/bloc/profile_bloc.dart';
import 'package:my_profile/presentation/common/common_button.dart';
import 'package:my_profile/presentation/common/common_text_field.dart';
import 'package:my_profile/route/app_router.dart';
import 'package:my_profile/utils/app_color.dart';
import 'package:my_profile/utils/app_strings.dart';
import 'package:my_profile/utils/common_spacer.dart';
import 'package:my_profile/utils/validator.dart';

class LoginFormView extends StatelessWidget {
  const LoginFormView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "LOGIN",
          style: TextStyle(
              fontWeight: FontWeight.w900, fontSize: 28, color: AppColor.black, letterSpacing: 5),
        ),
        height(30),
        CommonTextField(
          hintText: "Enter email",
          controller: profileBloc.emailCtr,
          validation: (val) {
            if (val.isEmpty) {
              return AppString.emailEmptyValidate;
            } else if (val.trim().isValidEmail() == false) {
              return AppString.emailValidValidate;
            } else {
              return null;
            }
          },
        ),
        height(10),
        CommonTextField(
          hintText: "Enter password",
          controller: profileBloc.passCtr,
          obscureText: profileBloc.isVisible,
          validation: (val) {
            if (val.isEmpty) {
              return AppString.passwordValidation;
            }
            if (val.length < 8) {
              return AppString.passwordValidationLength;
            }
            if (!validatePassword(val)) {
              return AppString.validPassword;
            }
          },
          suffixIcon: InkWell(
            borderRadius: BorderRadius.circular(22),
            onTap: () {
              profileBloc.add(PasswordVisibleEvent());
            },
            child: Icon(
              !profileBloc.isVisible ? Icons.visibility_off : Icons.visibility,
              color: Colors.black,
            ),
          ),
        ),
        Row(
          children: [
            Checkbox(value: profileBloc.isRemember, onChanged: (value) {
              profileBloc.add(RememberMeEvent());
            },),
            const Text(
              "Remember me",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        height(30),
        CommonButton(
          buttonText: "Login",
          onTap: () async {
            if (profileBloc.loginFormKey.currentState!.validate()) {
              context.router.push(const HomeRoute());
            }
          },
        )
      ],
    );
  }

  bool validatePassword(String password) {
    // Define a regular expression for the password criteria
    RegExp regex = RegExp(
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+{}|":<>?/\\-])[\w!@#$%^&*()_+{}|":<>?/\\-]{8,}$');

    // Test if the password matches the criteria
    return regex.hasMatch(password);
  }
}
