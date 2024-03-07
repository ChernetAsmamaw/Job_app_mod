import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final String companyName;
  final String location;
  final String description;
  final String imageUrl;

  Post({
    required this.id,
    required this.title,
    required this.companyName,
    required this.location,
    required this.description,
    required this.imageUrl,
    String? userEmail,
  });

  factory Post.fromMap(Map<String, dynamic> data) {
    return Post(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      companyName: data['companyName'] ?? '',
      location: data['location'] ?? '',
      description: data['description'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'companyName': companyName,
      'location': location,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
