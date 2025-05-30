<<<<<<< HEAD
=======
import 'dart:math';
>>>>>>> 583b571 (task 02)
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

<<<<<<< HEAD
class Flashcard {
  String question;
  String answer;

  Flashcard({required this.question, required this.answer});
}

=======
>>>>>>> 583b571 (task 02)
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD

      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.blueGrey,
        appBarTheme: AppBarTheme(color: Colors.cyan),
      ),
      home: FlashcardPage(),
=======
      debugShowCheckedModeBanner: false,
      home: QuoteScreen(),
>>>>>>> 583b571 (task 02)
    );
  }
}

<<<<<<< HEAD
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
=======
class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final List<Map<String, String>> quotes = [
    {"quote": "Opportunities don't happen, you create them."
  , "author": "Chris Grosser"},
    {"quote": "- Don't watch the clock; do what it does. Keep going."
    , "author": "Sam Levenson"},
    {"quote": "- It always seems impossible until it's done." , "author": "Nelson Mandela"},
    {"quote": "It always seems impossible until it’s done.", "author": "Nelson Mandela"},
    {"quote": "Success is not final, failure is not fatal: it is the courage to continue that counts.", "author": "Winston Churchill"},
  ];

  String currentQuote = "Click the button for a quote!";
  String currentAuthor = "";

  void generateQuote() {
    final randomIndex = Random().nextInt(quotes.length);
    setState(() {
      currentQuote = quotes[randomIndex]["quote"]!;
      currentAuthor = quotes[randomIndex]["author"]!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Random Quote Generator",style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
      ),
      body: Center(

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                currentQuote,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlue, fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "- $currentAuthor",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.red,fontSize: 19, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: generateQuote,
                  child: Text("New Quote"),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}





>>>>>>> 583b571 (task 02)
