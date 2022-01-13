import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'game.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final _controller = TextEditingController();
  var random = Random();
  var answer = 0;
  var count =0;
  var sum =0 ;


  @override
  Widget build(BuildContext context) {

    answer = random.nextInt(100) + 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('GUESS THE NUMBER'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orange.shade50,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.shade100,
                offset: Offset(5.0, 5.0),
                spreadRadius: 2.0,
                blurRadius: 5.0,
              )
            ],
          ),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /*Row(
                children: [
                  Container(width: 50.0, height: 50.0, color: Colors.blue),
                  Expanded(
                    child: Container(
                      width: 30.0,
                      height: 50.0,
                      //color: Colors.pink,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text('FLUTTER', textAlign: TextAlign.end,),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                  //SizedBox(width: 10.0),
                ],
              ),*/
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/guess_logo.png', width: 90.0),
                    SizedBox(width: 8.0),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('GUESS',
                            style: TextStyle(
                                fontSize: 36.0, color: Colors.deepOrange.withOpacity(0.4))),
                        Text(
                          'THE NUMBER',
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.deepOrange.withOpacity(1),
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  controller: _controller,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(),
                    hintText: 'ทายเลขตั้งแต่ 1 ถึง 100',
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ElevatedButton(
                  child: Text('GUESS'),
                  onPressed: () {
                    var game = Game(answer);
                    var input = _controller.text;
                    var r = answer.toString();


                    print('ทดสอบเฉลย: ' + r.toString());


                    var guess = int.tryParse(input);

                    if(guess == null){
                      print(
                          "กรอกข้อมูลไม่ถูกต้อง ให้กรอกเฉพาะตัวเลขเท่านั้น");
                      showDialog(
                      context: context,
                         barrierDismissible: false,
                        builder: (BuildContext context) {
                        return AlertDialog(
                          title : Text('ERROR',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                        content :Text( 'กรอกข้อมูลไม่ถูกต้อง \n กรุณากรอกแค่ตัวเลขเท่านั้น'),
                          actions: [
                            ElevatedButton
                              (onPressed: () {
                              Navigator.of(context).pop();
                            },
                                child: Text('OK'))
                          ],
                        );
                        });


                    /////// มากเกิน
                    }else{
                      var res = game.Guess(guess);
                      if(res==1){

                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title : Text('RESULT',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                content :Text( '$guess มากเกินไป กรุณาลองใหม่!'),

                                actions: [
                                  ElevatedButton
                                    (onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                      child: Text('OK'))
                                ],
                              );
                            });


                          count++;

                      /////น้อยเกิน
                      }else if (res==-1){

                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title : Text('RESULT',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                content :Text( '$guess น้อยเกินไป กรุณาลองใหม่!'),

                                actions: [
                                  ElevatedButton
                                    (onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                      child: Text('OK'))
                                ],
                              );
                            });

                       count++;



                      }else if (res== 0){

                         sum=count+1;
                         count = 0;
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title : Text('RESULT',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                content :Text( '      $guess ถูกต้องแล้ว \n คุณทายไปทั้งหมด $sum ครั้ง \n คุณสามารถเริ่มใหม่่โดยการทายเลขครั้งต่อไป'),

                                actions: [
                                  ElevatedButton
                                    (onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                      child: Text('OK'))
                                ],
                              );
                            });

                        answer = random.nextInt(100) + 1;


                      }



                    }


                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
