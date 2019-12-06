import 'dart:math';
import 'package:flutter/material.dart';

class RadioSliderThumbShape extends SliderComponentShape {
  Color activeColor;
  final List<String> labels;
  final activeText =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12);
  final inactiveText = TextStyle(color: Colors.grey, fontSize: 12);

  RadioSliderThumbShape(this.labels, {this.activeColor});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(10);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      double value}) {
    final trackWidth = parentBox.size.width + 30;
    final innerCircleDiameter = sliderTheme.trackHeight;
    final textSpace = sliderTheme.trackHeight + 8;
    final labelIndex = center.dx ~/ (trackWidth.toInt() / labels.length);

    var innerValueStyle = Paint()
      ..color = this.activeColor ?? Color.fromRGBO(48, 217, 104, 1)
      ..style = PaintingStyle.fill;

    TextSpan label = TextSpan(
        style: activeText, text: labels[labelIndex].replaceFirst(" ", "\n"));

    TextPainter textPainter = new TextPainter(
        text: label,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout();

    Offset text = Offset(center.dx - textPainter.width / 2, center.dy + textSpace);

    // paint the inner circle
    context.canvas.drawCircle(center, innerCircleDiameter, innerValueStyle);
    textPainter.paint(context.canvas, text);
  }
}

class RadioSliderTickMarkShape extends SliderTickMarkShape {
  final Color activeColor;
  final List<String> labels;

  RadioSliderTickMarkShape(this.labels,
      {this.activeColor});

  final activeText =
      TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 12);
  final inactiveText = TextStyle(color: Colors.grey, fontSize: 12);

  @override
  Size getPreferredSize({SliderThemeData sliderTheme, bool isEnabled}) {
    return Size.fromRadius(0);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {RenderBox parentBox,
      SliderThemeData sliderTheme,
      Animation<double> enableAnimation,
      Offset thumbCenter,
      bool isEnabled,
      TextDirection textDirection}) {
    final innerCircleDiameter = sliderTheme.trackHeight;
    final outerCircleDiameter = sliderTheme.trackHeight + 5;
    final isSelected = center.dx <= thumbCenter.dx;

    final trackWidth = parentBox.size.width + 30;
    final textSpace = sliderTheme.trackHeight + 8;
    final labelIndex = center.dx ~/ (trackWidth.toInt() / labels.length);
    final textStyle = isSelected ? activeText : inactiveText;

    var innerCircleStyle = Paint()
      ..color = isSelected ? this.activeColor ?? Color.fromRGBO(48, 217, 104, 1) : Colors.white
      ..style = PaintingStyle.fill;

    var outerCircleFillStyle = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    var outerCircleStrokeStyle = Paint()
      ..color = Colors.black.withOpacity(0.2)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    TextSpan label = TextSpan(
      style: textStyle,
      text: labels[labelIndex].replaceFirst(" ", "\n"),
    );

    TextPainter textPainter = new TextPainter(
        text: label,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout();
    Offset text = Offset(center.dx - textPainter.width / 2, center.dy + textSpace);

    textPainter.paint(context.canvas, text);

    if (isSelected) {
      context.canvas.drawCircle(center, outerCircleDiameter, outerCircleFillStyle);
      context.canvas.drawCircle(center, outerCircleDiameter, outerCircleStrokeStyle);
      context.canvas.drawCircle(center, innerCircleDiameter, innerCircleStyle);
    } else {
      context.canvas.drawCircle(center, innerCircleDiameter, outerCircleFillStyle);
      context.canvas.drawCircle(center, innerCircleDiameter, outerCircleStrokeStyle);
    }
  }
}

class RadioSliderTrackShape extends SliderTrackShape {
  final Color activeColor;
  RadioSliderTrackShape({this.activeColor});

  @override
  Rect getPreferredRect({
    RenderBox parentBox,
    Offset offset = Offset.zero,
    SliderThemeData sliderTheme,
    bool isEnabled,
    bool isDiscrete,
  }) {
    final double thumbWidth =
        sliderTheme.thumbShape.getPreferredSize(true, isDiscrete).width;
    final double trackHeight = sliderTheme.trackHeight + 3;
    assert(thumbWidth >= 0);
    assert(trackHeight >= 0);
    assert(parentBox.size.width >= thumbWidth);
    assert(parentBox.size.height >= trackHeight);

    final double trackLeft = offset.dx + thumbWidth / 2;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 4;
    final double trackWidth = parentBox.size.width - thumbWidth;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(
    PaintingContext context,
    Offset offset, {
    RenderBox parentBox,
    SliderThemeData sliderTheme,
    Animation<double> enableAnimation,
    TextDirection textDirection,
    Offset thumbCenter,
    bool isDiscrete,
    bool isEnabled,
  }) {
    if (sliderTheme.trackHeight == 0) {
      return;
    }

    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Paint fillPaint = Paint()
      ..color = this.activeColor ?? Color.fromRGBO(48, 217, 104, 1)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    final Paint selectPaint = Paint()
      ..color = sliderTheme.activeTrackColor
      ..strokeWidth = 1.0
      ..style = PaintingStyle.fill;

    final pathSegment = Path()
      ..moveTo(trackRect.left, trackRect.top)
      ..lineTo(trackRect.right, trackRect.top)
      ..arcTo(
          Rect.fromPoints(
            Offset(trackRect.right + 7, trackRect.top),
            Offset(trackRect.right - 7, trackRect.bottom),
          ),
          -pi / 2,
          pi,
          false)
      ..lineTo(trackRect.left, trackRect.bottom)
      ..arcTo(
          Rect.fromPoints(
            Offset(trackRect.left + 7, trackRect.top),
            Offset(trackRect.left - 7, trackRect.bottom),
          ),
          -pi * 3 / 2,
          pi,
          false);

    final selectedPathSegment = Path()
      ..moveTo(trackRect.left, trackRect.top)
      ..lineTo(thumbCenter.dx, trackRect.top)
      ..arcTo(
          Rect.fromPoints(
            Offset(trackRect.right + 7, trackRect.top),
            Offset(trackRect.right - 7, trackRect.bottom),
          ),
          -pi / 2,
          pi,
          false)
      ..lineTo(thumbCenter.dx, trackRect.bottom)
      ..arcTo(
          Rect.fromPoints(
            Offset(thumbCenter.dx + 7, trackRect.top),
            Offset(thumbCenter.dx - 7, trackRect.bottom),
          ),
          -pi * 3 / 2,
          pi,
          false);

    context.canvas.drawPath(pathSegment, fillPaint);
    context.canvas.drawPath(selectedPathSegment, selectPaint);
  }
}
