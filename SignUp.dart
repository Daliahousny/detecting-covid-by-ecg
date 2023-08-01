import 'package:flutter/material.dart';
import 'package:mysecondproject/model.dart';
import 'globals.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SignUp extends StatefulWidget
{
  @override
  State<SignUp> createState()=>_SignUp();
}

class _SignUp extends State<SignUp>
{
  final _formKey = GlobalKey<FormState>();
  double screenHeight=0;
  double screenWidth=0;
  bool _obSecure=true;
  String fname="";
  String lname="";
  //String email="";
  //String password="";
  addStringToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight=MediaQuery.of(context).size.height;
    screenWidth=MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SingleChildScrollView(
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
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text("Welcome to Covax",
                        style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 10.0,),
                        Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: "Firstname",
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(45)),
                                  ),
                                  validator: (value) {
                                    if(value==null || value.isEmpty){
                                      return "Firstname can't be empty";
                                    }
                                    if(value.length<5){
                                      return "Firstname should be at least 5 characters long";
                                    }
                                    fname = value!;
                                    print(fname);
                                    return null;
                                  },
                                ),
                                SizedBox(height: 10.0,),
                                TextFormField(
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(
                                    labelText: "Lastname",
                                    prefixIcon: Icon(Icons.person),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(45)),
                                  ),
                                  validator: (value) {
                                    if(value==null || value.isEmpty){
                                      return "Lastname can't be empty";
                                    }
                                    if(value.length<5){
                                      return "Lastname should be at least 5 characters long";
                                    }
                                    lname = value!;
                                    print(lname);
                                    return null;
                                  },

                                ),
                                SizedBox(height:10.0),
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
                                    email= value!;
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
                                      return "Password should be atleast 8 characters long";
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
                                    onPressed: (){
                                      if(_formKey.currentState!.validate()){
                                        addStringToSF();
                                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Model()));
                                      }
                                    },
                                    child: Text('Sign Up',
                                      style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold,
                                        color:Colors.white,
                                      ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
