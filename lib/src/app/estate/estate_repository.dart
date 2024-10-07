import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:estate/src/core/log.dart';
import 'package:estate/src/core/services/upload_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EstateRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> addEstate(Map<String, dynamic> data) async {
    try {
      final fileLinks = await uploadService(data['fileLinks']);
      final featuredImageLink = await uploadService(data['featuredImageLink']);
      await firestore.collection('estates').add({
        'agentId': FirebaseAuth.instance.currentUser!.uid,
        'featuredImage': featuredImageLink.single,
        'coordinates': data['coordinates'],
        'city': data['city'],
        'quarter': data['quarter'],
        'price': data['price'],
        'description': data['description'],
        'location': data['location'],
        'area': data['area'],
        'fileUrls': fileLinks,
      });
      logInfo('Document created successfully');
    } catch (e) {
      logErr('Error creating document: $e');
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getEstates([String uid = '']) {
    return uid.isNotEmpty
        ? firestore.collection('estates').where('agentId', isEqualTo: uid).snapshots()
        : firestore.collection('estates').snapshots();
  }

  Future<void> updateEstate(String estateId, Map<String, dynamic> data) async {
    try {
      await firestore.collection('estates').doc(estateId).update(data);
      logInfo('Document updated successfully');
    } catch (e) {
      logErr('Error updating document: $e');
    }
  }
}
