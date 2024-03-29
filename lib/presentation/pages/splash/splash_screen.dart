import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/route/app_router.dart';
import 'package:my_profile/storage_service/storage_keys.dart';
import 'package:my_profile/storage_service/storage_sevice.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      final isRemember = StorageService.read(key: StorageKeys.isRemember);
      if(isRemember){
        context.router.replace(const HomeRoute());
      }else{
        context.router.replace(const LoginRoute());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}

