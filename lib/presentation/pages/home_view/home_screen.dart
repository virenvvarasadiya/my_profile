import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_profile/presentation/Model/profile_model.dart';
import 'package:my_profile/presentation/bloc/profile_bloc.dart';
import 'package:my_profile/presentation/common/common_text_field.dart';
import 'package:my_profile/presentation/pages/home_view/widgets/profile_pick.dart';
import 'package:my_profile/route/app_router.dart';
import 'package:my_profile/storage_service/storage_sevice.dart';
import 'package:my_profile/utils/app_color.dart';
import 'package:my_profile/utils/common_spacer.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<ProfileBloc>().add(FetchProfileDataEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final profileBloc = context.read<ProfileBloc>();

          if (state is FetchProfileLoadingState) {
            EasyLoading.show();
          } else if (state is PickImageSuccessState) {
            profileBloc.add(EditProfileDataEvent(ProfileModel(image: profileBloc.filePath)));
          } else if (state is FetchProfileFailState) {
            EasyLoading.showError(state.error);
            context.read<ProfileBloc>().add(InitialEvent());
          }else if (state is PickImageFailState) {
            EasyLoading.showError("unable to pick image!");
            context.read<ProfileBloc>().add(InitialEvent());
          }else if (state is EditProfileFailState) {
            EasyLoading.showError(state.error);
            context.read<ProfileBloc>().add(InitialEvent());
          }
          return SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        EasyLoading.show();
                        StorageService.eraseData();
                        profileBloc.add(RememberMeEvent(isRemember: false));
                        Future.delayed(const Duration(milliseconds: 500)).then((value){
                          EasyLoading.dismiss();
                        context.router.replace(const LoginRoute());
                        });
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: AppColor.grey.withOpacity(0.2)),
                          padding: const EdgeInsets.all(8),
                          child: const Padding(
                            padding: EdgeInsets.only(left: 3.0),
                            child: Center(
                                child: Icon(
                              Icons.logout,
                              size: 22,
                            )),
                          )),
                    )
                  ],
                ),
                height(30),
                ProfilePictureView(filePath: profileBloc.filePath,),
                height(30),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        CommonTextField(
                          hintText: "Enter name",
                          labelText: "Name",
                          controller: profileBloc.nameCtr,
                          readOnly: true,
                          onTapEdit: () {
                            context.router.push(EditProfileRoute(fieldType: "Name"));
                          },
                        ),
                        height(10),
                        CommonTextField(
                          hintText: "Enter email",
                          labelText: "Email",
                          controller: profileBloc.emailController,
                          readOnly: true,
                          onTapEdit: () {
                            context.router.push(EditProfileRoute(fieldType: "Email"));
                          },
                        ),
                        height(10),
                        CommonTextField(
                          hintText: "Enter skills",
                          labelText: "Skills",
                          controller: profileBloc.skillCtr,
                          readOnly: true,
                          onTapEdit: () {
                            context.router.push(EditProfileRoute(fieldType: "Skills"));
                          },
                        ),
                        height(10),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, right: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Work experience",
                                  style: TextStyle(color: Colors.black, fontSize: 14)),
                              InkWell(
                                  borderRadius: BorderRadius.circular(20),
                                  onTap: () {
                                    context.router.push(EditProfileRoute(fieldType: "Experience"));
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(Icons.edit_outlined),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(22),
                              color: AppColor.grey.withOpacity(0.15)),
                          child: profileBloc.experienceList.isNotEmpty
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(profileBloc.experienceList[index].designation ?? "-",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600)),
                                        height(2),
                                        Text(profileBloc.experienceList[index].companyName ?? "-",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400)),
                                        Text("${profileBloc.experienceList[index].startDate ?? "-"} - ${profileBloc.experienceList[index].endDate ?? "-"}",
                                            style: TextStyle(
                                                color: AppColor.black,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w400)),
                                      ],
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return Divider(
                                      color: AppColor.grey,
                                    );
                                  },
                                  itemCount: profileBloc.experienceList.length)
                              : const Text("No experience available!"),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
        },
      ),
    );
  }
}
