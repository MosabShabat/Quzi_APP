import 'package:flutter/material.dart';

class ResultSucsses extends StatelessWidget {
  final int score;
  final int totalQuestions;

  ResultSucsses({required this.score, required this.totalQuestions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Quiz App'),
      ),
      body: Center( child: Column( 
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Congratulation!' , style: TextStyle(
            color: Color.fromARGB(255, 33, 153, 141),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
        SizedBox(height: 20,),
          Image.asset(
              "photos/result.jpg",
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
          Text('You are a superstar!' , style: TextStyle (
            fontSize: 15.0,
            fontWeight: FontWeight.w500,
          )),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).popUntil(ModalRoute.withName('/'));
            },
            
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0 , horizontal: 20.0),
              child: Text('Back to home'),
            ),
          ),
        ],
      ),
    ),
    );
  }
}