part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class InitialEvent extends ProfileEvent {}

/// for auth module
class PasswordVisibleEvent extends ProfileEvent {}

class RememberMeEvent extends ProfileEvent {
 final bool? isRemember;
  RememberMeEvent({this.isRemember});
}

/// for home view
class PickImageSourceEvent extends ProfileEvent {
  final ImageSource source;

  PickImageSourceEvent(this.source);
}

class FetchProfileDataEvent extends ProfileEvent {}

class EditProfileDataEvent extends ProfileEvent {
  final ProfileModel profileModel;
  EditProfileDataEvent(this.profileModel);
}

class ChangeForEditEvent extends ProfileEvent {
  final bool isChanged;
  ChangeForEditEvent(this.isChanged);
}