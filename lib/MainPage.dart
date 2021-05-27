import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'dart:math';

import 'UploadPage.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}): super(key:key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>{
  final FirebaseFirestore asb = FirebaseFirestore.instance;
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('files');
  String holder = '';


  void btnOnClick(String btnVal){
    if(btnVal =="upload"){
      Navigator.push(context, new MaterialPageRoute(builder: (context)=> UploadPage()));
    }
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('Gallery!'),
            ),

            body: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [



                      ElevatedButton(
                        onPressed:() {
                          btnOnClick('upload');
                        },
                        child: Text(
                            'Add picture'
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            ),
          );
        }
    );
  }
}
