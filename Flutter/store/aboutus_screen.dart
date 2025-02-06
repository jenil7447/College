import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1B3A4B), Color(0xFF2E5568), Color(0xFF3F7185)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove shadow
            title: const Text(
              'About Us',
              style: TextStyle(
                fontFamily: 'Montserrat', // Elegant font
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F2027), Color(0xFF203A43), Color(0xFF2C5364)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // First Container (Contact Information)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.email, color: Colors.white, size: 28),
                        SizedBox(width: 12),
                        Text(
                          'Email: jenil99@example.com',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Icon(Icons.phone, color: Colors.white, size: 28),
                        SizedBox(width: 12),
                        Text(
                          'Phone: +91 82000 40733',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const [
                        Icon(Icons.language, color: Colors.white, size: 28),
                        SizedBox(width: 12),
                        Text(
                          'Website: www.xyz.com',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Second Container (Additional Options)
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.share, color: Colors.white),
                      title: const Text(
                        'Share App',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onTap: () {
                        // Add Share App functionality
                      },
                    ),
                    const Divider(color: Colors.white54),
                    ListTile(
                      leading: const Icon(Icons.apps, color: Colors.white),
                      title: const Text(
                        'More Apps',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onTap: () {
                        // Add More Apps functionality
                      },
                    ),
                    const Divider(color: Colors.white54),
                    ListTile(
                      leading: const Icon(Icons.star, color: Colors.white),
                      title: const Text(
                        'Rate Us',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onTap: () {
                        // Add Rate Us functionality
                      },
                    ),
                    const Divider(color: Colors.white54),
                    ListTile(
                      leading: const Icon(Icons.thumb_up, color: Colors.white),
                      title: const Text(
                        'Like on Facebook',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onTap: () {
                        // Add Like on Facebook functionality
                      },
                    ),
                    const Divider(color: Colors.white54),
                    ListTile(
                      leading: const Icon(Icons.update, color: Colors.white),
                      title: const Text(
                        'Check for Update',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      onTap: () {
                        // Add Check for Update functionality
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}