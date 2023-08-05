
import 'package:calculator_app/colors.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {

  var input = '';
  var output = '';
  var operation = '';
  var hideInput = false;
  var outputSize = 34.0;

  onButtonClick(value){
    //print(value);
    if(value == 'AC'){
      output = '';
      input = '';
    }else if(value == '<' && input.isNotEmpty){
      input = input.substring(0, input.length-1);
    }else if(value == '=' && input.isNotEmpty){
      var userInput = input;
      userInput = input.replaceAll('x', '*');
      Parser p = Parser();
      Expression expression = p.parse(userInput);
      ContextModel cm = ContextModel();
      var finalValue = expression.evaluate(EvaluationType.REAL, cm);
      output = finalValue.toString();
      if(output.endsWith('0')){
        output = output.substring(0,output.length-2);
      }
      input = output;
      hideInput = true;
      outputSize = 52;
    }else{
      input = input + value;
      hideInput = false;
      outputSize = 34;
    }

    setState(() {

    });
  }

  Widget calButton({btnName , tColor = Colors.white , buttonBgColor = buttonColor}){
    return Expanded(
        child: Container(
            margin: const EdgeInsets.all(6),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  backgroundColor: buttonBgColor,
                  padding: EdgeInsets.all(20)),

              onPressed: () => onButtonClick(btnName), child: Text(btnName,
              style: TextStyle(
                fontSize: 25,
                color:tColor,
                fontWeight: FontWeight.bold,
              ),),)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(

        children: [
          //input output area
          Expanded(child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
                Text(
                  hideInput?'':input,
                style: TextStyle(
                  fontSize: 48,
                  color: Colors.white
                ),),
              SizedBox(height: 5,),
              Text(output,
                style: TextStyle(
                    fontSize: outputSize,
                    color: Colors.white.withOpacity(0.7)
                ),)
            ],
          ),)),

          //button area
          Row(
            children: [
              calButton(btnName: 'AC', buttonBgColor: operatorColor , tColor: orangeColor),
              calButton(btnName: '<', buttonBgColor: operatorColor , tColor: orangeColor),
              calButton(btnName: '', buttonBgColor: Colors.transparent),
              calButton(btnName: '/', buttonBgColor: operatorColor , tColor: orangeColor),
            ],
          ),
          Row(
            children: [
              calButton(btnName: '7'),
              calButton(btnName: '8'),
              calButton(btnName: '9'),
              calButton(btnName: 'x', buttonBgColor: operatorColor , tColor: orangeColor)
            ],
          ),
          Row(
            children: [
              calButton(btnName: '4'),
              calButton(btnName: '5'),
              calButton(btnName: '6'),
              calButton(btnName: '-', buttonBgColor: operatorColor , tColor: orangeColor)
            ],
          ),
          Row(
            children: [
              calButton(btnName: '1'),
              calButton(btnName: '2'),
              calButton(btnName: '3'),
              calButton(btnName: '+', buttonBgColor: operatorColor , tColor: orangeColor)
            ],
          ),
          Row(
            children: [
              calButton(btnName: '%', buttonBgColor: operatorColor , tColor: orangeColor),
              calButton(btnName: '0'),
              calButton(btnName: '.', buttonBgColor: operatorColor , tColor: orangeColor),
              calButton(btnName: '=', buttonBgColor: orangeColor)
            ],
          ),
        ],
      ),
    );
  }
}
