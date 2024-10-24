import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_end/data/models/destination_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<DestinationModel>> getDestinations() {
    return _firestore.collection('destinations').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return DestinationModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }
}
