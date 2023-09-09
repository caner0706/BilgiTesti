import 'package:flutter/material.dart';

void main() => runApp(BilgiTesti());

class BilgiTesti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.indigo[700],
        appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          title: Text('Bilgi Testi Uygulaması'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: SoruSayfasi(),
          ),
        ),
      ),
    );
  }
}

class SoruSayfasi extends StatefulWidget {
  @override
  _SoruSayfasiState createState() => _SoruSayfasiState();
}

List<Widget> election = [];
List<String> question = [
  "Titanic Gelmiş Geçmiş En Büyük Gemidir ?",
  "Dünyadaki Tavuk Sayısı İnsan Sayısından Fazladır ?",
  "Kelebeklerin Ömrü Bir Gündür ?",
  "Dünya Düzdür ?",
  "Kaju Fıstığı Aslında Bir Meyvedir ?",
  "Fatih Sultan Mehmet Hiç Patates Yememiştir ?",
  "Kara Delikler Gerçek Varlıklar Mıdır ?",
  "Evrim Teorisi Bilimsel Bir Gerçekliği Temsil Eder ?",
  "Dünya Güneş Sistemindedir ?",
  "Fizik Bir Bilim Dalıdır ?",
];
List<bool> answer = [false, true, false, false, true, true, true, true, true, true];
int questionIndex = 0;
int correctAnswers = 0; // Doğru cevap sayısı
int totalQuestions = question.length; // Toplam soru sayısı

class _SoruSayfasiState extends State<SoruSayfasi> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                "Soru ${questionIndex + 1}",
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                question[questionIndex],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2, // Değişiklik burada
          child: Center(
            child: Wrap(
              spacing: 3,
              runSpacing: 3,
              children: election,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red[400],
                      ),
                      onPressed: () {
                        setState(() {
                          if (answer[questionIndex] == false) {
                            election.add(trueIcon);
                            correctAnswers++;
                          } else {
                            election.add(falseIcon);
                          }
                          questionIndex++;
                          if (questionIndex >= question.length) {
                            questionIndex = 0;
                            _showFinishDialog();
                          }
                        });
                      },
                      child: const Icon(
                        Icons.thumb_down,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green[400],
                      ),
                      onPressed: () {
                        setState(() {
                          if (answer[questionIndex] == true) {
                            election.add(trueIcon);
                            correctAnswers++;
                          } else {
                            election.add(falseIcon);
                          }
                          questionIndex++;
                          if (questionIndex >= question.length) {
                            questionIndex = 0;
                            _showFinishDialog();
                          }
                        });
                      },
                      child: const Icon(
                        Icons.thumb_up,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showFinishDialog() {
    int successRate = ((correctAnswers / totalQuestions) * 100).toInt();
    int successPoints = correctAnswers * 10;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Tüm Soruları Bitirdiniz"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Tebrikler! Tüm soruları başarıyla bitirdiniz."),
              SizedBox(height: 10),
              Text("Başarı Oranınız: $successRate%", style: TextStyle(fontSize: 14)),
              Text("Başarı Puanınız: $successPoints", style: TextStyle(fontSize: 14)),
            ],
          ),
          actions: [
            TextButton(
              child: Text("Kapat", style: TextStyle(fontSize: 16)),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  election.clear(); // Seçim listesini temizle
                  correctAnswers = 0; // Doğru cevap sayısını sıfırla
                  questionIndex = 0; // Soru indeksini sıfırla
                });
              },
            ),
          ],
        );
      },
    );
  }
}

Icon trueIcon = Icon(
  Icons.mood,
  color: Colors.green,
);

Icon falseIcon = Icon(
  Icons.mood_bad,
  color: Colors.red,
);