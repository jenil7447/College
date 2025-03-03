import 'package:flutter/material.dart';
import 'package:flutterbasic/Matrimonial_D/constants/string_constants.dart';
import 'package:flutterbasic/Matrimonial_D/screens/add_user.dart';
import 'package:intl/intl.dart';

class UserDetails extends StatelessWidget {
  final Map<String, dynamic> userDetails;
  final List<Map<String, dynamic>> userList;
  final int index;
  UserDetails({super.key, required this.userDetails, required this.userList, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade900, Colors.purple.shade700],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        elevation: 0,
        titleTextStyle: TextStyle(
          fontSize: 22,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.deepPurple.withOpacity(0.2),
                  child: Icon(Icons.person, size: 60, color: Colors.deepPurple),
                ),
              ),
              SizedBox(height: 20),
              buildSectionTitle('About'),
              buildInfoRow('Name', userDetails[NAME]),
              buildInfoRow('Gender', userDetails[GENDER] ?? 'N/A'),
              buildInfoRow(
                'Date of Birth',
                userDetails[DOB] != null
                    ? DateFormat('dd-MM-yyyy').format(userDetails[DOB] is String
                    ? DateTime.parse(userDetails[DOB])
                    : userDetails[DOB])
                    : 'N/A',
              ),
              buildInfoRow('Marital Status', 'Married'),
              SizedBox(height: 20),
              buildSectionTitle('Religious Background'),
              buildInfoRow('Country', 'India'),
              buildInfoRow('State', 'Gujarat'),
              buildInfoRow('City', userDetails[CITY] ?? 'N/A'),
              buildInfoRow('Religion', 'Hindu'),
              SizedBox(height: 20),
              buildSectionTitle('Professional Details'),
              buildInfoRow('Higher Education', 'M.Tech'),
              buildInfoRow('Occupation', 'Software Engineer'),
              SizedBox(height: 20),
              buildSectionTitle('Hobbies & Interests'),
              buildInfoRow('Hobbies', userDetails[HOBBIES] ?? 'N/A'),
              SizedBox(height: 20),
              buildSectionTitle('Contact Details'),
              buildInfoRow('Email ID', userDetails[EMAIL]),
              buildInfoRow('Phone Number', userDetails[PHONE]),
              buildInfoRow('Address', userDetails[ADDRESS] ?? 'N/A'),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddUser(userList: userList, index: index),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  'Edit',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
