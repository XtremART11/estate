import 'package:cloud_firestore/cloud_firestore.dart';

class AgentRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getAgent(String uid) {
    // return firestore.collection('agents').where('agentId', isEqualTo: uid).snapshots();
    return firestore.collection('agents').doc(uid).snapshots();
  }
}
