import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_profile/presentation/bloc/profile_bloc.dart';
import 'package:my_profile/route/app_router.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  easyLoadingConfig();
  runApp(MyApp());
}

easyLoadingConfig(){
  EasyLoading.instance
    ..userInteractions = false
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => ProfileBloc(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'My Profile',
        theme: ThemeData(
            useMaterial3: false,
        ),
        themeMode: ThemeMode.light,
        routerConfig: appRouter.config(),
        builder: EasyLoading.init(),
      ),
    );
  }
}
