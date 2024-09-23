import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<List<String>> uploadService(List files) async {
  List<String> filesUrl = [];
  final FirebaseStorage storage = FirebaseStorage.instance;
  // final storage = FirebaseStorage.instanceFor(bucket: 'MyAppBucket');
  for (var file in files) {
    final ref = storage.ref().child('files').child(file.path.split('/').last);
    final uploadTask = ref.putFile(File(file.path));
    final taskSnapshot = await uploadTask.whenComplete(() => null);
    final fileUrl = await taskSnapshot.ref.getDownloadURL();
    filesUrl.add(fileUrl);
  }
  return filesUrl;
}
