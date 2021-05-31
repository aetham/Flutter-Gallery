import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gallery/model/firebase_file.dart';

class ViewPage extends StatelessWidget{
  final FirebaseFile file;
  const ViewPage({Key? key, required this.file,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(file.name),
        centerTitle: true,
      ),
      body: Image.network(
        file.url,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}