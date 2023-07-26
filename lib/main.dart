import 'package:flutter/material.dart';
import 'package:flutter_application_5/sqlDb.dart';

import 'CreateQuizScreen.dart';
import 'StartQuizScreen.dart';
// import 'homeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqlDb().initialDb();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      title: ' Quiz App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          textDirection: TextDirection.rtl,
          text: const TextSpan(
            style: TextStyle(fontSize: 20.0, color: Colors.white),
            text: (" Quiz App "),
          ),
        ),
      ),
      drawer: Drawer(
        elevation: 25.0,
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
              accountName: Text('Marah Ramzi Abd El-Qader'),
              accountEmail: Text("marahramzi10@gmail.com"),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.pink,
                child: Text(
                  'M',
                  style: TextStyle(fontSize: 30.0, color: Colors.white),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const CreateQuizScreen();
                }));
              },
              child: const ListTile(
                leading: Icon(Icons.create),
                title: Text('Create Quiz'),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return StartQuiz();
                }));
              },
              child: const ListTile(
                leading: Icon(Icons.question_mark),
                title: Text('Start Quiz'),
              ),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "photos/quiz.png",
              width: 300,
              height: 300,
              fit: BoxFit.fill,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return StartQuiz();
                  }));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: 3.0, horizontal: 25.0),
                  child: Text(
                    "Let's Start!",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 20.0,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
