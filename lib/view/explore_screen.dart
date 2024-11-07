import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text('Explore Screen'),
      ),
      body: const Center(
        child: Text(
          'Explore Screen Content',
          style: TextStyle(fontSize: 18, color: Colors.black), // Styling the text
        ),
      ),
    );
  }
}
