import 'package:e_commerece/constants.dart';
import 'package:e_commerece/layout_cubit_screen/layout_page/layout_page.dart';
import 'package:e_commerece/shared/local_data.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 10), () {
      if (ApiConfig.tokenForSharedPref != null && ApiConfig.tokenForSharedPref != '') {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LayoutPage()));
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Image.network('https://seeklogo.com/images/S/shopify-logo-1C711BCDE4-seeklogo.com.png'),
            ),
            const Text('Developed By Shahd AbdelNaby', style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
