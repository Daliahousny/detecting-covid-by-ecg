import 'dart:async';
import'package:flutter/material.dart' ;
import 'package:lottie/lottie.dart';
import 'package:mysecondproject/LogIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget{
  @override
  State<SplashScreen> createState()=>_SplashScreen();
}

class _SplashScreen extends State<SplashScreen>
{
  var _time;
  start()
  {
    _time=Timer(Duration(seconds: 4), call);
  }

  void call()
  {
    Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (context)=>LogInScreen(),));
  }
  @override
  void initState()
  {
    start();
    super.initState();
  }
  @override
  void dispose()
  {
    _time.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Center(child: Lottie.network("https://assets8.lottiefiles.com/packages/lf20_ilapxeje.json"),),
    );
  }
}