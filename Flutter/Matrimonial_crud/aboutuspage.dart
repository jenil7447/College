import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        elevation: 4,
        shadowColor: Colors.purple.withOpacity(0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Improved Logo Section
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.deepPurple, width: 3),
                  image: DecorationImage(
                    image: AssetImage('assets/images/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Matrimony',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 16),

              // Team Information Card
              _buildCard(
                title: 'Meet Our Team',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('Developed by', 'jenil jethva (23010101108)'),
                    _buildInfoRow('Mentored by', 'Prof. Mehul Bhundiya'),
                    _buildInfoRow('Explored by', 'ASWDC, School of Computer Science'),
                    _buildInfoRow('Eulogized by', 'Darshan University, Rajkot, Gujarat - INDIA'),
                  ],
                ),
              ),

              // ASWDC Section
              _buildCard(
                title: 'About ASWDC',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildLogo('assets/images/darshan_logo.png'),
                        const SizedBox(width: 16),
                        _buildLogo('assets/images/matrimonial.png'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'ASWDC is Application, Software and Website Development Center @ Darshan University run by Students and Staff of School Of Computer Science.',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Sole purpose of ASWDC is to bridge the gap between university curriculum & industry demands.',
                      style: TextStyle(fontSize: 14),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              // Contact Information Card
              _buildCard(
                title: 'Contact Us',
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildContactRow(Icons.email, 'aswdc@darshan.ac.in'),
                    _buildContactRow(Icons.phone, '+91-8200040733'),
                    _buildContactRow(Icons.language, 'www.darshan.ac.in'),
                  ],
                ),
              ),

              // Footer
              const SizedBox(height: 16),
              Text(
                '© 2025 Darshan University',
                style: TextStyle(fontSize: 12, color: Colors.purple[600]),
              ),
              Text(
                'All Rights Reserved - Privacy Policy',
                style: TextStyle(fontSize: 12, color: Colors.purple[600]),
              ),
              Text(
                'Made with ❤️ in India',
                style: TextStyle(fontSize: 12, color: Colors.purple[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Reusable card widget
  Widget _buildCard({required String title, required Widget child}) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.deepPurple.withOpacity(0.2), width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }

  // Logo display widget
  Widget _buildLogo(String assetPath) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.contain,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: '$title: ',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            TextSpan(text: content),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String content) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.deepPurple, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              content,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}