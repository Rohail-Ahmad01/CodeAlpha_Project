import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Flashcard {
  String question;
  String answer;

  Flashcard({required this.question, required this.answer});
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.blueGrey,
        appBarTheme: AppBarTheme(color: Colors.cyan),
      ),
      home: FlashcardPage(),
    );
  }
}

class FlashcardPage extends StatefulWidget {
  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  List<Flashcard> _flashcards = [
    Flashcard(question: "What is the capital of Japan?", answer: "Tokyo."),
    Flashcard(
      question: "- What is the largest planet in our solar system?",
      answer: "jupiter.",
    ),
    Flashcard(
      question: " What is the smallest unit of matter?",
      answer: "Atom.",
    ),
  ];

  int _currentIndex = 0;
  bool _showAnswer = false;

  void _addFlashcard(String question, String answer) {
    setState(() {
      _flashcards.add(Flashcard(question: question, answer: answer));
    });
  }

  void _editFlashcard(int index, String question, String answer) {
    setState(() {
      _flashcards[index] = Flashcard(question: question, answer: answer);
    });
  }

  void _deleteFlashcard(int index) {
    setState(() {
      _flashcards.removeAt(index);
      if (_currentIndex >= _flashcards.length)
        _currentIndex = _flashcards.length - 1;
    });
  }

  void _showAddFlashcardDialog() {
    TextEditingController questionController = TextEditingController();
    TextEditingController answerController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text("Add Flashcard"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: questionController,
                  decoration: InputDecoration(labelText: "Question"),
                ),
                TextField(
                  controller: answerController,
                  decoration: InputDecoration(labelText: "Answer"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("Cancel"),
              ),
              TextButton(
                onPressed: () {
                  if (questionController.text.isNotEmpty &&
                      answerController.text.isNotEmpty) {
                    _addFlashcard(
                      questionController.text,
                      answerController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text("Add"),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_flashcards.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(title: Text('Flash Quiz'), backgroundColor: Colors.green),
        body: Center(
          child: Text(
            "No Flashcards Available! Add some using the '+' button.",
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddFlashcardDialog,
          child: Icon(Icons.add),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Flash Quiz')),
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _flashcards[_currentIndex].question,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                _showAnswer
                    ? Text(
                      _flashcards[_currentIndex].answer,
                      style: TextStyle(fontSize: 16, color: Colors.blue),
                    )
                    : ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _showAnswer = true;
                        });
                      },
                      child: Text('Show Answer'),
                    ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed:
                          _currentIndex > 0
                              ? () {
                                setState(() {
                                  _currentIndex--;
                                  _showAnswer = false;
                                });
                              }
                              : null,
                      child: Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed:
                          _currentIndex < _flashcards.length - 1
                              ? () {
                                setState(() {
                                  _currentIndex++;
                                  _showAnswer = false;
                                });
                              }
                              : null,
                      child: Text('Next'),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed:
                          () =>
                              _showAddFlashcardDialog(), // You can add an edit dialog here
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteFlashcard(_currentIndex);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddFlashcardDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
