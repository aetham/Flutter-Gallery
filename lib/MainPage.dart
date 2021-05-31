import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'UploadPage.dart';
import 'ViewPage.dart';
import 'api/firebase_api.dart';
import 'package:flutter_gallery/model/firebase_file.dart';


class MainPage extends StatefulWidget {
  MainPage({Key? key}): super(key:key);
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final FirebaseFirestore asb = FirebaseFirestore.instance;
  final CollectionReference collectionReference = FirebaseFirestore.instance
      .collection('files/');

  Future<void> listExample() async {
    firebase_storage.ListResult result = await firebase_storage.FirebaseStorage
        .instance.ref('files/').listAll();
    result.items.forEach((firebase_storage.Reference ref) {
      print('Found file: $ref');
    });
  }

  void btnOnClick(String btnVal) {
    if (btnVal == "upload") {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => UploadPage()));
    }
  }

  void wuush(String btnVal) {
    if (btnVal == "acd") {
      Navigator.push(
          context, new MaterialPageRoute(builder: (context) => UploadPage()));
    }
  }

  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();

    futureFiles = FirebaseApi.listAll('files/');
  }

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        appBar: AppBar(
          title: Text('Gallery'),
          centerTitle: true,
        ),
          body:FutureBuilder<List<FirebaseFile>>(
            future: futureFiles,
            builder: (context, snapshot){
              switch (snapshot.connectionState){
                default:
                  final files = snapshot.data!;
                  return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    Expanded(
                        child: ListView.builder(
                          itemCount: files.length,
                          itemBuilder: (context, index){
                            final file = files[index];
                            return buildFile(context, file);
                            },
                        ),
                    ),
                    ElevatedButton(
                      onPressed:() {
                        btnOnClick('upload');
                        listExample();
                      },
                      child: Text(
                          'Add picture'
                      ),
                    ),
                  ],
                  );
              }
            }
            )
      );
  Widget buildFile(BuildContext context, FirebaseFile file) => ListTile(
    leading: Image.network(
      file.url,
      width: 50,
      height: 50,
      fit: BoxFit.cover,
    ),
    title: Text(
          file.name,
          style: TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      color: Colors.blue,
    ),
    ),
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ViewPage(file: file),
    )),
  );
}