import 'package:flutter/material.dart';
import 'model.dart';
import 'SignUp.dart';
import 'globals.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key ? key}) :super(key: key);
  @override
  State<LogInScreen> createState()=>_LogIn();
}

class _LogIn extends State<LogInScreen>{
  bool _obSecure=true;
  final _formKey = GlobalKey<FormState>();
  double screenHeight=0;
  double screenWidth=0;
  //String email="";
  //String password="";
  Future <bool> isSimilar() async {
    bool isSimilar=false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail=prefs.getString("email");
    String? savedPass=prefs.getString("password");
    if(savedEmail==email && savedPass==password){
      isSimilar=true;
      print("Login Successful");
    }
    else if(savedEmail==email && savedPass!=password){
      isSimilar=false;
    }
    else if(savedEmail!=email && savedPass==password){
      isSimilar=false;
    }
    return isSimilar;
  }
  @override
  Widget build(BuildContext context) {
    screenHeight=MediaQuery.of(context).size.height;
    screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body:
         SingleChildScrollView(
           child: SizedBox(
            height: screenHeight,
            width: screenWidth,
             child: Stack(
              children: [
                Center(
                  //third white rectangular box
                  child: Transform.translate(
                    offset: Offset(screenWidth/30,-30),
                    child: Transform.rotate(
                      angle: -0.4,
                      child: Container(
                        height: screenHeight/3,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(55),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  //second white rectangular box
                  child: Transform.translate(
                    offset: Offset(screenWidth/30,-10),
                    child: Transform.rotate(
                      angle: -0.4,
                      child: Container(
                        height: screenHeight/3,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(55),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  //first white rectangular box
                  child: Transform.translate(
                    offset: Offset(screenWidth/30,10),
                    child: Transform.rotate(
                      angle: -0.4,
                      child: Container(
                        height: screenHeight/3,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(55),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: screenHeight/2,
                    width: screenWidth,
                    color: Colors.white,
                    child:Column(
                      children: [
                        Align(
                          child: Container(
                            height: 100,
                            width: 300,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                image: DecorationImage(
                                  image: AssetImage("assets/images/logo.jpg"),
                                )
                            ),
                          ),
                        ),
                        Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    labelText: "Email",
                                    prefixIcon: Icon(Icons.email),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(45)),
                                  ),
                                  validator: (value) {
                                    if(value==null || value.isEmpty){
                                      return "Email can't be empty";
                                    }
                                    if (!value.contains('@') || !value.contains('.')) {
                                      return "Email should contain @ and . symbols.";
                                    }
                                    email=value!;
                                    print(email);
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.0,),
                                TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: _obSecure,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    prefixIcon: Icon(Icons.lock),
                                    suffixIcon: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _obSecure =! _obSecure;
                                        });
                                      },
                                      child: Icon(_obSecure //check on obsecure value
                                          ?Icons.visibility //if true choose icon visibility
                                          : Icons.visibility_off // if not visibility off
                                      ),
                                    ),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(45)),
                                  ),
                                  validator: (value) {
                                    if(value==null || value.isEmpty){
                                      return "Password can't be empty";
                                    }
                                    if (value.length < 6) {
                                      return "Password should be atleast 6 characters long";
                                    }
                                    password=value!;
                                    print(password);
                                    return null;
                                  },

                                ),
                                SizedBox(height: 10.0,),
                                Container(
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(45),
                                    color: Colors.blue[700],
                                  ),
                                  child: MaterialButton(
                                    onPressed: () async{
                                      if(_formKey.currentState!.validate()){
                                        //addStringToSF();
                                        //signInWithEmailAndPassword();
                                        if(await isSimilar()==true){
                                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Model()));
                                        }
                                        else{
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Incorrect email or password'),
                                                content: Text('Please,try again.'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context).pop();
                                                    },
                                                    child: Text('OK'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          print("can't log in");
                                        }
                                      }

                                    },
                                    child: Text('Log In',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color:Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Don\'t have an account?'),
                                    TextButton(
                                      onPressed: (){
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignUp()));
                                      },
                                      child: Text('Register Now'),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),

                        ),
                      ],
                    ),

                  ),
                ),

              ],

            ),
        ),

         ),
    );
  }
}


