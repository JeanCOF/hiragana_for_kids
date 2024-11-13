import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // Para tocar o som do hiragana
import 'kana_data.dart'; // Importa o arquivo onde está a lista de kanas

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
      body: Stack(
        children: [
          // Fundo com uma malha de kanas
          Positioned.fill(
            child: KanaGridBackground(kanaSymbol: 'あ'), // Símbolo de exemplo
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Hiragana for Kids',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Patrick Hand',
                  ),
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
                      MaterialPageRoute(
                          builder: (context) => ChallengeScreen()),
                    );
                  },
                  child: Text('Desafio'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Malha de kanas para o fundo
class KanaGridBackground extends StatelessWidget {
  final String kanaSymbol;

  KanaGridBackground({required this.kanaSymbol});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        return Center(
          child: Text(
            kanaSymbol,
            style: TextStyle(fontSize: 36, color: Colors.grey[300]),
          ),
        );
      },
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
  final player = AudioPlayer();

  final List<Color> borderColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
  ];

  Color get currentBorderColor =>
      borderColors[(level ~/ 10) % borderColors.length];

  void nextKana() async {
    setState(() {
      currentKanaIndex = (currentKanaIndex + 1) % kanaList.length;
      if (currentKanaIndex == 0) {
        level++;
      }
    });
    await player.play(
        AssetSource('sounds/${kanaList[currentKanaIndex].pronounce}.mp3'));
  }

  @override
  Widget build(BuildContext context) {
    Kana currentKana = kanaList[currentKanaIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Modo Aprender'),
      ),
      body: Stack(
        children: [
          // Malha de fundo com o kana atual
          Positioned.fill(
            child: KanaGridBackground(kanaSymbol: currentKana.symbol),
          ),
          Center(
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
        ],
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
  String feedbackMessage = ''; // Feedback para X e ✔
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    generateOptions();
  }

  void generateOptions() async {
    setState(() {
      Kana correctKana = kanaList[currentKanaIndex];
      options = [correctKana, ...kanaList.take(2).toList()..shuffle()];
      options.shuffle();
    });
    await player.play(
        AssetSource('sounds/${kanaList[currentKanaIndex].pronounce}.mp3'));
  }

  void checkAnswer(Kana selectedKana) {
    setState(() {
      if (selectedKana == kanaList[currentKanaIndex]) {
        feedbackMessage = '✔'; // Exibe ✔ para resposta correta
        currentKanaIndex = (currentKanaIndex + 1) % kanaList.length;
        generateOptions();
      } else {
        feedbackMessage = 'X'; // Exibe X para resposta incorreta
      }
    });
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        feedbackMessage = ''; // Limpa o feedback após 1 segundo
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Kana currentKana = kanaList[currentKanaIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Modo Desafio'),
      ),
      body: Stack(
        children: [
          // Malha de fundo com o kana atual
          Positioned.fill(
            child: KanaGridBackground(kanaSymbol: currentKana.symbol),
          ),
          Center(
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
                SizedBox(height: 10),
                Text(
                  feedbackMessage,
                  style: TextStyle(
                    fontSize: 32,
                    color: feedbackMessage == '✔' ? Colors.green : Colors.red,
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
        ],
      ),
    );
  }
}
