import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_profile/presentation/bloc/profile_bloc.dart';
import 'package:my_profile/presentation/pages/edit_view/widgets/add_experiance_screen.dart';
import 'package:my_profile/utils/app_color.dart';
import 'package:my_profile/utils/common_spacer.dart';

class ExperienceWidget extends StatefulWidget {
  const ExperienceWidget({super.key});

  @override
  State<ExperienceWidget> createState() => _ExperienceWidgetState();
}

class _ExperienceWidgetState extends State<ExperienceWidget> {
  @override
  void initState() {
    final profileBloc = context.read<ProfileBloc>();
    clearData(profileBloc);
    super.initState();
  }

  clearData(ProfileBloc profileBloc) {
    profileBloc.startDate.clear();
    profileBloc.endDate.clear();
    profileBloc.exNameCtr.clear();
    profileBloc.exDesignationCtr.clear();
  }

  @override
  Widget build(BuildContext context) {
    final profileBloc = context.read<ProfileBloc>();
    return Column(
      children: [
        profileBloc.profileModel.experience?.isEmpty ?? true
            ? const SizedBox.shrink()
            : Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: AppColor.grey.withOpacity(0.15)),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(profileBloc.profileModel.experience![index].designation ?? "-",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600)),
                              height(2),
                              Text(profileBloc.profileModel.experience![index].companyName ?? "-",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400)),
                              Text(
                                  "${profileBloc.profileModel.experience![index].startDate ?? "-"} - ${profileBloc.profileModel.experience![index].endDate ?? "-"}",
                                  style: TextStyle(
                                      color: AppColor.black,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400)),
                            ],
                          ),
                          profileBloc.profileModel.experience!.length > 2
                              ? InkWell(
                                  onTap: () {
                                    profileBloc.add(ChangeForEditEvent(true));
                                    setState(() {
                                      profileBloc.profileModel.experience!.removeAt(index);
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: AppColor.red,
                                    size: 25,
                                  ))
                              : const SizedBox.shrink()
                        ],
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColor.grey,
                      );
                    },
                    itemCount: profileBloc.profileModel.experience?.length ?? 0),
              ),
        height(10),
        InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            clearData(profileBloc);
            profileBloc.add(ChangeForEditEvent(true));
            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddExperienceScreen()))
                .then((value) {
              setState(() {});
            });
          },
          child: Container(
              width: MediaQuery.of(context).size.width * 0.5,
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: AppColor.grey.withOpacity(0.15)),
              child: Center(
                child: profileBloc.profileModel.experience?.isEmpty ?? true
                    ? const Text("+ Add")
                    : const Text("+ Add more"),
              )),
        ),
        height(10),
      ],
    );
  }
}

showToast(msg) {
  EasyLoading.showToast(msg, toastPosition: EasyLoadingToastPosition.top);
}
