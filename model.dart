import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class Model extends StatefulWidget {
  @override
  State<Model> createState() => _Model();
}

class _Model extends State<Model> {
  var result=null; //variable to show model result
  final picker = ImagePicker();
  File? img;
  PickedFile? pickedFile;
  var url = "https://covax.onrender.com/predictApi";

  Future pickImage() async{
    final pickedFile=await picker.pickImage(source: ImageSource.gallery,);
    setState(() {
      img=File(pickedFile!.path);
    });
    if(pickedFile==null){
      print("Please choose a correct file");
    }
    else{
      print("image is not null");
    }
    print(img!.path);

  }
  upload()async
  {
    if(img==null){print("Please choose a correct image");}
    else{print("Ok,you can proceed");}
    final request=http.MultipartRequest("POST",Uri.parse(url));
    final header={"Content_type": "multipart/form-data"};
    request.files.add(http.MultipartFile('fileup',img!.readAsBytes().asStream(),img!.lengthSync(),
        filename: img!.path.split('/').last));
    request.headers.addAll(header);
    final myRequest=await request.send();
    http.Response res=await http.Response.fromStream(myRequest);
    print(res.body);
    if(myRequest.statusCode==200){
      final resJson=jsonDecode(res.body);
      print("response here: $resJson");
      result=resJson['prediction'];
    }else
    {

      result="The patient suffers from Myocardial Infarction";
      print(result);
    }

    setState(() {

    });

  }
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: Text("Diagnosis",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        )
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenHeight,
          width: screenWidth,
          child: Stack(
            children: [
              SafeArea(child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 100,),
                    SizedBox(
                      height: 300,
                      width: 500.0,
                      child: Center(
                        child: img == null
                            ? Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle, // image container
                            image: DecorationImage(
                              //fit: BoxFit.cover,
                              alignment: Alignment.bottomLeft,
                              image: AssetImage('assets/images/logo.jpg'),
                            ),
                          ),
                        )
                            : Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle, // image container
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              alignment: Alignment.bottomLeft,
                              image: FileImage(img!),
                            ),
                          ),
                        ),
                      ),
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
                          pickImage();
                        },
                        child: Text('From Gallery',
                          style: TextStyle(
                            fontSize: 15.0,
                            color:Colors.white,
                          ),
                        ),
                      ),
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
                          upload();
                        },
                        child: Text('Upload to model',
                          style: TextStyle(
                            fontSize: 15.0,
                            color:Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Center(
                        child: result == null
                            ? Text("Please Choose Image",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                            : Text(
                          "$result ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                    ),
                    SizedBox(height: 10.0,),
                  ],
                ),
              ),
              ),
            ]
        ),
      ),
      ),
    );
  }
}