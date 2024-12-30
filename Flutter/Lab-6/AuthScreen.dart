import 'package:flutter/material.dart';
class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light background
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Image
                CircleAvatar(
                  radius: 60,
                  backgroundColor: const Color(0xFF9C27B0), // Aesthetic purple border
                  child: CircleAvatar(
                    radius: 56,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150', // Placeholder for profile photo
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Welcome Text
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF673AB7), // Deep Purple
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please log in or sign up to continue',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF757575), // Grey Text
                  ),
                ),
                const SizedBox(height: 32),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    // Add login action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF673AB7), // Deep Purple
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Sign Up Button
                OutlinedButton(
                  onPressed: () {
                    // Add sign-up action
                  },
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFF673AB7)), // Border color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 18, color: Color(0xFF673AB7)),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Or Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: Colors.grey[400],
                        thickness: 1,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'OR',
                        style: TextStyle(color: Color(0xFF757575)),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: Colors.grey[400],
                        thickness: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Google Login
                      },
                      icon: const Icon(Icons.g_mobiledata),
                      iconSize: 32,
                      color: const Color(0xFFDB4437), // Google Red
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      onPressed: () {
                        // Facebook Login
                      },
                      icon: const Icon(Icons.facebook),
                      iconSize: 32,
                      color: const Color(0xFF4267B2), // Facebook Blue
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
