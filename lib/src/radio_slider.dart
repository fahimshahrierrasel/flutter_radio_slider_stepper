import 'package:flutter/material.dart';
import 'package:flutter_radio_slider/flutter_radio_slider.dart';
import 'radio_slider_shape.dart';

class RadioSlider extends StatefulWidget {
  final int value;
  final List<String> labels;
  final activeColor;

  const RadioSlider({Key key, @required this.value, @required this.labels, this.activeColor}) : super(key: key);

  @override
  _RadioSliderState createState() => _RadioSliderState();
}

class _RadioSliderState extends State<RadioSlider> {
  @override
  Widget build(BuildContext context) {
    final themeData = SliderTheme.of(context).copyWith(
      trackHeight: 8,
      activeTrackColor: Colors.grey[300],
      inactiveTrackColor: Colors.grey[300],
      inactiveTickMarkColor: Colors.grey[500],
      tickMarkShape: RadioSliderTickMarkShape(widget.labels, activeColor: widget.activeColor),
      trackShape: RadioSliderTrackShape(activeColor: widget.activeColor),
      thumbShape: RadioSliderThumbShape(widget.labels, activeColor: widget.activeColor),
    );

    return Container(
      padding: EdgeInsets.only(top: 8, bottom: 16, left: 8, right: 8),
      child: SliderTheme(
        data: themeData,
        child: Slider(
          min: 0,
          max: (widget.labels.length - 1).toDouble(),
          value: widget.value.toDouble(),
          divisions: widget.labels.length - 1,
        ),
      ),
    );
  }
}
