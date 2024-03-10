import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final String companyName;
  final String location;
  final String description;
  final String imageUrl;
  final String createdBy;
  final String jobId; // Adding jobId parameter

  Post({
    this.id = '',
    required this.title,
    required this.companyName,
    required this.location,
    required this.description,
    required this.imageUrl,
    required this.createdBy,
    required this.jobId, // Adding jobId parameter
  });

  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      id: data['jobId'] ?? '',
      title: data['title'] ?? '',
      companyName: data['companyName'] ?? '',
      location: data['location'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      createdBy: data['createdBy'] ?? '',
      jobId: data['jobId'] ?? '', // Adding jobId parameter
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': jobId,
      'title': title,
      'companyName': companyName,
      'location': location,
      'description': description,
      'imageUrl': imageUrl,
      'createdBy': createdBy,
      'jobId': jobId, 
    };
  }
}