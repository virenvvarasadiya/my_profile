import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/presentation/Model/profile_model.dart';
import 'package:my_profile/presentation/bloc/profile_bloc.dart';
import 'package:my_profile/presentation/common/common_button.dart';
import 'package:my_profile/presentation/common/common_text_field.dart';
import 'package:my_profile/presentation/pages/edit_view/widgets/experiance_widget.dart';
import 'package:my_profile/utils/common_spacer.dart';
import 'package:my_profile/utils/validator.dart';

class AddExperienceScreen extends StatefulWidget {
  const AddExperienceScreen({super.key});

  @override
  State<AddExperienceScreen> createState() => _AddExperienceScreenState();
}

class _AddExperienceScreenState extends State<AddExperienceScreen> {
  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Experience"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonTextField(
                        hintText: "Enter company name",
                        labelText: "Company name",
                        controller: profileBloc.exNameCtr,
                      ),
                      height(10),
                      CommonTextField(
                        hintText: "Enter designation",
                        labelText: "Designation",
                        controller: profileBloc.exDesignationCtr,
                      ),
                      height(10),
                      CommonTextField(
                        hintText: "Start date",
                        labelText: "Start date",
                        readOnly: true,
                        controller: profileBloc.startDate,
                        onTap: () {
                          selectDate(context,
                                  initialDate: profileBloc.startDate.text.isEmpty
                                      ? null
                                      : DateTime.parse(profileBloc.startDate.text))
                              .then((value) {
                            if (value.isNotEmpty) {
                              profileBloc.startDate.text = value;
                            }
                          });
                        },
                      ),
                      height(10),
                      CommonTextField(
                        hintText: "End date",
                        labelText: "End date",
                        readOnly: true,
                        controller: profileBloc.endDate,
                        onTap: () {
                          selectDate(context,
                                  startDate: DateTime.parse(profileBloc.startDate.text),
                                  initialDate: profileBloc.endDate.text.isEmpty
                                      ? null
                                      : DateTime.parse(profileBloc.endDate.text))
                              .then((value) {
                            if (value.isNotEmpty) {
                              profileBloc.endDate.text = value;
                            }
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              CommonButton(
                buttonText: "Add",
                onTap: () async {
                  if (profileBloc.exNameCtr.text.isEmpty) {
                    showToast("Please enter company name!");
                  } else if (profileBloc.exDesignationCtr.text.isEmpty) {
                    showToast("Please enter designation!");
                  } else if (profileBloc.startDate.text.isEmpty) {
                    showToast("Please enter start date!");
                  } else if (profileBloc.endDate.text.isEmpty) {
                    showToast("Please enter end date!");
                  } else {
                    profileBloc.profileModel.experience ??= [];

                    profileBloc.profileModel.experience?.add(Experience(
                        endDate: profileBloc.endDate.text,
                        startDate: profileBloc.startDate.text,
                        designation: profileBloc.exDesignationCtr.text,
                        companyName: profileBloc.exNameCtr.text));
                    Navigator.pop(context);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
