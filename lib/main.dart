import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() {
  runApp(Quizzler());
}

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [];
  int number = 0;
  int reached = 0;
  void showDialog(){
    Alert(
      context: context,
      type: AlertType.error,
      title: "END OF QUIZ",
      desc: "question limit reached",
      buttons: [
        DialogButton(
          child: Text(
            "reset",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => setState(() {
            scorekeeper.clear();
            number = 0;
            Navigator.pop(context);
          }),
          width: 120,
        )
      ],
    ).show();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(number),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.green,
              child: Text(
                'TRUE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: (){
                //action on true pick up
                if(quizBrain.getQuestionAnswer(number) == true){
                  setState(() {
                    scorekeeper.add(
                      Icon(Icons.check,color: Colors.green,),
                    );
                  });
                }
                else{
                  setState(() {
                    scorekeeper.add(
                      Icon(Icons.close,color: Colors.red,),
                    );
                  });
                }
                if(reached == 1){
                  showDialog();
                  reached = 0;
                }
                if(number < 12){
                  number++;
                }
                if(number == 12){
                  reached = 1;
                }
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'FALSE',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: (){
                //action on true pick up
                if(quizBrain.getQuestionAnswer(number) == false){
                  setState(() {
                    scorekeeper.add(
                      Icon(Icons.check,color: Colors.green,),
                    );
                  });
                }
                else{
                  setState(() {
                    scorekeeper.add(
                      Icon(Icons.close,color: Colors.red,),
                    );
                  });
                }
                if(reached == 1){
                  showDialog();
                  reached = 0;
                }
                if(number < 12){
                  number++;
                }
                if(number == 12){
                  reached = 1;
                }
              },
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        ),
        SizedBox(
          height: 20.0,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: FloatingActionButton(
                  child: Icon(Icons.arrow_back_ios),
                  onPressed: (){
                    //action on true pick up
                    setState(() {
                      scorekeeper.removeLast();
                      if(number > 0){number--;}
                      else if(number == 0){number = 12;}
                    });
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(30.0),
                child: FloatingActionButton(
                  child: Icon(Icons.backspace),
                  onPressed: (){
                    //action on true pick up
                    setState(() {
                      scorekeeper.clear();
                      number = 0;
                    });
                  },
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

