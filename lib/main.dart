import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hello You",
      home: HelloYou(),
    );
  }
}

class HelloYou extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HelloYouState();
}

class _HelloYouState extends State<HelloYou> {

  String name = '';

  final _currencies = ['USD', 'EUR', 'GBP', 'SEK'];     // This list will be used for displaying as dropdown items.
  String _currency = 'SEK';     // This will be used as the default dropdown item/currency.

  @override
  Widget build(BuildContext context) {
    return Scaffold (
      appBar: AppBar(
        title: Text("Hello"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[

            TextField(
              decoration: InputDecoration(hintText: 'Please enter your name'),
              onSubmitted: (String string) {
                setState(() {
                  // Assigning the value Entered in the TextField to the 'name' variable
                  name = string;
                });
              },
            ),

            Text('Hello ' + name + '!'),

            DropdownButton<String> (

              // value --> It will be used as the currently selected item, or null if no item has been selected.
              value: _currency,

              // items --> represents the LIST of all the items for the DropDown
              items: _currencies.map((String currentvalue){
                return DropdownMenuItem<String>(
                  value: currentvalue,
                  child: Text(currentvalue),
                );
              }).toList(),


              // If 'value' is null then the menu is popped up as if the first item was selected.
              onChanged: (String newValue) {
                _onDropDownChanged(newValue);
              },
            ),
          ],
        ),
      ),
    );
  }

  _onDropDownChanged(String newValue) {
    setState(() {
      this._currency = newValue;
    });
  }
}