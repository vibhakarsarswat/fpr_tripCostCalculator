import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Trip Cost Calculator",
      home: FuelForm(),
    );
  }
}

class FuelForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FuelFormState();
}

class _FuelFormState extends State<FuelForm> {

  String result = '';
  String _currency = 'SEK';     // This will be used as the default dropdown item/currency.
  final _currencies = ['USD', 'EUR', 'GBP', 'SEK'];     // This list will be used for displaying as dropdown items.
  final distanceController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    // refer more TextTheme here: https://docs.flutter.io/flutter/material/TextTheme-class.html
    TextStyle textStyle = Theme.of(context).textTheme.title;

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
              // Setting the Controller for this TestField to 'distanceController'
              controller: distanceController,
              decoration: InputDecoration(
                hintText: 'Please enter your name',
                labelText: 'Distance',
                labelStyle: textStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                )
              ),
              keyboardType: TextInputType.number,
            ),


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

            RaisedButton(
              color: Theme.of(context).primaryColorDark,
              textColor: Theme.of(context).primaryColorLight,
              onPressed: () {
                setState(() {
                  result = distanceController.text;
                });
              },

              // Text to display on 'Button' widget
              child: Text(
                'Submit',
                // 'textScaleFactor' is used to change the text size
                textScaleFactor: 1.5,
              ),
            ),

            Text(result),

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