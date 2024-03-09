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

  String _fullName = '';
  String _education = '';
  String _location = '';
  int _experience = 0;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    // Load user profile from Firestore or initialize a new one
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      final snapshot =
          await FirebaseFirestore.instance.collection('profiles').doc(userId).get();
      if (snapshot.exists) {
        final data = snapshot.data() as Map<String, dynamic>;
        _userProfile = UserProfile.fromJson(data);
        setState(() {
          _fullName = _userProfile!.fullName;
          _education = _userProfile!.education;
          _location = _userProfile!.location;
          _experience = _userProfile!.experience;
        });
      } else {
        setState(() {
          _fullName = '';
          _education = 'Undergraduate';
          _location = '';
          _experience = 0;
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      if (_userProfile != null) {
        // Update existing profile
        _userProfile!.fullName = _fullName;
        _userProfile!.education = _education;
        _userProfile!.location = _location;
        _userProfile!.experience = _experience;
        await _userProfileService.updateUserProfile(_userProfile!);
      } else {
        // Create new profile
        final userProfile = UserProfile(
          fullName: _fullName,
          education: _education,
          location: _location,
          experience: _experience,
        );
        await _userProfileService.createUserProfile(userProfile, userId);
      }
    }
  }

  Future<void> _deleteProfile() async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null && _userProfile != null) {
      await _userProfileService.deleteUserProfile(_userProfile!.id!);
      setState(() {
        _userProfile = null;
        _fullName = '';
        _education = 'Undergraduate';
        _location = '';
        _experience = 0;
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
            TextFormField(
              initialValue: _fullName,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _fullName = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Education',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: _education,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _education = value!;
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
            ),
            SizedBox(height: 16),
            Text(
              'Location',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            TextFormField(
              initialValue: _location,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _location = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Experience',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            SizedBox(height: 8),
            Slider(
              value: _experience.toDouble(),
              min: 0,
              max: 5,
              divisions: 5,
              label: _experience.toString(),
              onChanged: (value) {
                setState(() {
                  _experience = value.round();
                });
              },
            ),
            SizedBox(height: 50),
            Center(
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
            ),
            ElevatedButton(
              onPressed: _deleteProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: Text(
                'Delete Profile',
                style: TextStyle(fontSize: 16, color: Colors.white),
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