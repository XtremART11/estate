import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/log.dart';
import 'package:estate/services/upload_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PropertyRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addProperty(Map<String, dynamic> data) async {
    try {
      final imageUrls = await uploadService(data['imageUrls']);
      await firestore.collection('properties').add({
        'agentId': FirebaseAuth.instance.currentUser!.uid,
        'city': data['city'],
        'quarter': data['quarter'],
        'price': data['price'],
        'description': data['description'],
        'location': data['location'],
        'imageUrls': imageUrls,
      });
      logInfo('Document created successfully');
    } catch (e) {
      logErr('Error creating document: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getProperties([String uid = '']) {
    return uid.isNotEmpty
        ? firestore.collection('properties').where('agentId', isEqualTo: uid).snapshots()
        : firestore.collection('properties').snapshots();
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
