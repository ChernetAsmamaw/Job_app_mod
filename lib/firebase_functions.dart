import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_application_portal/models/post.dart';

class FirebaseFunctions {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new post
  Future<void> addPost(Post post) async {
    await _firestore.collection('posts').add(post.toMap());
  }

  // Get all posts
  Stream<List<Post>> getPosts() {
    return _firestore.collection('posts').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Post.fromMap(doc.data())).toList();
    });
  }

  // Get a single post by ID
  Future<Post> getPostById(String postId) async {
    final doc = await _firestore.collection('posts').doc(postId).get();
    return Post.fromMap(doc.data()!);
  }

  // Update a post
  Future<void> updatePost(Post post) async {
    await _firestore.collection('posts').doc(post.id).update(post.toMap());
  }

  // Delete a post
  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }
}
