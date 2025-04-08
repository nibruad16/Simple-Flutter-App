import 'package:flutter/material.dart';
import 'package:logger/logger.dart';


void main(){
  runApp( const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){

    return MaterialApp(
      title: 'Fluter Layout Lab',
      home: Scaffold(appBar: AppBar(
        title: const Text('Flutter Layout Lab'),
      ),

       body: MyForm()
        ) 
    );
  }

}


class MyForm extends StatefulWidget{
  const MyForm({super.key});
  @override
  _MyFormState createState() => _MyFormState();

}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final Logger _logger = Logger();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const <Widget>[
              Icon(Icons.star, color: Colors.blue),
              Icon(Icons.favorite, color: Colors.red),
              Icon(Icons.share, color: Colors.green),
            ],
          ),
          const Text('welcome to flutter app'),
          const Text('Bulding a layout is easy'),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Enter your name'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'please enter your name';
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _logger.i('Form is valid. User input is logged.'); // Log the user input
                showAlertDialog(context, 'Form Submitted', 'User input is logged.');
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}

void showAlertDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}