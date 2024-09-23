import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/log.dart';
import 'package:estate/services/upload_service.dart';

class PropertyRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> createProperty(Map<String, dynamic> data) async {
    try {
      final filesUrl = await uploadService(data['image']);
      await firestore.collection('property').add({
        'uid': data['uid'],
        'name': data['name'],
        'price': data['price'],
        'description': data['description'],
        'location': data['location'],
        'image': filesUrl,
      });
      logInfo('Document created successfully');
    } catch (e) {
      logErr('Error creating document: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProperties() {
    return firestore.collection('property').snapshots();
  }

  Future<void> updateDocument(String documentId, Map<String, dynamic> data) async {
    try {
      await firestore.collection('property').doc(documentId).update(data);
      print('Document updated successfully');
    } catch (e) {
      print('Error updating document: $e');
    }
  }
}
