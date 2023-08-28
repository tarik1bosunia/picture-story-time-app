import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

void main() => runApp(PictureStoryApp());

class PictureStoryApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Picture Story Time',
      home: StoryScreen(),
    );
  }
}

class StoryScreen extends StatefulWidget {
  @override
  _StoryScreenState createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  late FlutterTts flutterTts;
  String storyText = "what can I do this..."; // Replaces with your story text
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();
  }

  Future<void> _speak() async {
    if (!isSpeaking) {
      setState(() {
        isSpeaking = true;
      });
      await flutterTts.setLanguage("en-US");
      await flutterTts.speak(storyText);
      setState(() {
        isSpeaking = false;
      });
    } else {
      await flutterTts.stop();
      setState(() {
        isSpeaking = false;
      });
    }
  }

  @override
  void dispose() {
    if (isSpeaking) {
      flutterTts.stop(); // Stop TTS before disposing
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story Viewer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(storyText), // Display story text here
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _speak,
              child: Text(isSpeaking ? 'Stop Reading' : 'Read Aloud'),
            ),
          ],
        ),
      ),
    );
  }
}
