import 'package:firebase_tut/firebase_services/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashScreen = SplashServices();
  @override
  void initState(){
    super.initState();
    splashScreen.isLogin(context);
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Firebase Tutorial', style: TextStyle(fontSize: 30),),
      ),
    );
  }
}
