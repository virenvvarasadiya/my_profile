part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

/// for auth module
class PasswordVisibleTappingState extends ProfileState {}
class PasswordVisibleTappedState extends ProfileState {}

class RememberMeTappingState extends ProfileState {}
class RememberMeTappedState extends ProfileState {}

/// for home view
class PickImageLoadingState extends ProfileState {}
class PickImageFailState extends ProfileState {}
class PickImageSuccessState extends ProfileState {
}

/// for fetch and edit profile

class FetchProfileLoadingState extends ProfileState {}
class FetchProfileSuccessState extends ProfileState {}
class FetchProfileFailState extends ProfileState {
  final String error;
  FetchProfileFailState(this.error);
}

class EditProfileLoadingState extends ProfileState {}
class EditProfileSuccessState extends ProfileState {}
class EditProfileFailState extends ProfileState {
  final String error;
  EditProfileFailState(this.error);
}

class EditChangeTappingState extends ProfileState {}
class EditChangeTappedState extends ProfileState {}
