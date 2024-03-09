import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/job_search_bar.dart';
import '../components/job_card.dart';
import 'post_page.dart';
import 'profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser!;

  // Function to sign a user out
  signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  // Function to navigate to the post or profile page
  void _onNavigationTapped(int index) {
    switch (index) {
      case 0:
        // Navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
        break;
      case 1:
        // Navigate to the post page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PostPage(user: FirebaseAuth.instance.currentUser!),
          ),
        );
        break;
      case 2:
        // Navigate to the profile page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProfilePage(),
          ),
        );
        break;
    }
  }

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        toolbarHeight: 65,
        title: Text(
          'Welcome ' + user.email!,
          style: TextStyle(
            color: Colors.blueGrey[800],
            fontFamily: 'Poppins',
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(
              Icons.logout_outlined,
              size: 30,
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search bar
          const SizedBox(height: 30),

          JobSearchBar(),

          const SizedBox(height: 40),

          // Recommended for you job cards
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            child: Text(
              'All Jobs Avaliable',
              style: TextStyle(
                  color: Colors.blueGrey[800],
                  fontFamily: 'Poppins',
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold),
            ),
          ),

          const SizedBox(height: 40),

          // Fetch job listings from Firestore
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('jobs').snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              return Container(
                height: 420,
                width: 400,
                child: ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final jobData = {
                      'id': snapshot.data!.docs[index].id,
                      ...snapshot.data!.docs[index].data() as Map<String, dynamic>,
                    };
                    final jobTitle = jobData['title'] ?? 'Job Title';
                    final companyName = jobData['companyName'] ?? 'Company Name';
                    final jobLocation = jobData['location'] ?? 'Job Location';
                    final briefDescription = jobData['description'] ?? 'Brief Description';
                    final jobImage = jobData['imageUrl'] ?? 'assets/mobile-gaming1.webp';
                    final createdBy = jobData['createdBy'] ?? '';

                    return JobCard(
                      jobTitle: jobTitle,
                      companyName: companyName,
                      jobLocation: jobLocation,
                      jobImage: jobImage,
                      briefDescription: briefDescription,
                      createdBy: createdBy,
                      jobId: jobData['id'],
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),

      // Navigation at the bottom
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onNavigationTapped,
      ),
    );
  }
}