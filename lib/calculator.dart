import 'package:flutter/material.dart';

class CalculatorApp extends StatefulWidget {
  @override
  _CalculatorAppState createState() => _CalculatorAppState();
}

class _CalculatorAppState extends State<CalculatorApp> {
  String _input = '';   // Store the input string
  double _result = 0;   // Store the calculated result
  String _operator = '';  // Store the current operator

  void _onButtonPressed(String value) {
    setState(() {
      _input += value;  // Append the pressed button value to the input string
    });
  }

  void _onClearPressed() {
    setState(() {
      _input = '';     // Clear the input string
      _result = 0;     // Reset the result to 0
      _operator = '';  // Reset the operator
    });
  }

  void _onOperatorPressed(String operator) {
    setState(() {
      _operator = operator;        // Store the pressed operator
      _result = double.parse(_input);  // Convert the input string to double and store as the first operand
      _input = '';                 // Reset the input string for the next operand
    });
  }

  void _onCalculatePressed() {
    setState(() {
      double num2 = double.parse(_input);  // Convert the input string to double as the second operand
      switch (_operator) {
        case '+':
          _result += num2;   // Perform addition
          break;
        case '-':
          _result -= num2;   // Perform subtraction
          break;
        case '*':
          _result *= num2;   // Perform multiplication
          break;
        default:
          throw Exception("Invalid operator");  // Throw an exception for invalid operators
      }
      _input = _result.toString();  // Update the input string with the calculated result
      _operator = '';              // Reset the operator
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16.0),
              child: Text(
                _input,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Row(
            children: [
              _buildButton('1'),   // Build buttons for numbers and operators
              _buildButton('2'),
              _buildButton('3'),
              _buildButton('+'),
            ],
          ),
          Row(
            children: [
              _buildButton('4'),
              _buildButton('5'),
              _buildButton('6'),
              _buildButton('-'),
            ],
          ),
          Row(
            children: [
              _buildButton('7'),
              _buildButton('8'),
              _buildButton('9'),
              _buildButton('*'),
            ],
          ),
          Row(
            children: [
              _buildButton('0'),
              _buildButton('.'),
              ElevatedButton(
                onPressed: _onCalculatePressed,
                child: Text('='),
              ),
              ElevatedButton(
                onPressed: _onClearPressed,
                child: Text('Clear'),
              ),
            ],
          ),
      ElevatedButton(
        child: Text(
          "Go back!",
          style: TextStyle(fontSize: 25),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          if (text == '=') {
            _onCalculatePressed(); // Calls _onCalculatePressed() for equal button
          } else if (text == '+' || text == '-' || text == '*') {
            _onOperatorPressed(text);
          } else {
            _onButtonPressed(text);
          }
        },
        child: Text(text),
      ),
    );
  }
}