import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Quotes',

      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent),

        useMaterial3: true,
      ),
      home: const MyHomePage(title: '              Daily Inspiring Quotes'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<String> _quotes = [
    "The only way to do great work is to love what you do. - Steven",
    "Success is not how high you have climbed, but how you make a positive difference to the world. - Roy T. Bennett",
    "Your time is limited, don't waste it living someone else's life. - Steve Jobs",
    "The best way to predict the future is to invent it. - Alan Kay",
    "Life is what happens when you're busy making other plans. - John Lennon"
  ];

  String _currentQuote = "";
  List<String> _favoriteQuotes = [];

  @override
  void initState() {
    super.initState();
    _getRandomQuote();
  }

  void _getRandomQuote() {
    final random = Random();
    setState(() {
      _currentQuote = _quotes[random.nextInt(_quotes.length)];
    });
  }

  void _shareQuote() {
    Share.share(_currentQuote);
  }

  void _saveFavoriteQuote() {
    setState(() {
      if (!_favoriteQuotes.contains(_currentQuote)) {
        _favoriteQuotes.add(_currentQuote);
      }
    });
  }

  void _showFavorites() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FavoritesPage(favoriteQuotes: _favoriteQuotes),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100], // Example background color
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: _showFavorites,
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                _currentQuote,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getRandomQuote,
                child: const Text('New Quote'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _shareQuote,
                    child: const Text('Share'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _saveFavoriteQuote,
                    child: const Text('Save to Favorites'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<String> favoriteQuotes;

  const FavoritesPage({Key? key, required this.favoriteQuotes})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Quotes'),
      ),
      body: ListView.builder(
        itemCount: favoriteQuotes.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(favoriteQuotes[index]),
          );
        },
      ),
    );
  }
}
