import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_application_portal/models/profile.dart';
import 'package:job_application_portal/services/user_profile_service.dart';

import 'post_page.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserProfile? _userProfile;
  final UserProfileService _userProfileService = UserProfileService();

  bool _isEditing = false; // Track if the user is editing the profile

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    // Load user profile from Firestore or initialize a new one
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final snapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .doc(userId)
          .get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        _userProfile = UserProfile.fromJson(data);
        setState(() {});
      } else {
        setState(() {
          _userProfile = null;
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null && _userProfile != null) {
      await _userProfileService.updateUserProfile(_userProfile!);
      setState(() {
        _isEditing = false;
      });
    }
  }

  Future<void> _deleteProfile() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null && _userProfile != null) {
      await _userProfileService.deleteUserProfile(_userProfile!.id!);
      setState(() {
        _userProfile = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        toolbarHeight: 50,
        title: Text(
          'JAB',
          style: TextStyle(
            color: Colors.blueGrey[800],
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(
              Icons.logout_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Profile',
              style: TextStyle(
                  color: Colors.blueGrey[600],
                  fontFamily: 'Poppins',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30.0),
            Text(
              'Full Name',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            _isEditing
                ? TextFormField(
                    initialValue: _userProfile?.fullName,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _userProfile?.fullName = value;
                      });
                    },
                  )
                : Text(_userProfile?.fullName ?? ''),
            SizedBox(height: 16),
            Text(
              'Education',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            _isEditing
                ? DropdownButtonFormField<String>(
                    value: _userProfile?.education,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _userProfile?.education = value!;
                      });
                    },
                    items: [
                      DropdownMenuItem<String>(
                        value: 'High School',
                        child: Text('High School'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Undergraduate',
                        child: Text('Undergraduate'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Postgraduate',
                        child: Text('Postgraduate'),
                      ),
                    ],
                  )
                : Text(_userProfile?.education ?? ''),
            SizedBox(height: 16),
            Text(
              'Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            _isEditing
                ? TextFormField(
                    initialValue: _userProfile?.location,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _userProfile?.location = value;
                      });
                    },
                  )
                : Text(_userProfile?.location ?? ''),
            SizedBox(height: 16),
            Text(
              'Experience',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            _isEditing
                ? Slider(
                    value: (_userProfile?.experience ?? 0).toDouble(),
                    min: 0,
                    max: 5,
                    divisions: 5,
                    label: (_userProfile?.experience ?? 0).toString(),
                    onChanged: (value) {
                      setState(() {
                        _userProfile?.experience = value.round();
                      });
                    },
                  )
                : Text((_userProfile?.experience ?? 0).toString()),
            SizedBox(height: 50),
            _isEditing
                ? Center(
                    child: ElevatedButton(
                      onPressed: _updateProfile,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      child: Text(
                        'Update Profile',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  )
                : Center(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _isEditing = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                      ),
                      child: Text(
                        'Edit Profile',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_page),
            label: 'Profile',
          ),
        ],
        currentIndex: 2,
        selectedItemColor: Colors.blue,
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            );
          } else if (index == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PostPage(user: FirebaseAuth.instance.currentUser!),
              ),
            );
          }
        },
      ),
    );
  }
}
