import 'package:flutter/material.dart';
import 'dart:math';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
       home: const NumberGuessGame(),
    );
  }
}

class NumberGuessGame extends StatefulWidget {
  const NumberGuessGame({super.key});

  @override
  State<NumberGuessGame> createState() => _NumberGuessGameState();
}

class _NumberGuessGameState extends State<NumberGuessGame> {
  int _numberToGuess = Random().nextInt(100) + 1;
  String _message = '私が思い浮かべている数字はなんでしょうか？(1~100)';
  TextEditingController _controller = TextEditingController();
  int _count = 0;

  void _guessNumber() {
    int? userGuess = int.tryParse(_controller.text);
    if(userGuess == null || userGuess <= 0 || userGuess > 100) {
      _message = '1~100の数値を入れてください。';
      setState(() {
        _controller.clear();
      });
      return;
    }
    else if (userGuess == _numberToGuess) {
      _count++;
      _message = 'おめでとうございます！「$userGuess」で正解です！\n${_count}回目で当てました。\n新しい数字を思い浮かべます。';
      _numberToGuess = Random().nextInt(100) + 1;
      _count = 0;
    }
    else if (userGuess > _numberToGuess) {
      _count++;
      _message = '「$userGuess」は大きすぎます！もう一度試してみてください。';
    }
    else if (userGuess < _numberToGuess) {
      _count++;
      _message = '「$userGuess」は小さすぎます！もう一度試してみてください。';
    }
    setState(() {
      _controller.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Number Guessing Game'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _message,
              style: TextStyle(fontSize: 24),

            ),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: '数字を入力してください。',
              ),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: _guessNumber,
              child: const Text('予想を回答する。'),
            )
          ],
        ),
      ),
    );
  }
}

