import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(QuoteApp());
}

class QuoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuoteScreen(),
    );
  }
}

class QuoteScreen extends StatefulWidget {
  @override
  _QuoteScreenState createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final List<Map<String, String>> quotes = [
    {"text": "The only way to do great work is to love what you do.", "author": "Steve Jobs"},
    {"text": "Be the change that you wish to see in the world.", "author": "Mahatma Gandhi"},
    {"text": "Believe you can and you're halfway there.", "author": "Theodore Roosevelt"},
    {"text": "Happiness depends upon ourselves.", "author": "Aristotle"},
  ];

  String quoteText = "";
  String quoteAuthor = "";

  void generateQuote() {
    final random = Random();
    final randomQuote = quotes[random.nextInt(quotes.length)];
    setState(() {
      quoteText = randomQuote["text"]!;
      quoteAuthor = randomQuote["author"]!;
    });
  }

  @override
  void initState() {
    super.initState();
    generateQuote();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Random Quote Generator")),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                quoteText,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                "- $quoteAuthor",
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: generateQuote,
                child: Text("New Quote"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
