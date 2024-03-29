import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/presentation/bloc/profile_bloc.dart';
import 'package:my_profile/presentation/common/common_text_field.dart';

class EmailWidget extends StatelessWidget {
  const EmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return CommonTextField(
      hintText: "Enter email",
      labelText: "Email",
      controller: profileBloc.emailController,
      onChanged: (val) {
        if (val.trim().isNotEmpty) {
          profileBloc.add(ChangeForEditEvent(true));
          profileBloc.profileModel.email = val;
        }
      },
    );
  }
}
