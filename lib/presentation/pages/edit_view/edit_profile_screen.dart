import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_profile/presentation/Model/profile_model.dart';
import 'package:my_profile/presentation/bloc/profile_bloc.dart';
import 'package:my_profile/presentation/common/common_button.dart';
import 'package:my_profile/presentation/pages/edit_view/widgets/email_widget.dart';
import 'package:my_profile/presentation/pages/edit_view/widgets/experiance_widget.dart';
import 'package:my_profile/presentation/pages/edit_view/widgets/name_widget.dart';
import 'package:my_profile/presentation/pages/edit_view/widgets/skill_widget.dart';
import 'package:my_profile/utils/app_color.dart';
import 'package:my_profile/utils/common_spacer.dart';

@RoutePage()
class EditProfileScreen extends StatefulWidget {
  final String? fieldType;
  final ProfileModel? profileModel;

  const EditProfileScreen({super.key, this.fieldType, this.profileModel});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return WillPopScope(
      onWillPop: () async {
        if (profileBloc.isChanged) {
          showDialog(
            context: context,
            builder: (context) {
              return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                child: Dialog(
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Alert!",
                          style: TextStyle(
                              color: AppColor.black, fontWeight: FontWeight.w800, fontSize: 20),
                        ),
                        height(5),
                        Divider(
                          color: AppColor.black.withOpacity(0.5),
                        ),
                        height(5),
                        Text(
                          "Are you sure you want to discard your changes?",
                          style: TextStyle(
                              color: AppColor.black, fontWeight: FontWeight.w400, fontSize: 16),
                        ),
                        height(30),
                        Row(
                          children: [
                            Expanded(
                                child: CommonButton(
                              radius: 8,
                              vertical: 6,
                              buttonText: "Cancel",
                              backGroundColor: Colors.transparent,
                              textColor: AppColor.blue,
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )),
                            width(8),
                            Expanded(
                                child: CommonButton(
                              radius: 8,
                              vertical: 6,
                              buttonText: "Discard",
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                                profileBloc.add(ChangeForEditEvent(false));
                                profileBloc.add(FetchProfileDataEvent());
                              },
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return true;
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Edit ${widget.fieldType ?? ""}"),
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final profileBloc = context.read<ProfileBloc>();
            if (state is EditProfileSuccessState) {
              profileBloc.add(FetchProfileDataEvent());
              Future.delayed(const Duration(milliseconds: 200))
                  .then((value) => Navigator.pop(context));
            } else if (state is EditProfileFailState) {
              EasyLoading.showError(state.error);
              context.read<ProfileBloc>().add(InitialEvent());
            }
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            getAssignView(profileBloc),
                          ],
                        ),
                      ),
                    ),
                    height(10),
                    CommonButton(
                      buttonText: "Save",
                      onTap: () async {
                        profileBloc.add(ChangeForEditEvent(false));
                        profileBloc.add(EditProfileDataEvent(profileBloc.profileModel));
                      },
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  getAssignView(ProfileBloc profileBloc) {
    String fieldType = widget.fieldType ?? "";
    switch (fieldType) {
      case "Name":
        return const NameWidget();
      case "Email":
        return const EmailWidget();
      case "Skills":
        return const SkillWidget();
      case "Experience":
        return ExperienceWidget();
      default:
        return const Text('Not found');
    }
  }
}
