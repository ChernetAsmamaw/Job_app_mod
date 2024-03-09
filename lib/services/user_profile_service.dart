// user_profile_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_application_portal/models/profile.dart';

class UserProfileService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create
  Future<void> createUserProfile(UserProfile profile, String userId) async {
    await _firestore.collection('profiles').add(profile.toJson());
  }

  // Read
  Stream<QuerySnapshot> getUserProfiles() {
    return _firestore.collection('profiles').snapshots();
  }

  // Update
  Future<void> updateUserProfile(UserProfile profile) async {
    await _firestore
        .collection('profiles')
        .doc(profile.id)
        .update(profile.toJson());
  }

  // Delete
  Future<void> deleteUserProfile(String id) async {
    await _firestore.collection('profiles').doc(id).delete();
  }
}