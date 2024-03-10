import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:job_application_portal/pages/home_page.dart';
import 'edit_job_page.dart';
import 'home_page.dart';

class JobDetailsPage extends StatefulWidget {
  final String companyName;
  final String jobTitle;
  final String jobLocation;
  final String briefDescription;
  final String jobImage;
  final String createdBy;
  final String jobId;

  JobDetailsPage({
    required this.companyName,
    required this.jobTitle,
    required this.jobLocation,
    required this.briefDescription,
    required this.jobImage,
    required this.createdBy,
    required this.jobId,
  });

  @override
  _JobDetailsPageState createState() => _JobDetailsPageState();
}

class _JobDetailsPageState extends State<JobDetailsPage> {
  Future<void> _deletePost(BuildContext context) async {
    if (widget.jobId.isNotEmpty) {
      await FirebaseFirestore.instance
          .collection('jobs')
          .doc(widget.jobId)
          .delete();

      // Navigate to the homepage and remove all previous routes

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } else {
      print('Job ID is null. Unable to delete job.');
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Job Details'),
        actions: currentUser?.uid == widget.createdBy
            ? [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    if (widget.jobId.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditJobPage(
                            companyName: widget.companyName,
                            jobTitle: widget.jobTitle,
                            jobLocation: widget.jobLocation,
                            briefDescription: widget.briefDescription,
                            jobImage: widget.jobImage,
                            createdBy: widget.createdBy,
                            jobId: widget.jobId,
                          ),
                        ),
                      );
                    } else {
                      print('Job ID is null. Unable to edit job.');
                      // You can also show a SnackBar or an AlertDialog to inform the user about the issue
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
                        content:
                            Text('Are you sure you want to delete this job?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () => _deletePost(context),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red[200]),
                            ),
                            child: Text(
                              'Delete',
                            ),
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
              widget.jobTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              widget.companyName,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Text(
              widget.jobLocation,
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 10),
            Image.asset(
              widget.jobImage,
              width: 300,
              height: 225,
            ),
            SizedBox(height: 10),
            Text(
              widget.briefDescription,
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
                  padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(
                      horizontal: 30,
                      vertical: 20,
                    ),
                  ),
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
