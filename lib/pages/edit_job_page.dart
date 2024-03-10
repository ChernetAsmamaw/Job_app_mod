import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class EditJobPage extends StatefulWidget {
  final String companyName;
  final String jobTitle;
  final String jobLocation;
  final String briefDescription;
  final String jobImage;
  final String createdBy;
  final String jobId;

  EditJobPage({
    required this.companyName,
    required this.jobTitle,
    required this.jobLocation,
    required this.briefDescription,
    required this.jobImage,
    required this.createdBy,
    required this.jobId,
  });

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _companyNameController = TextEditingController();
  final _titleController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _companyNameController.text = widget.companyName;
    _titleController.text = widget.jobTitle;
    _locationController.text = widget.jobLocation;
    _descriptionController.text = widget.briefDescription;
    _imageUrlController.text = widget.jobImage;
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _titleController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  Future<void> _updateJob() async {
    if (widget.jobId.isNotEmpty) {
      final jobData = {
        'companyName': _companyNameController.text.trim(),
        'jobTitle': _titleController.text.trim(),
        'location': _locationController.text.trim(),
        'description': _descriptionController.text.trim(),
        'imageUrl': _imageUrlController.text.trim(),
        'createdBy': FirebaseAuth.instance.currentUser?.uid,
        'jobId': widget.jobId,
      };

      await FirebaseFirestore.instance
          .collection('jobs')
          .doc(widget.jobId)
          .update(jobData);

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } else {
      print('Job ID is empty. Unable to update job.');
      // You can also show a SnackBar or an AlertDialog to inform the user about the issue
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Job'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _companyNameController,
              decoration: InputDecoration(
                labelText: 'Company Name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Job Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Location',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _descriptionController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Description',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(
                labelText: 'Image URL',
              ),
            ),
            SizedBox(height: 50.0),
            Center(
              child: ElevatedButton(
                onPressed: _updateJob,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: EdgeInsets.all(20),
                ),
                child: Text(
                  'Update Job',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
