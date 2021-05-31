import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_gallery/model/firebase_file.dart';


class FirebaseApi {

  static UploadTask? uploadFile(String destination, File file) {
      final location = FirebaseStorage.instance.ref(destination);
      return location.putFile(file);
  }
  static Future<List<String>> getLink(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();
    final urls = await getLink(result.items);
    return urls
        .asMap()
        .map((index, url) {
      final ref = result.items[index];
      final name = ref.name;
      final file = FirebaseFile(ref: ref, name: name, url: url);

      return MapEntry(index, file);
    })
        .values
        .toList();
  }
}

