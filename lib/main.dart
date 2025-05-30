import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Model for a flashcard.
class Flashcard {
  String question;
  String answer;

  Flashcard({required this.question, required this.answer});
}

// MyApp sets up the MaterialApp and uses HomeScreen as the home.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashcard and Quote App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.blueGrey,
        appBarTheme: AppBarTheme(color: Colors.cyan),
      ),
      home: HomeScreen(), // Use one entry widget that switches screens.
    );
  }
}

// HomeScreen uses a BottomNavigationBar to switch between Flashcards and Quotes.
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget>[
    FlashcardPage(),
    QuoteScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.cyan,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz),
            label: 'Flashcards',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_quote),
            label: 'Quotes',
          ),
        ],
      ),
    );
  }
}

// FlashcardPage manages a list of flashcards with add, edit, and delete functionality.
class FlashcardPage extends StatefulWidget {
  @override
  _FlashcardPageState createState() => _FlashcardPageState();
}

class _FlashcardPageState extends State<FlashcardPage> {
  List<Flashcard> _flashcards = [
    Flashcard(question: "What is the capital of Japan?", answer: "Tokyo."),
    Flashcard(question: "What is the largest planet in our solar system?", answer: "Jupiter."),
    Flashcard(question: "What is the smallest unit of matter?", answer: "Atom."),
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
      if (_currentIndex >= _flashcards.length) {
        _currentIndex = _flashcards.isNotEmpty ? _flashcards.length - 1 : 0;
      }
    });
  }

  // Dialog to add a new flashcard.
  void _showAddFlashcardDialog() {
    TextEditingController questionController = TextEditingController();
    TextEditingController answerController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Flashcard"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: questionController,
              decoration: const InputDecoration(labelText: "Question"),
            ),
            TextField(
              controller: answerController,
              decoration: const InputDecoration(labelText: "Answer"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (questionController.text.isNotEmpty &&
                  answerController.text.isNotEmpty) {
                _addFlashcard(questionController.text, answerController.text);
                Navigator.pop(context);
              }
            },
            child: const Text("Add"),
          ),
        ],
      ),
    );
  }

  // Dialog to edit an existing flashcard.
  void _showEditFlashcardDialog() {
    TextEditingController editQuestionController =
    TextEditingController(text: _flashcards[_currentIndex].question);
    TextEditingController editAnswerController =
    TextEditingController(text: _flashcards[_currentIndex].answer);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Flashcard"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: editQuestionController,
              decoration: const InputDecoration(labelText: "Question"),
            ),
            TextField(
              controller: editAnswerController,
              decoration: const InputDecoration(labelText: "Answer"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              if (editQuestionController.text.isNotEmpty &&
                  editAnswerController.text.isNotEmpty) {
                _editFlashcard(
                  _currentIndex,
                  editQuestionController.text,
                  editAnswerController.text,
                );
                Navigator.pop(context);
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If no flashcards exist, show a message.
    if (_flashcards.isEmpty) {
      return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: const Text('Flash Quiz'),
          backgroundColor: Colors.green,
        ),
        body: const Center(
          child: Text("No Flashcards Available! Add some using the '+' button."),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddFlashcardDialog,
          child: const Icon(Icons.add),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Flash Quiz')),
      body: Center(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(16),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _flashcards[_currentIndex].question,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                _showAnswer
                    ? Text(
                  _flashcards[_currentIndex].answer,
                  style: const TextStyle(fontSize: 16, color: Colors.blue),
                )
                    : ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showAnswer = true;
                    });
                  },
                  child: const Text('Show Answer'),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _currentIndex > 0
                          ? () {
                        setState(() {
                          _currentIndex--;
                          _showAnswer = false;
                        });
                      }
                          : null,
                      child: const Text('Previous'),
                    ),
                    ElevatedButton(
                      onPressed: _currentIndex < _flashcards.length - 1
                          ? () {
                        setState(() {
                          _currentIndex++;
                          _showAnswer = false;
                        });
                      }
                          : null,
                      child: const Text('Next'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: _showEditFlashcardDialog,
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
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
        child: const Icon(Icons.add),
      ),
    );
  }
}

// QuoteScreen displays random quotes that update when you tap the button.
class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final List<Map<String, String>> quotes = [
    {"quote": "Opportunities don't happen, you create them.", "author": "Chris Grosser"},
    {"quote": "Don't watch the clock; do what it does. Keep going.", "author": "Sam Levenson"},
    {"quote": "It always seems impossible until it's done.", "author": "Nelson Mandela"},
    {
      "quote": "Success is not final, failure is not fatal: it is the courage to continue that counts.",
      "author": "Winston Churchill"
    },
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
        title: const Text("Random Quote Generator", style: TextStyle(color: Colors.white)),
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
                style: const TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "- $currentAuthor",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 19,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: generateQuote,
                child: const Text("New Quote"),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}




