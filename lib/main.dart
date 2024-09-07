
import 'package:e_commerece/authentication/auth_cubit.dart';
import 'package:e_commerece/constants.dart';
import 'package:e_commerece/layout_cubit_screen/layout_cubit.dart';
import 'package:e_commerece/models/user_model.dart';
import 'package:e_commerece/shared/local_data.dart';
import 'package:e_commerece/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Pages/splash_page.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheData().initializeShared();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(),),
        BlocProvider(create: (context) => UserCubit()..getUserData(),),
        BlocProvider(create: (context) => LayoutCubit()..getBannerData()..getCategoryData()..getProducts(),),
      ],
      child:MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff2d4569)),
          useMaterial3: true,
        ),
        home: SplashPage()
        //ApiConfig.tokenForSharedPref!=null && ApiConfig.tokenForSharedPref!='' ? LayoutPage(): LoginPage(),
      )
    );
  }
}
