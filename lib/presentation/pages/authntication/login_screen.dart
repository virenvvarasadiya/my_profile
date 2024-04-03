import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/presentation/bloc/profile_bloc.dart';
import 'package:my_profile/presentation/pages/authntication/widgets/form_view.dart';
import 'package:my_profile/storage_service/storage_keys.dart';
import 'package:my_profile/storage_service/storage_sevice.dart';

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  void initState() {
    final profileBloc = context.read<ProfileBloc>();
    profileBloc.emailCtr.clear();
    profileBloc.passCtr.clear();
    profileBloc.isVisible = true;
    final isRemember = StorageService.read(key: StorageKeys.isRemember) ?? false;
    profileBloc.add(RememberMeEvent(isRemember: isRemember));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final profileBloc = context.read<ProfileBloc>();
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
              child: Form(
                key: profileBloc.loginFormKey,
                child: LoginFormView(),
              ),
            ),
          );
        },
      ),
    );
  }
}
