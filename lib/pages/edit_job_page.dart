import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_application_portal/components/job_card.dart';

class EditJobPage extends StatefulWidget {
  final JobCard job;
  final String? jobId;

  EditJobPage({required this.job, required this.jobId});

  @override
  _EditJobPageState createState() => _EditJobPageState();
}

class _EditJobPageState extends State<EditJobPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _companyNameController;
  late TextEditingController _jobTitleController;
  late TextEditingController _jobLocationController;
  late TextEditingController _briefDescriptionController;

  @override
  void initState() {
    super.initState();
    _companyNameController = TextEditingController(text: widget.job.companyName);
    _jobTitleController = TextEditingController(text: widget.job.jobTitle);
    _jobLocationController = TextEditingController(text: widget.job.jobLocation);
    _briefDescriptionController = TextEditingController(text: widget.job.briefDescription);
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _jobTitleController.dispose();
    _jobLocationController.dispose();
    _briefDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Job Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _companyNameController,
                decoration: InputDecoration(labelText: 'Company Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a company name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jobTitleController,
                decoration: InputDecoration(labelText: 'Job Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a job title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _jobLocationController,
                decoration: InputDecoration(labelText: 'Job Location'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a job location';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _briefDescriptionController,
                decoration: InputDecoration(labelText: 'Brief Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a brief description';
                  }
                  return null;
                },
                maxLines: 3,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    updatePost();
                  }
                },
                child: Text('Update Post'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updatePost() async {
    try {
      // Update the post in Firestore
      await FirebaseFirestore.instance.collection('jobs').doc(widget.jobId).update({
        'companyName': _companyNameController.text,
        'jobTitle': _jobTitleController.text,
        'jobLocation': _jobLocationController.text,
        'briefDescription': _briefDescriptionController.text,
        // Update any other fields as needed
      });
      print('Post updated successfully');
      Navigator.pop(context); // Navigate back to the previous screen
    } catch (e) {
      print('Error updating post: $e');
    }
  }
}