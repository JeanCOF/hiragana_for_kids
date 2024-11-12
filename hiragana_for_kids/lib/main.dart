// main.dart

import 'package:flutter/material.dart';
import 'kana_data.dart';  // Importa o arquivo onde está a lista de kanas

void main() => runApp(HiraganaApp());

class HiraganaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hiragana for Kids',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiragana for Kids'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Hiragana for Kids',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, fontFamily: 'Patrick Hand'),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LearningScreen()),
                );
              },
              child: Text('Aprender'),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChallengeScreen()),
                );
              },
              child: Text('Desafio'),
            ),
          ],
        ),
      ),
    );
  }
}

class LearningScreen extends StatefulWidget {
  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  int currentKanaIndex = 0;
  int level = 1;

  final List<Color> borderColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];

  Color get currentBorderColor => borderColors[(level ~/ 10) % borderColors.length];

  void nextKana() {
    setState(() {
      currentKanaIndex = (currentKanaIndex + 1) % kanaList.length;
      if (currentKanaIndex == 0) {
        level++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Kana currentKana = kanaList[currentKanaIndex];  // Usando a lista importada

    return Scaffold(
      appBar: AppBar(
        title: Text('Modo Aprender'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: currentBorderColor, width: 3),
              ),
              child: Text(
                currentKana.symbol,
                style: TextStyle(fontSize: 64),
              ),
            ),
            SizedBox(height: 20),
            Text(
              currentKana.pronounce,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(currentKana.hint),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: nextKana,
              child: Text('Próximo'),
            ),
          ],
        ),
      ),
    );
  }
}

class ChallengeScreen extends StatefulWidget {
  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  int currentKanaIndex = 0;
  List<Kana> options = [];

  @override
  void initState() {
    super.initState();
    generateOptions();
  }

  void generateOptions() {
    setState(() {
      Kana correctKana = kanaList[currentKanaIndex];
      options = [correctKana, ...kanaList.take(2).toList()..shuffle()];
      options.shuffle();
    });
  }

  void checkAnswer(Kana selectedKana) {
    if (selectedKana == kanaList[currentKanaIndex]) {
      setState(() {
        currentKanaIndex = (currentKanaIndex + 1) % kanaList.length;
      });
      generateOptions();
    }
  }

  @override
  Widget build(BuildContext context) {
    Kana currentKana = kanaList[currentKanaIndex];  // Usando a lista importada

    return Scaffold(
      appBar: AppBar(
        title: Text('Modo Desafio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 3),
              ),
              child: Text(
                currentKana.symbol,
                style: TextStyle(fontSize: 64),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: options.map((option) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: ElevatedButton(
                    onPressed: () => checkAnswer(option),
                    child: Text(option.pronounce),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
