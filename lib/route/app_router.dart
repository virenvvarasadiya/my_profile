import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/presentation/Model/profile_model.dart';
import 'package:my_profile/presentation/pages/authntication/login_screen.dart';
import 'package:my_profile/presentation/pages/edit_view/edit_profile_screen.dart';
import 'package:my_profile/presentation/pages/home_view/home_screen.dart';
import 'package:my_profile/presentation/pages/splash/splash_screen.dart';
part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, initial: true),
    AutoRoute(page: LoginRoute.page,),
    AutoRoute(page: HomeRoute.page),
    AutoRoute(page: EditProfileRoute.page),
  ];
}
