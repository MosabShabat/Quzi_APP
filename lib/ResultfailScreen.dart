import 'package:flutter/material.dart';

class ResultfailScreen extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultfailScreen({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Quiz App'),
      ),
      body: Center( child: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Oops!' , style: TextStyle(
            color: Color.fromARGB(255, 33, 153, 141),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
        const SizedBox(height: 20,),
          Image.asset(
              "photos/fail.png",
              width:200,
              height: 200,
            ),
          Text(
            'Your score: $score / $totalQuestions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.green[400],
            ),
          ),
          const Text('Sorry,better luck next time!' , style: TextStyle (
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
          )),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
            },
            
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0 , horizontal: 20.0),
              child: Text('Back to home'),
            ),
          ),
        ],
      ),
    ),
    );
  }
}