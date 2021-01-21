import 'package:flutter/material.dart';
import 'Constants.dart';
import 'dart:math' as math;
import 'package:flutter/rendering.dart';

class ElementCard extends StatelessWidget {
  ElementCard({
    @required this.atomicNumber,
  });
  final atomicNumber;

  static final random = math.Random();
  final thisCardColor = Constants.elementCardColor
      .withOpacity((random.nextDouble() * 0.23) + 0.2);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: thisCardColor,
          borderRadius: BorderRadius.circular(7.0),
          border: Border.all(width: 1, color: Colors.white.withOpacity(0.3))),
      child: SizedBox(
        width: Constants.elementCardWidth.toDouble(),
        height: Constants.elementCardHeight.toDouble(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 0,
              child: Padding(
                padding: EdgeInsets.only(
                    top: Constants.elementCardHeight / 15,
                    right: Constants.elementCardHeight / 8),
                child: Text(
                  atomicNumber.toString(),
                  textAlign: TextAlign.right,
                  style: Constants.atomicNumberTextStyle,
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: EdgeInsets.only(),
                child: Center(
                  child: Text(
                    Constants.elements[atomicNumber.toString()].symbol,
                    textAlign: TextAlign.center,
                    style: Constants.symbolTextStyle,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(),
                child: Text(
                  Constants.elements[atomicNumber.toString()].name,
                  textAlign: TextAlign.center,
                  style: Constants.nameTextStyle,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(bottom: 7),
                child: Text(
                  Constants.elements[atomicNumber.toString()].atomicWeight,
                  textAlign: TextAlign.center,
                  style: Constants.atomicWeightTextStyle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
