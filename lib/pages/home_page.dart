import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/job_search_bar.dart';
import '../components/job_card.dart';
import 'post_page.dart';

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

  // List of info for card
  final List recentJobs = [
    [
      'Software Engineer',
      'Google RW',
      'Kigali, Rwanda',
      'assets/mobile-gaming1.webp',
      'While building apps with Flutter, several UI/UX design elements collectively make your app more interactive. As the UI of your app defines its future, you should always value making the UI of your app as engaging as you can. This will increase the user retention rate, which is one of the major steps toward your app’s success.',
    ],
    [
      'UI Designer',
      'Google RW',
      'Kigali, Rwanda',
      'assets/mobile-gaming1.webp',
      'While building apps with Flutter, several UI/UX design elements collectively make your app more interactive. As the UI of your app defines its future, you should always value making the UI of your app as engaging as you can. This will increase the user retention rate, which is one of the major steps toward your app’s success.',
    ],
  ];

  // Function to navigate to the post page
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
      default:
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

          Container(
            height: 420,
            width: 400,
            child: ListView.builder(
              itemCount: recentJobs.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return JobCard(
                  jobTitle: recentJobs[index][0],
                  companyName: recentJobs[index][1],
                  jobLocation: recentJobs[index][2],
                  jobImage: recentJobs[index][3],
                  briefDescription: recentJobs[index][4],
                );
              },
            ),
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onNavigationTapped,
      ),
    );
  }
}
