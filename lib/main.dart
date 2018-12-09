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
  final _currencies = ['USD', 'EUR', 'GBP', 'SEK', 'INR'];     // This list will be used for displaying as dropdown items.
  TextEditingController distanceController = TextEditingController();
  TextEditingController avgController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  final FocusNode _focusNode = new FocusNode();

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

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                autofocus: true,
                // Setting the Controller for this TestField to 'Controller'
                controller: distanceController,
                decoration: InputDecoration(
                    labelText: 'Total Distance Travelled',
                    hintText: 'e.g. 147',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
                keyboardType: TextInputType.number,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: TextField(
                // Setting the Controller for this TestField to 'distanceController'
                controller: avgController,
                decoration: InputDecoration(
                    labelText: 'Mileage - Consumption per Unit',
                    hintText: 'e.g. 17',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    )
                ),
                keyboardType: TextInputType.number,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(children: <Widget>[
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    // Setting the Controller for this TestField to 'averageController'
                    controller: priceController,
                    decoration: InputDecoration(
                        labelText: 'Fuel Price Per Unit',
                        hintText: 'e.g. 74',
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        )
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),

                Container(width: 10.0),

                Expanded(
                  child: DropdownButton<String> (

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
                ),
              ]),
            ),

            Row(
              children: <Widget>[

                Expanded(child: RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    onPressed: () {
                      setState(() {
                        result = _calculateTotalCost();
                      });
                    },

                    // Text to display on 'Button' widget
                    child: Text(
                      'Submit',
                      // 'textScaleFactor' is used to change the text size
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),

                Expanded(child: RaisedButton(
                    color: Theme.of(context).buttonColor,
                    textColor: Theme.of(context).primaryColorDark,
                    onPressed: () {
                      setState(() {
                        _reset();
                      });
                      _focusNode.unfocus();
                    },

                    // Text to display on 'Button' widget
                    child: Text(
                      'Reset',
                      // 'textScaleFactor' is used to change the text size
                      textScaleFactor: 1.5,
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(result),
            ),

          ],
        ),
      ),
    );
  }

  void _onDropDownChanged(String newValue) {
    setState(() {
      this._currency = newValue;
    });
  }

  String _calculateTotalCost() {

    double _distanceTravelled = double.parse(distanceController.text);
    double _averageConsumption = double.parse(avgController.text);
    double _fuelPricePeeUnit = double.parse(priceController.text);

    double _totalTripCost = _distanceTravelled / _averageConsumption * _fuelPricePeeUnit;

    String _result = 'The total cost of your Trip is: ${_totalTripCost.toStringAsFixed(2)} $_currency';

    return _result;
  }

  void _reset() {
    distanceController.clear();
    avgController.clear();
    priceController.clear();
    setState(() {
      result = '';
    });
  }



}