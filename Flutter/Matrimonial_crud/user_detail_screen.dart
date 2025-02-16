import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class UserDetailScreen extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserDetailScreen({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.deepPurple.shade300,
              Colors.deepPurple.shade50,
              Colors.white,
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 60),
              _buildProfileHeader(),
              _buildDetailCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Hero(
            tag: 'avatar_${userData["fullName"]}',
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.deepPurple[100],
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
          ),
          SizedBox(height: 16),
          Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            userData["fullName"],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: Colors.black26,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: 0.2, end: 0);
  }

  Widget _buildDetailCard() {
    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailSection(
            "Personal Information",
            [
              _buildDetailItem(Icons.cake, "Date of Birth", userData["dob"]),
              _buildDetailItem(Icons.accessibility, "Gender", userData["gender"]),
              _buildDetailItem(Icons.location_on, "City", userData["city"]),
            ],
          ),
          Divider(height: 1),
          _buildDetailSection(
            "Contact Information",
            [
              _buildDetailItem(Icons.email, "Email", userData["email"]),
              _buildDetailItem(Icons.phone, "Mobile", userData["mobile"]),
            ],
          ),
          if (userData["hobbies"] != null && (userData["hobbies"] as List).isNotEmpty)
            Column(
              children: [
                Divider(height: 1),
                _buildHobbiesSection(),
              ],
            ),
        ],
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: 200)).slideY(begin: 0.2, end: 0);
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade700,
            ),
          ),
        ),
        ...children,
      ],
    );
  }

  Widget _buildDetailItem(IconData icon, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade50,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: Colors.deepPurple),
          ),
          SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHobbiesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            "Hobbies",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade700,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: (userData["hobbies"] as List).map((hobby) {
              return Chip(
                label: Text(
                  hobby.toString(),
                  style: TextStyle(
                    color: Colors.deepPurple.shade700,
                    fontSize: 14,
                  ),
                ),
                backgroundColor: Colors.deepPurple.shade50,
              );
            }).toList(),
          ),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}