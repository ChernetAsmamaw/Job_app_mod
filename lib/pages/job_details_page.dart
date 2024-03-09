import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/post.dart';
import 'edit_job_page.dart';
import 'package:job_application_portal/components/job_card.dart';

class JobDetailsPage extends StatelessWidget {
  final JobCard job;

  JobDetailsPage({required this.job});

  Future<void> _deletePost(BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('jobs')
        .doc(job.id)
        .delete();

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
        actions: currentUser?.uid == job.createdBy
            ? [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    if (job.id != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditJobPage(
                          job: job,
                          jobId: job.id, // Adding jobId parameter
                        ),
                      ),
                    );
                  } else {
                    print('Job ID is null');
                  }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Delete Job'),
                        content: Text('Are you sure you want to delete this job?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () => _deletePost(context),
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              job.jobTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              job.companyName,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              job.jobLocation,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Image.network(
              job.jobImage,
              width: 300,
              height: 225,
            ),
            SizedBox(height: 10),
            Text(
              job.briefDescription,
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 50),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your button action here
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                child: Text(
                  'Apply Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}