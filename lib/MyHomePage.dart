import 'dart:convert';
import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:tuberculosis/pred.dart';



import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>(); //new line
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  File PickedImage;
  void impic() async {
   final PickedImageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  setState(() {
     PickedImage = PickedImageFile;
   });
  }

  void sent() async{
    var p;
    var formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(PickedImage.path, filename: 'upload.png'),
    });
    print("Here");

    var response = await Dio().put('http://192.168.0.106:80/home', data: formData);
    Pred pred = Pred.fromJson(response.data);
   // p = response.data;
    print(pred);

    final snackBar = SnackBar(
    content: Text(pred.output,style: TextStyle(fontSize: 20,),textAlign: TextAlign.center,),
    backgroundColor: Colors.teal,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(100))),
    behavior: SnackBarBehavior.floating,

    );
    _scaffoldKey.currentState.showSnackBar(snackBar);

//    print(Pred.fromJson(json.decode(response.data)));
 //   setState(() {
  //    p = response;
   // });



  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: _scaffoldKey,

        body:Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/Bg.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        child: Column(
          children: <Widget>[
          //  FlatButton.icon(onPressed: impic, icon: Icon(Icons.image), label: Text("Add Image")),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 150,0,0),
              child: Center(
                child: Column(
                  children: <Widget>[

                    FlatButton.icon(onPressed: impic, icon: Icon(Icons.image), label: Text("Add Image"),
                      shape: RoundedRectangleBorder(side: BorderSide(
                          color: Colors.blue,
                          width: 1,
                          style: BorderStyle.solid
                      ), borderRadius: BorderRadius.circular(20)),),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 180,0,0),
                      child: Column(
                        children: <Widget>[


                          CircleAvatar(
                            radius: 150,backgroundColor: Colors.grey,
                            backgroundImage: PickedImage != null ? FileImage(PickedImage) : null,
                          ),

                          FlatButton.icon(onPressed: sent, icon: Icon(Icons.scanner), label: Text("Scan")),
                        ],
                      ),
                    ),


                  ],



                ),
              ),
            ),
          ],
        ),
      ),
    )

    );


  }

}