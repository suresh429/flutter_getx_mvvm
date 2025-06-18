import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final title = args['title'];
    final subtitle = args['subtitle'];
    final id = args['id'];

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('ID: $id, Subtitle: $subtitle')),
    );
  }
}
