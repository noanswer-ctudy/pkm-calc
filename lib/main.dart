import 'package:flutter/material.dart';
//import 'dart:math';
import 'node.dart';

void main() => runApp(Calculator());

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  List<String> input = [];
  List<String> fomula = ['0'];
  List<String> operandList = [];
  List<String> operatorList = [];
  List<double> integer = [];
  List afterMultiple = [];
  //List afterDevision = [];
  int pressedNum = 0;
  int operand = 0;
  double answer = 0;

  @override
  Widget build(BuildContext context) {
    pressOperand() {
      fomula.removeLast();
      operand = (operand * 10) + pressedNum;
      fomula.add(operand.toString());
    }

    calculate() {
      for (int i = 0; i < fomula.length; i++) {
        if (fomula[i] != '+' &&
            fomula[i] != '-' &&
            fomula[i] != '×' &&
            fomula[i] != '÷' &&
            fomula[i] != '%' &&
            fomula[i] != '.' &&
            fomula[i] != '(' &&
            fomula[i] != ')') {
          operandList.add(fomula[i]);
        } else {
          operatorList.add(fomula[i]);
        }
      }

      for (int i = 0; i < operandList.length; i++) {
        integer.add(double.parse(operandList[i]));
      }

      Node value = Node();
      Node rootNode = value;
      Node targetNode = value;
      Node savedNode = value;

      for (int i = operatorList.length - 1; i <= 0; i--) {
        if (operatorList[i] == '+') {
          targetNode = savedNode;
          targetNode.noperator = '+';
          targetNode = targetNode.left;
          savedNode = targetNode;
        } else if (operatorList[i] == '-') {
          targetNode = savedNode;
          targetNode.noperator = '-';
          targetNode = targetNode.left;
          savedNode = targetNode;
        } else if (operatorList[i] == '×') {
          targetNode = targetNode.right;
          targetNode.noperator = '×';
        } else if (operatorList[i] == '÷') {
          targetNode = targetNode.right;
          targetNode.noperator = '÷';
        }
      }
      targetNode = rootNode;

      for (int i = 0; i < operatorList.length; i++) {
        if (operatorList[i] == '×') {
          afterMultiple.add(integer[i] * integer[i + 1]);
          integer.remove(integer[i]);
          integer.remove(integer[i]);
          operatorList.remove(operatorList[i]);
          i--;
        } else {
          afterMultiple.add(integer[i]);
        }
      }

      if (operatorList.last != '×' && integer.last != afterMultiple.last) {
        afterMultiple.add(integer.last);
      }

      /*
      for (int i = 0; i < operatorList.length; i++){
      if(operatorList[i] == '÷'){
        afterDevision.add(double.parse(afterMultiple[i]) / afterMultiple[i+1]);
      } else {afterDevision.add(levI[i]);}
      }
      for (int i = 0; i < operatorList.length; i++){
        operatorList.remove('÷');
      }*/
      answer = afterMultiple[0];
      for (int i = 0; i < operatorList.length; i++) {
        if (operatorList[i] == '+') {
          answer += afterMultiple[i + 1];
        } else if (operatorList[i] == '-') {
          answer -= afterMultiple[i + 1];
        }
      }
    }

    return MaterialApp(
        title: 'calculator',
        home: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(input.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                    )),
                Text(fomula.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                    )), //fomula
                /*Text(operatorList.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                    )),
                Text(operandList.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                    )),
                Text(integer.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                    )),
                Text(afterMultiple.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                    )),*/
                Text(answer.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.w300,
                    )), //calculatedValue
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(width: 37),
                    IconButton(
                        icon: Icon(
                          Icons.access_time_outlined,
                          color: Colors.grey[600],
                        ),
                        onPressed: null),
                    SizedBox(width: 10),
                    IconButton(
                        icon: Icon(
                          Icons.straighten_outlined,
                          color: Colors.grey[600],
                        ),
                        onPressed: null),
                    SizedBox(width: 10),
                    IconButton(
                        icon: Icon(
                          Icons.calculate_outlined,
                          color: Colors.grey[600],
                        ),
                        onPressed: null),
                    SizedBox(width: 127),
                    IconButton(
                        icon: Icon(
                          Icons.backspace_outlined,
                          color: Colors.lightGreen,
                        ),
                        onPressed: () {
                          setState(() {
                            if (fomula.last == '0') {
                              fomula.removeLast();
                              fomula.removeLast();
                              input.removeLast();
                              operand = int.parse(fomula.last);
                            } else {
                              input.removeLast();
                              fomula.removeLast();
                              operand = operand ~/ 10;
                              fomula.add(operand.toString());
                            }
                          });
                        }),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 2,
                    width: 380,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('C',
                                    style: TextStyle(
                                        color: Colors.red[400],
                                        fontSize: 38,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    input.clear();
                                    fomula.clear();
                                    fomula.add('0');
                                    operand = 0;
                                    operandList.clear();
                                    operatorList.clear();
                                    integer.clear();
                                    afterMultiple.clear();
                                    answer = 0;
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('7',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    pressedNum = 7;
                                    pressOperand();
                                    input.add('7');
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('4',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    pressedNum = 4;
                                    pressOperand();
                                    input.add('4');
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('1',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    pressedNum = 1;
                                    pressOperand();
                                    input.add('1');
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('+/-',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {});
                                })),
                        SizedBox(height: 30),
                      ],
                    ),
                    SizedBox(width: 12),
                    Column(
                      children: [
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('( )',
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 28,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    input.add('(');
                                    fomula.add('(');
                                    fomula.add('0');
                                    operand = 0;
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('8',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    pressedNum = 8;
                                    pressOperand();
                                    input.add('8');
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('5',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    pressedNum = 5;
                                    pressOperand();
                                    input.add('5');
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('2',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    pressedNum = 2;
                                    pressOperand();
                                    input.add('2');
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('0',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    pressedNum = 0;
                                    pressOperand();
                                    input.add('0');
                                  });
                                })),
                        SizedBox(height: 30),
                      ],
                    ),
                    SizedBox(width: 12),
                    Column(
                      children: [
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('%',
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    input.add('%');
                                    fomula.add('%');
                                    fomula.add('0');
                                    operand = 0;
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('9',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    pressedNum = 9;
                                    pressOperand();
                                    input.add('9');
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('6',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    pressedNum = 6;
                                    pressOperand();
                                    input.add('6');
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('3',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 38,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    pressedNum = 3;
                                    pressOperand();
                                    input.add('3');
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 35,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    input.add('.');
                                    fomula.add('.');
                                    fomula.add('0');
                                    operand = 0;
                                  });
                                })),
                        SizedBox(height: 30),
                      ],
                    ),
                    SizedBox(width: 12),
                    Column(
                      children: [
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('÷',
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    input.add('÷');
                                    fomula.add('÷');
                                    fomula.add('0');
                                    operand = 0;
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('×',
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    input.add('×');
                                    fomula.add('×');
                                    fomula.add('0');
                                    operand = 0;
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('-',
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    input.add('-');
                                    fomula.add('-');
                                    fomula.add('0');
                                    operand = 0;
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.grey[800], width: 0.5)),
                                child: Text('+',
                                    style: TextStyle(
                                        color: Colors.lightGreen,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    input.add('+');
                                    fomula.add('+');
                                    fomula.add('0');
                                    operand = 0;
                                  });
                                })),
                        SizedBox(height: 15),
                        Container(
                            width: 85,
                            height: 69.5,
                            child: RaisedButton(
                                color: Colors.lightGreen[800],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                    side: BorderSide(
                                        color: Colors.lightGreen[800],
                                        width: 0.5)),
                                child: Text('=',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 50,
                                        fontWeight: FontWeight.w300)),
                                onPressed: () {
                                  setState(() {
                                    calculate();
                                    /*input.clear();
                                    input.add(answer.toString());
                                    fomula.clear();
                                    fomula.add('0');
                                    operand = 0;
                                    operandList.clear();
                                    operatorList.clear();
                                    integer.clear();
                                    afterMultiple.clear();
                                    pressedNum = answer;
                                    pressOperand();*/
                                  });
                                })),
                        SizedBox(height: 30),
                      ],
                    )
                  ],
                )
              ]),
        ));
  }
}
