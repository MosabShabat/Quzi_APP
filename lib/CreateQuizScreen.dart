import 'package:flutter/material.dart';
import 'addQuestion.dart';
import 'sqlDb.dart'; // Import your SqlDb class

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({Key? key}) : super(key: key);

  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final SqlDb sqlDb = SqlDb();
  String query = 'SELECT * FROM AddQuestions';
  Future<List<Map<String, dynamic>>> fetchData() async {
    return await sqlDb.readData(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Quiz'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              padding: const EdgeInsets.all(10),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text(
                  'Add new question',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return addQuestion();
                    }),
                  );
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(const Size.square(30)),
                ),
              ),
            ),
            FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Map<String, dynamic>> data = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    // scrollDirection: Axis.vertical,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> questionData = data[index];
                      String question = questionData['Question'];
                      String firstAnswer = questionData['FirstAnswer'];
                      String secondAnswer = questionData['SecondAnswer'];
                      String thirdAnswer = questionData['ThirdAnswer'];
                      String fourthAnswer = questionData['FourthAnswer'];
                      String correctAnswer = questionData['CorrectAnswer'];

                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 1),
                        child: Column(
                          children: [
                            Container(
                              height: 350,
                              padding: const EdgeInsets.all(10),
                              color: const Color.fromARGB(255, 241, 241, 241),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        question,
                                        style: const TextStyle(fontSize: 18.0),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Color.fromARGB(
                                                255, 156, 156, 156)),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title:
                                                    const Text('Confirmation'),
                                                content: const Text(
                                                    'Are you sure you want to delete this question?'),
                                                actions: [
                                                  TextButton(
                                                    child: const Text('Cancel'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                  TextButton(
                                                    child: const Text('Delete'),
                                                    onPressed: () async {
                                                      // Delete the question from the database
                                                      await sqlDb.deleteData(
                                                          'DELETE FROM AddQuestions WHERE id = ${questionData['id']}');
                                                      // Refresh the data
                                                      setState(() {});
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  FractionallySizedBox(
                                    widthFactor: 0.97,
                                    child: Flex(
                                      direction: Axis.vertical,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Card(
                                          color: correctAnswer == 'A'
                                              ? Colors.green
                                              : Colors.white,
                                          child: ListTile(
                                            title: Text(
                                              firstAnswer,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                        ),
                                        Card(
                                          color: correctAnswer == 'B'
                                              ? Colors.green
                                              : Colors.white,
                                          child: ListTile(
                                            title: Text(
                                              secondAnswer,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                        ),
                                        Card(
                                          color: correctAnswer == 'C'
                                              ? Colors.green
                                              : Colors.white,
                                          child: ListTile(
                                            title: Text(
                                              thirdAnswer,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                        ),
                                        Card(
                                          color: correctAnswer == 'D'
                                              ? Colors.green
                                              : Colors.white,
                                          child: ListTile(
                                            title: Text(
                                              fourthAnswer,
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18.0),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }

                // Placeholder widget while loading or if there's an error
                return Container();
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
