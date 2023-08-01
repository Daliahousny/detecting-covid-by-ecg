import 'package:flutter/material.dart';
import 'package:mysecondproject/LogIn.dart';
import 'package:mysecondproject/splashscreen.dart';
import 'package:mysecondproject/model.dart';



void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(ECGapp());
}

class ECGapp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInScreen(),
    );
  }
}
