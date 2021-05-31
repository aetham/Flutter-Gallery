
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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


  void btnOnClick(String btnVal) {
    if (btnVal == "upload") {
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
        color: Colors.blue,
      ),
    ),
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ViewPage(file: file),
    )),
  );

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
                    mainAxisAlignment: MainAxisAlignment.center,
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

}