import 'package:flutter/material.dart';

class StoryListPage extends StatelessWidget {
  const StoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Story List"),
      ),
      body: Padding(
        padding:const EdgeInsets.all(0.8),

      ),
    );
  }
}
