import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'post_page.dart';
import 'home_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _fullName = 'John Doe';
  String _education = 'Undergraduate';
  String _location = 'New York';
  int _experience = 2;

  int _selectedIndex = 0;
  void _onNavigationTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
            onPressed: () {},
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
              'Post Jobs!',
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
                  _location = value;
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
                onPressed: () {/*_updateProfile,*/},
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
