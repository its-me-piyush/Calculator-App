import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:math_expressions/math_expressions.dart';

import './exchange_rate_screen.dart';

class MyHomePage extends StatefulWidget {
  static const routeName = '/home-page';
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

enum Selected {
  Calaulator,
  ExchangeRate,
}

class _MyHomePageState extends State<MyHomePage> {
  Selected _isSelected = Selected.Calaulator;
  String _currentText = '';
  String _previousText = '';

  void numClick(String text) {
    setState(() {
      _currentText += text;
    });
  }

  void clear() {
    setState(() {
      _currentText = '';
      _previousText = '';
    });
  }

  void backspace() {
    print(_currentText[_currentText.length - 1]);
    clear();
  }

  void evaluate() {
    Parser p = Parser();
    Expression exp = p.parse(_currentText);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    setState(() {
      _previousText = _currentText;
      _currentText = eval.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    NeumorphicButton(
                      style: NeumorphicStyle(
                        color: _isSelected == Selected.Calaulator
                            ? Colors.grey[100]
                            : Colors.white,
                        depth: 2,
                      ),
                      onPressed: () {
                        setState(() {
                          _isSelected = Selected.Calaulator;
                        });
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            'Calculator',
                            style: GoogleFonts.oswald(),
                          ),
                        ),
                      ),
                    ),
                    NeumorphicButton(
                      margin: EdgeInsets.only(left: 20),
                      style: NeumorphicStyle(
                        color: _isSelected == Selected.ExchangeRate
                            ? Colors.grey[100]
                            : Colors.white,
                        depth: 2,
                      ),
                      onPressed: () {
                        setState(() {
                          _isSelected = Selected.ExchangeRate;
                        });
                        Navigator.of(context)
                            .popAndPushNamed(ExchangeRate.routeName);
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            'Exchange Rate',
                            style: GoogleFonts.oswald(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Screen
                Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Neumorphic(
                        style: NeumorphicStyle(
                          depth: -10,
                          shadowLightColorEmboss: Colors.white,
                          shadowDarkColorEmboss: Colors.grey,
                        ),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 3.5,
                          width: double.infinity,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: double.infinity,
                      alignment: Alignment.bottomRight,
                      margin: EdgeInsets.only(bottom: 20, right: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            _previousText,
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                fontSize: 20,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            _currentText,
                            style: GoogleFonts.oswald(
                              textStyle: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.black,
                            ),
                            onPressed: () {
                              clear();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  'C',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.black,
                            ),
                            onPressed: () {
                              numClick('%');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '%',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.black,
                            ),
                            onPressed: () {
                              backspace();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Icon(
                                  Icons.backspace_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.black,
                            ),
                            onPressed: () {
                              numClick('/');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '/',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {
                              numClick('7');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '7',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {
                              numClick('8');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '8',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {
                              numClick('9');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '9',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.black,
                            ),
                            onPressed: () {
                              numClick('*');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  'X',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {
                              numClick('4');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '4',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {
                              numClick('5');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '5',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {
                              numClick('6');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '6',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.black,
                            ),
                            onPressed: () {
                              numClick('-');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '-',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {
                              numClick('1');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '1',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {
                              numClick('2');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '2',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {
                              numClick('3');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '3',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.black,
                            ),
                            onPressed: () {
                              numClick('+');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '+',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {
                              numClick('00');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    '00',
                                    style: GoogleFonts.orbitron(
                                      color: Colors.black,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {
                              numClick('0');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '0',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.white,
                            ),
                            onPressed: () {
                              numClick('.');
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '.',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.black,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            style: NeumorphicStyle(
                              color: Colors.black,
                            ),
                            onPressed: () {
                              evaluate();
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.08,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Center(
                                child: Text(
                                  '=',
                                  style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
}
