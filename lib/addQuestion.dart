import 'package:flutter/material.dart';

import 'sqlDb.dart';

class addQuestion extends StatefulWidget {
  @override
  State<addQuestion> createState() => _addQuestionState();
}

class _addQuestionState extends State<addQuestion> {
  String item = 'A';
  SqlDb sqlDb = SqlDb();
  final _FirstAnswer = TextEditingController();
  final _secondAnswer = TextEditingController();
  final _ThirdAnswer = TextEditingController();
  final _FourthAnswer = TextEditingController();
  final _Question = TextEditingController();
  late var _item = 'A';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add New Question'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _Question,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                labelText: ' Question',
                prefixIcon: Icon(Icons.question_mark),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 249, 225, 9),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: const Color.fromARGB(255, 249, 225, 9),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'A',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _FirstAnswer,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'First Answer',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.green,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'B',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _secondAnswer,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'Second Answer',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 74, 73, 73),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: const Color.fromARGB(255, 74, 73, 73),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'C',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _ThirdAnswer,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'Third Answer',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(
                      color: Colors.pink,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      'D',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _FourthAnswer,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      labelText: 'Fourth Answer',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Select the correct answer ',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20.0),
                ),
                DropdownButton(
                  value: _item,
                  items: dropdownItems,
                  onChanged: (value) {
                    setState(() {
                      _item = value!;
                    });
                  },
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                int response =
                    await sqlDb.insertData('''INSERT INTO 'AddQuestions' 
    (Question , FirstAnswer , SecondAnswer , ThirdAnswer , FourthAnswer , CorrectAnswer)
    VALUES ("${_Question.text}" ,"${_FirstAnswer.text}" , "${_secondAnswer.text}" , "${_ThirdAnswer.text}" , "${_FourthAnswer.text}" ,"${_item}" ) ''');

                if (response != 0) {
                  // Insertion successful
                  String query =
                      'SELECT * FROM AddQuestions WHERE id = $response'; // Replace with your table name and primary key column name

                  // Fetch the inserted data
                  List<Map<String, dynamic>> results =
                      await sqlDb.readData(query);

                  // Print the inserted data
                  results.forEach((row) {
                    print(row);
                  });
                }
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: const Center(
                      child: Text(
                    'Add Question',
                    style: TextStyle(fontSize: 15),
                  ))),
            ),
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuItem<String>> get dropdownItems {
  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "A", child: Text("A")),
    const DropdownMenuItem(value: "B", child: Text("B")),
    const DropdownMenuItem(value: "C", child: Text("C")),
    const DropdownMenuItem(value: "D", child: Text("D")),
  ];
  return menuItems;
}
//String query = 'SELECT * FROM AddQuestions';