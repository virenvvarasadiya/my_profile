import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_profile/presentation/Model/profile_model.dart';
import 'package:my_profile/presentation/common/image_pick_crop.dart';
import 'package:my_profile/storage_service/storage_keys.dart';
import 'package:my_profile/storage_service/storage_sevice.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<InitialEvent>(refreshBloc);
    on<PasswordVisibleEvent>(onUpdateVisiblePass);
    on<RememberMeEvent>(onChangeRememberMe);
    on<PickImageSourceEvent>(onPickImage);
    on<FetchProfileDataEvent>(onFetchProfileData);
    on<EditProfileDataEvent>(onEditProfileData);
    on<ChangeForEditEvent>(onChangeForEdit);
  }

  refreshBloc(InitialEvent event, Emitter<ProfileState> emit) {
    emit(ProfileInitial());
  }

  /// for auth module
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  TextEditingController emailCtr = TextEditingController();
  TextEditingController passCtr = TextEditingController();
  bool isVisible = true;
  bool isRemember = false;

  Future onUpdateVisiblePass(PasswordVisibleEvent event, Emitter<ProfileState> emit) async {
    emit(PasswordVisibleTappingState());
    isVisible = !isVisible;
    emit(PasswordVisibleTappedState());
  }

  Future onChangeRememberMe(RememberMeEvent event, Emitter<ProfileState> emit) async {
    emit(RememberMeTappingState());
    isRemember = event.isRemember ?? !isRemember;
    StorageService.write(key: StorageKeys.isRemember, value: isRemember);
    emit(RememberMeTappedState());
  }

  /// for home page

  TextEditingController nameCtr = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController skillCtr = TextEditingController();
  List<Experience> experienceList = [];
  Uint8List filePath = Uint8List(0);

  Future onPickImage(PickImageSourceEvent event, Emitter<ProfileState> emit) async {
    emit(PickImageLoadingState());

    final pickedFile = event.source == ImageSource.camera
        ? await ImagePickerHelper.captureImageFromCamera()
        : await ImagePickerHelper.pickImageFromGallery();
    if (pickedFile != null) {
      Uint8List imgFile = await pickedFile.readAsBytes();
      filePath = imgFile;
      emit(PickImageSuccessState());
    } else {
      emit(PickImageFailState());
    }
  }

  /// for fetch and edit profile

  TextEditingController exNameCtr = TextEditingController();
  TextEditingController exDesignationCtr = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();


  ProfileModel profileModel = ProfileModel();
  bool isChanged = false;

  Future onFetchProfileData(FetchProfileDataEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(FetchProfileLoadingState());
      Map<String, dynamic> profileData = StorageService.read(key: StorageKeys.profileModel) ?? {};
      profileModel = ProfileModel.fromJson(profileData);
      fetchData();
      emit(FetchProfileSuccessState());
    } catch (e) {
      emit(FetchProfileFailState(e.toString()));
    }
  }

  fetchData(){
    nameCtr.text = profileModel.name ?? "";
    emailController.text = profileModel.email ?? "";
    skillCtr.text = profileModel.skill ?? "";
    experienceList = profileModel.experience ?? [];
    filePath = profileModel.image ?? Uint8List(0);
  }

  Future onEditProfileData(EditProfileDataEvent event, Emitter<ProfileState> emit) async {
    try {
      emit(EditProfileLoadingState());
      StorageService.write(key: StorageKeys.profileModel,value: event.profileModel.toJson());
      emit(EditProfileSuccessState());
    } catch (e) {
      emit(EditProfileFailState(e.toString()));
    }
  }

  Future onChangeForEdit(ChangeForEditEvent event, Emitter<ProfileState> emit) async {
    emit(EditChangeTappingState());
    isChanged = event.isChanged;
    emit(EditChangeTappedState());
  }
}
