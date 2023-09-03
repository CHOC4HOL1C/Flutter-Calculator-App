import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final darkBlueColor = const Color(0xFF001C2A);
  final splashColor = const Color(0xFF1D2630);
  final eqlColor = const Color(0xFF56a7c5);
  final whiteColor = const Color(0xFFfbfbfb);
  final keyColor = const Color(0xFF15435a);

  String userInput =  '';
  String result =  '0';

  List<String> buttonList = [
    'v',
    'c',
    'x',
    '/',
    '(',
    ')',
    '%',
    '*',
    '1',
    '2',
    '3',
    '-',
    '4',
    '5',
    '6',
    '+',
    '7',
    '8',
    '9',
    '=',
    '0',
    '00',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBlueColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                      userInput,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white, ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                )
              ],
            ),

          ),
          //Divider
          Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                child: GridView.builder(
                  itemCount: buttonList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        //crossAxisSpacing: 12,
                        //mainAxisSpacing: 12,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return CustomButton(buttonList[index]);

                    },
                ),
              )
          )
        ],
      ),
    );
  }
  Widget CustomButton(String text){
    return InkWell(
      splashColor: splashColor,
      onTap: (){
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          //add other decors later
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: whiteColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,

            ),

          ),
        ),
      ),

    );
  }

  getBgColor(String text) {
    if(text == '=') {
      return eqlColor;
    }
    return keyColor;
  }

  handleButtons(String text) {
    if(text == 'c') {
      if(userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length -1);
        return;
      }
      else{
        return null;
      }
    }
    if(text == '=') {
      result = calculate();
      userInput = result;

      if(userInput.endsWith('.0')) {
        userInput = userInput.replaceAll('.0', '');
      }

      if(result.endsWith('.0')){
        result = result.replaceAll('.0', '');
        return;
      }
    }

    userInput = userInput + text;
  }

  String calculate(){
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch(e) {
      return 'Error';
    }
  }
}
