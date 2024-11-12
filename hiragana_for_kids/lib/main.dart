import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // Para tocar o som do hiragana
import 'kana_data.dart'; // Importando o arquivo de dados

void main() {
  runApp(HiraganaQuizApp());
}

class HiraganaQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hiragana Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hiragana Quiz'),
        backgroundColor: Colors.lightBlue, // Cor mais viva para a AppBar
      ),
      body: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   image: AssetImage(
            //       'assets/images/neko.png'), // Imagem de fundo infantil
            //   fit: BoxFit.cover,
            // ),
            ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/images/nihongo.png', // Uma imagem divertida ou logo do jogo
              //   width: 200,
              //   height: 200,
              // ),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orangeAccent, // Cor mais vibrante
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HiraganaSelectionPage(),
                    ),
                  );
                },
                child:
                    Text('Practice Hiragana', style: TextStyle(fontSize: 20)),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent, // Outra cor vibrante
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChallengePage()),
                  );
                },
                child: Text('Start Challenge', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HiraganaSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Hiragana'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5, // 5 símbolos por linha
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: kanaList.length + 5,
        itemBuilder: (context, index) {
          int newIndex;

          if (index == 36 ||
              index == 38 ||
              index == 46 ||
              index == 47 ||
              index == 48) {
            return Container();
          } else if (index == 37) {
            newIndex = 36;
          } else if (index >= 39 && index <= 45) {
            newIndex = index - 2;
          } else if (index == 47) {
            newIndex = index - 3;
          } else if (index == 49 || index == 50) {
            newIndex = index - 5;
          } else {
            newIndex = index;
          }

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizPage(
                    symbol: kanaList[newIndex].symbol,
                    pronounce: kanaList[newIndex].pronounce,
                    soundFile: kanaList[newIndex].soundFile,
                    hint: kanaList[newIndex].hint,
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff000000), // cor de fundo do botão
                borderRadius: BorderRadius.circular(8), // bordas arredondadas
                border:
                    Border.all(color: Colors.green, width: 2), // borda verde
              ),
              child: FittedBox(
                // Coloque o FittedBox aqui
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      kanaList[newIndex].symbol,
                      style: TextStyle(fontSize: 30, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      kanaList[newIndex].pronounce,
                      style: TextStyle(fontSize: 14, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final String symbol;
  final String pronounce;
  final String soundFile;
  final String hint;

  QuizPage(
      {required this.symbol,
      required this.pronounce,
      required this.soundFile,
      required this.hint});

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final TextEditingController _controller = TextEditingController();
  String? feedbackMessage;
  bool answered = false;
  final player = AudioPlayer(); // Para tocar áudio

  void _checkAnswer() {
    setState(() {
      answered = true;
      if (_controller.text.trim().toLowerCase() == widget.pronounce) {
        feedbackMessage =
            'Correct! ${widget.symbol} is pronounced "${widget.pronounce}".';
      } else {
        feedbackMessage =
            'Incorrect. ${widget.symbol} is pronounced "${widget.pronounce}".';
      }
      _playSound();
    });
  }

  void _playSound() async {
    await player.play(AssetSource(widget.soundFile)); // Tocar som do hiragana
  }

  void _nextKana() {
    int currentIndex =
        kanaList.indexWhere((kana) => kana.symbol == widget.symbol);
    int nextIndex =
        (currentIndex + 1) % kanaList.length; // Para circular pelos símbolos

    Navigator.pop(context); // Volta para a página anterior
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QuizPage(
            symbol: kanaList[nextIndex].symbol,
            pronounce: kanaList[nextIndex].pronounce,
            soundFile: kanaList[nextIndex].soundFile,
            hint: kanaList[nextIndex].hint),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz: ${widget.symbol}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.symbol,
              style: TextStyle(fontSize: 100),
            ),
            if (answered)
              Image.asset(
                  'assets/mnemonics/${widget.pronounce}.png'), // Exemplo de imagem mnemônica
            if (answered)
              Column(
                children: [
                  Text(
                    feedbackMessage!,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                  SizedBox(height: 8), // Espaçamento entre feedback e hint
                  Text(
                    'Hint: ${widget.hint}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'How does this symbol sound?',
              ),
              enabled: !answered,
            ),
            if (!answered)
              ElevatedButton(
                onPressed: _checkAnswer,
                child: Text('Answer'),
              ),
            if (answered)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _playSound,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.play_arrow),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _nextKana,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Next'),
                        Icon(Icons.arrow_forward),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  int currentKanaIndex = 0;
  int lives = 3;
  bool answered = false;
  String? feedbackMessage;
  String? hintMessage;
  final TextEditingController _controller = TextEditingController();
  final player = AudioPlayer();

  List<Kana> shuffledKanaList = []; // Lista embaralhada dos kanas

  @override
  void initState() {
    super.initState();
    _shuffleKanaList(); // Embaralha a lista ao iniciar a página
  }

  // Função para embaralhar a lista de kanas
  void _shuffleKanaList() {
    shuffledKanaList = List.from(kanaList); // Cria uma cópia da lista original
    shuffledKanaList.shuffle(); // Embaralha a lista
  }

  void _checkAnswer() {
    setState(() {
      answered = true;
      if (_controller.text.trim().toLowerCase() ==
          shuffledKanaList[currentKanaIndex].pronounce) {
        feedbackMessage =
            'Correct! ${shuffledKanaList[currentKanaIndex].symbol} is pronounced "${shuffledKanaList[currentKanaIndex].pronounce}".';
      } else {
        feedbackMessage =
            'Incorrect. ${shuffledKanaList[currentKanaIndex].symbol} is pronounced "${shuffledKanaList[currentKanaIndex].pronounce}".';
        lives--;
      }
      hintMessage =
          'Hint: ${shuffledKanaList[currentKanaIndex].hint}'; // Adicionando a dica
      _playSound();

      if (lives == 0) {
        _gameOver();
      }
    });
  }

  void _playSound() async {
    await player
        .play(AssetSource(shuffledKanaList[currentKanaIndex].soundFile));
  }

  void _nextKana() {
    setState(() {
      if (currentKanaIndex < shuffledKanaList.length - 1) {
        currentKanaIndex++;
        answered = false;
        _controller.clear();
        hintMessage =
            null; // Resetando a dica ao avançar para o próximo símbolo
      } else {
        // Chama o método para mostrar a tela de congratulações
        _showCongratulations();
      }
    });
  }

  // Método para mostrar o pop-up de congratulações
  void _showCongratulations() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Congratulations!'),
          content: Text("You've finished the challenge!"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Volta para a página inicial
              },
              child: Text('Back to Home'),
            ),
          ],
        );
      },
    );
  }

  void _gameOver() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Over'),
          content: Text('You lost all your lives!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('Back to Home'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _showExitWarning();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.favorite,
                      color: Colors.pinkAccent), // Ícones coloridos
                  SizedBox(width: 8),
                  Text('$lives', style: TextStyle(color: Colors.pinkAccent)),
                ],
              ),
              Text('Challenge', style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.lightBlue, // Combinar com o azul claro
        ),
        body: Container(
          color: Colors
              .white, // Fundo branco para combinar com as imagens mnemônicas
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  shuffledKanaList[currentKanaIndex].symbol,
                  style: TextStyle(fontSize: 100, color: Colors.black),
                ),
                if (answered)
                  Image.asset(
                      'assets/mnemonics/${shuffledKanaList[currentKanaIndex].pronounce}.png'),
                if (answered)
                  Text(
                    feedbackMessage!,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                if (answered && hintMessage != null)
                  Text(
                    hintMessage!,
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'How does this symbol sound?',
                  ),
                  enabled: !answered,
                ),
                if (!answered)
                  ElevatedButton(
                    onPressed: _checkAnswer,
                    child: Text('Answer'),
                  ),
                if (answered)
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: _playSound,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.play_arrow),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _nextKana,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Next'),
                            Icon(Icons.arrow_forward),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _showExitWarning() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit Challenge'),
            content: Text(
                'You will lose your progress if you exit. Do you want to continue?'),
            actions: [
              TextButton(
                child: Text('No'),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              TextButton(
                child: Text('Yes'),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          ),
        ) ??
        false;
  }
}
