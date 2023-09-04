import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:picture_story_time_app/models/models.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add New Story'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Title'),
                  Text('Image'),
                  Text('Content'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Save'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Story Library'),
        backgroundColor: Colors.transparent,
        leading: const Icon(Icons.menu),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: Icon(Icons.person),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: "",
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: storyList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the story viewer screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      StoryViewerScreen(story: storyList[index]),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                leading: Image.asset(
                  storyList[index].coverImage,
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  "${storyList[index].title.length > 30 ? storyList[index].title.substring(0, 30) : storyList[index].title}...",
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: _showMyDialog,
        child: const Icon(Icons.add),
      ),
    );
  }
}

class StoryViewerScreen extends StatefulWidget {
  StoryViewerScreen({super.key, required this.story});

  final Story story;

  FlutterTts flutterTts = FlutterTts();

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreen();
}

class _StoryViewerScreen extends State<StoryViewerScreen> {
  bool playing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.story.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              widget.story.coverImage,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.story.content,
                style: TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                // Implement interactive elements or read-aloud functionality
                if (playing) {
                  await widget.flutterTts.pause();
                } else {
                  await widget.flutterTts.speak(widget.story.content);
                }
                setState(() {
                  playing = !playing;
                });
              },
              child: Text(playing ? 'Pause' : 'Read Aloud'),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';
//
// void main() => runApp(PictureStoryApp());
//
// class PictureStoryApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Picture Story Time',
//       home: StoryScreen(),
//     );
//   }
// }
//
// class StoryScreen extends StatefulWidget {
//   @override
//   _StoryScreenState createState() => _StoryScreenState();
// }
//
// class _StoryScreenState extends State<StoryScreen> {
//   late FlutterTts flutterTts;
//   String storyText = "what can I do this..."; // Replaces with your story text
//   bool isSpeaking = false;
//
//   @override
//   void initState() {
//     super.initState();
//     flutterTts = FlutterTts();
//   }
//
//   Future<void> _speak() async {
//     if (!isSpeaking) {
//       setState(() {
//         isSpeaking = true;
//       });
//       await flutterTts.setLanguage("en-US");
//       await flutterTts.speak(storyText);
//       setState(() {
//         isSpeaking = false;
//       });
//     } else {
//       await flutterTts.stop();
//       setState(() {
//         isSpeaking = false;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     if (isSpeaking) {
//       flutterTts.stop(); // Stop TTS before disposing
//     }
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Story Viewer'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(storyText), // Display story text here
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _speak,
//               child: Text(isSpeaking ? 'Stop Reading' : 'Read Aloud'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
