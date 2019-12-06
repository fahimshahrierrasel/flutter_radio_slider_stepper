import 'package:flutter/material.dart';
import 'package:flutter_radio_slider/flutter_radio_slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<String> labels = ["Step 0", "Step 1", "Step 2", "Step 3", "Step 4", "Step 5", "Step 6", "Step 7"];
  int stepValue = 2;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('RadioSliderStepper Example'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Text(labels[stepValue]),
            ),
            RadioSlider(
              value: stepValue,
              labels: labels,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  RaisedButton(
                    child: Text("Previous Step"),
                    onPressed: (){
                      print(stepValue);
                      if(stepValue > 0) {
                        setState(() {
                          stepValue = stepValue - 1;
                        });

                      }
                      print(stepValue);
                    },
                  ),
                  RaisedButton(
                    child: Text("Next Step"),
                    onPressed: () {
                      print(stepValue);
                      if(stepValue < labels.length - 1) {
                        setState(() {
                          stepValue = stepValue + 1;
                        });
                      }
                      print(stepValue);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
