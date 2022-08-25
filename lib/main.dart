import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI kalkylator',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const MyHomePage(title: 'BMI kalkylator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double _bmiNumber = 0.0;
  String _kategori = '';
  

  // Controllers:
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  void _calculateBmi() {
    final heightInputText = heightController.text;
    final weightInputText = weightController.text;

    final height = double.parse(heightInputText);
    final weight = double.parse(weightInputText);

    final double result = weight / pow(height / 100,2);
    print('calculate Bmi running');
    
    
    setState(() {
      _bmiNumber = double.parse(result.toStringAsFixed(1));
      heightController.text = '';
      weightController.text = '';

      if(result <= 18.5){
      _kategori = 'underviktig';
      }else if(result > 18.5 && result <= 24.9){
        _kategori = 'Ok enligt samhället';
      }else if(result >24.9 && result <=29.9){
        _kategori = 'Överviktig';
      }else if(result > 29.9 && result <= 34.9){
        _kategori = 'Fetma';
      }else if(result >34.9 && result > 35){
        _kategori = 'Extrem fetma';
      }else{
        _kategori = 'Försök igen';
      }
      
    });
  }
  

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text('Skriv in längd och vikt för att räkna ut BMI'),
            Card(
              child: SizedBox(
                width: 300,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Text('$_bmiNumber',
                  style: const TextStyle(fontSize: 40),),
                  const Padding(padding: EdgeInsets.all(8)),
                  Text(_kategori),
                ]),
              ),
            ),
            Column(children: <Widget>[
              TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter height:'
              ),
              controller: heightController,
            ),
            TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter weight:'
              ),
              controller: weightController,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            ElevatedButton(
              onPressed: _calculateBmi, 
              child: const Text('Calculate'),
              ),
            ],)
            
          ],
        ),
      ),
    );
  }
}


