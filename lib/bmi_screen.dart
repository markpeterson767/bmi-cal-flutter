import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  _BmiScreenState createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  // decalre varibles
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  //
  double _bmiResult = 0;
  String _textResult = '';
  String _imageResult = '';

  //
  bool colorClick = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          stops: const [0.2, 0.32, 0.6, 0.75, 0.85, 0.92],
          colors: (colorClick == false)
              ? [
                  Colors.white,
                  Colors.red.shade100,
                  Colors.red.shade300,
                  Colors.red.shade400,
                  Colors.red.shade600,
                  Colors.red.shade800,
                ]
              : [
                  Colors.white,
                  Colors.amber.shade100,
                  Colors.amber.shade300,
                  Colors.amber.shade400,
                  Colors.amber.shade600,
                  Colors.amber.shade800,
                ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Body Mass Index\nCalculator',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
            //
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Column(
                children: [
                  //!
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //* Height
                      Container(
                        width: 145,
                        child: TextField(
                          controller: _heightController,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey.shade800),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Height(m)',
                            hintStyle: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      //* Weight
                      Container(
                        width: 150,
                        child: TextField(
                          controller: _weightController,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              color: Colors.blueGrey.shade800),
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            hintText: 'Weight(kg)',
                            hintStyle: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),

                  //
                  GestureDetector(
                    onTap: () {
                      double _height = double.parse(_heightController.text);
                      double _weight = double.parse(_weightController.text);

                      setState(() {
                        // todo: Logic of BMI CAL
                        _bmiResult = _weight / (_height * _height);

                        // todo conditions for body type
                        if (_bmiResult > 25) {
                          _textResult =
                              'You are OVERWEIGHT\nMetobolic Type is Ectomorphs\nDo some EXERCISE\nAnd track ur MACROS';

                          _imageResult = 'assets/Endomorphs.png';

                          colorClick = false;
                        } else if (_bmiResult >= 18.5 && _bmiResult <= 25) {
                          _textResult =
                              'You are HEALTHYWEIGHT\nMetobolic Type is Mesomorphs\nKeep it going Stay in Track';

                          _imageResult = 'assets/Mesomorphs.png';

                          colorClick = true;
                        } else {
                          _textResult =
                              'You are UNDERWEIGHT\nMetobolic Type is Ectomorphs\nEat some whole food and gain weight';

                          _imageResult = 'assets/Ectomorphs.png';

                          colorClick = false;
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      margin:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        'Calculate\n Body Mass Index',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Colors.white),
                      ),
                    ),
                  ),

                  // todo: Display the Results

                  Text(
                    _bmiResult.toStringAsFixed(2),
                    style: TextStyle(fontSize: 70, color: Colors.grey.shade900),
                  ),

                  Visibility(
                    visible: _textResult.isNotEmpty,
                    child: Text(
                      _textResult,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey.shade800,
                          fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  Visibility(
                    visible: _imageResult.isNotEmpty,
                    child: Image(
                      image: AssetImage(_imageResult),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
