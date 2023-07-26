import 'package:flutter/material.dart';
import 'package:flutter_application_5/sqlDb.dart';

import 'ResultSucsses.dart';
import 'ResultfailScreen.dart';

class StartQuiz extends StatefulWidget {
  @override
  _StartQuizState createState() => _StartQuizState();
}

class _StartQuizState extends State<StartQuiz> {
  int mark = 0;
  final SqlDb sqlDb = SqlDb();
  String query = 'SELECT * FROM AddQuestions';
  Future<List<Map<String, dynamic>>> fetchData() async {
    return await sqlDb.readData(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<Map<String, dynamic>>>(
            future: fetchData(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Map<String, dynamic>> data = snapshot.data!;
                return Column(
                  children: [
                    const SizedBox(
                      height: 150,
                    ),
                    SizedBox(
                      height: 350,
                      child: PageView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount:
                            data.length + 1, // Add 1 for the last element
                        itemBuilder: (context, index) {
                          if (index == data.length) {
                            var mid = data.length / 2;
                            // Last element
                            return SizedBox(
                              width: 200,
                              height: 200,
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "Done...Good Luck",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                    const SizedBox(height: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        if (mark >= mid) {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return ResultSucsses(
                                              score: mark,
                                              totalQuestions: data.length,
                                            );
                                          }));
                                        } else {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return ResultfailScreen(
                                              score: mark,
                                              totalQuestions: data.length,
                                            );
                                          }));
                                        }
                                      },
                                      child: const Text(
                                        "Tap to Submit and show mark",
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            // Regular question
                            Map<String, dynamic> questionData = data[index];
                            String question = questionData['Question'];
                            String firstAnswer = questionData['FirstAnswer'];
                            String secondAnswer = questionData['SecondAnswer'];
                            String thirdAnswer = questionData['ThirdAnswer'];
                            String fourthAnswer = questionData['FourthAnswer'];
                            String correctAnswer =
                                questionData['CorrectAnswer'];
                            List<String?> selectedValues =
                                List.filled(data.length, null);
                            return Center(
                              child: Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(12),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          color: Colors.teal,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          border: Border.all(
                                            color: Colors.teal,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(12),
                                          child: Text(
                                            question,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      RadioListTile(
                                        title: Text(firstAnswer),
                                        value: firstAnswer,
                                        groupValue: selectedValues[index],
                                        onChanged: (value) {
                                          setState(() {
                                            if (correctAnswer == 'A') {
                                              mark += 1;
                                            }
                                            selectedValues[index] =
                                                value as String?;
                                          });
                                        },
                                        activeColor:
                                            selectedValues[index] == firstAnswer
                                                ? Colors.teal
                                                : null,
                                      ),
                                      const SizedBox(height: 10),
                                      RadioListTile(
                                        title: Text(secondAnswer),
                                        value: secondAnswer,
                                        groupValue: selectedValues[index],
                                        onChanged: (value) {
                                          setState(() {
                                            if (correctAnswer == 'B') {
                                              mark += 1;
                                            }
                                            selectedValues[index] =
                                                value as String?;
                                          });
                                        },
                                        activeColor: selectedValues[index] ==
                                                secondAnswer
                                            ? Colors.teal
                                            : null,
                                      ),
                                      const SizedBox(height: 10),
                                      RadioListTile(
                                        title: Text(thirdAnswer),
                                        value: thirdAnswer,
                                        groupValue: selectedValues[index],
                                        onChanged: (value) {
                                          setState(() {
                                            if (correctAnswer == 'C') {
                                              mark += 1;
                                            }
                                            selectedValues[index] =
                                                value as String?;
                                          });
                                        },
                                        activeColor:
                                            selectedValues[index] == thirdAnswer
                                                ? Colors.teal
                                                : null,
                                      ),
                                      const SizedBox(height: 10),
                                      RadioListTile(
                                        title: Text(fourthAnswer),
                                        value: fourthAnswer,
                                        groupValue: selectedValues[index],
                                        onChanged: (value) {
                                          setState(() {
                                            if (correctAnswer == 'D') {
                                              mark += 1;
                                            }
                                            selectedValues[index] =
                                                value as String?;
                                          });
                                        },
                                        activeColor: selectedValues[index] ==
                                                fourthAnswer
                                            ? Colors.teal
                                            : null,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 200,
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}
