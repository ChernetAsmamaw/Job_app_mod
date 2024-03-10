import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/job_details_page.dart';
import '../pages/edit_job_page.dart';

class JobCard extends StatelessWidget {
  final String companyName;
  final String jobTitle;
  final String jobLocation;
  final String briefDescription;
  final String jobImage;
  final String createdBy;
  final String jobId;

  JobCard({
    required this.companyName,
    required this.jobTitle,
    required this.jobLocation,
    required this.briefDescription,
    required this.jobImage,
    required this.createdBy,
    required this.jobId,
  });

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          color: Colors.grey[200],
          padding: EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: SizedBox(
            width: 275,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Image.asset(
                    jobImage,
                    width: 275.0,
                    height: 225.0,
                  ),
                ),
                Text(
                  jobTitle,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  companyName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  jobLocation,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 2),
                Expanded(
                  child: Text(
                    briefDescription,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (jobId.isNotEmpty) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => JobDetailsPage(
                              companyName: companyName,
                              jobTitle: jobTitle,
                              jobLocation: jobLocation,
                              briefDescription: briefDescription,
                              jobImage: jobImage,
                              createdBy: createdBy,
                              jobId: jobId,
                            ),
                          ),
                        );
                      } else {
                        print('Job ID is empty. Unable to view job details.');
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    child: Text(
                      'View Details',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}