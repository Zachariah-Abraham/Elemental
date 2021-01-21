import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'ElementModel.dart' as element;
import 'ElementCard.dart';

class Constants {
  static final random = math.Random();
  static const repetitions = 30;
  static const turnResolution =
      20; // Higher the value, smaller the angle updates when rotating, i.e. smoother, slower rotating
  static const maxRotate = math.pi * repetitions * turnResolution;
  static const radius = 550.0;
  static const teal = Color(0xff008081);
  static final elementCardColor =
      Color.alphaBlend(teal, Colors.green).withOpacity(1);
  static const elementCardHeight = 80;
  static const elementCardWidth = 60;
  static const elementCardHalfSize = elementCardHeight / 2;
  static const numberOfElements = 114;
  static const numberOfElementsPerCircle = 36;
  static const numberOfElementsPerHalfCircle = numberOfElementsPerCircle / 2;
  static Map<String, element.Element> elements = {};
  static final atomicNumberTextStyle = TextStyle(
    fontSize: 8,
    color: Colors.white.withOpacity(0.5),
  );
  static final symbolTextStyle = TextStyle(
    fontSize: 30,
    color: Colors.white.withOpacity(0.8),
    fontWeight: FontWeight.w600,
  );
  static final nameTextStyle = TextStyle(
    fontSize: 8,
    color: Colors.white.withOpacity(0.5),
  );
  static final atomicWeightTextStyle = TextStyle(
    fontSize: 8,
    color: Colors.white.withOpacity(0.5),
  );
  static Map<int, Map<String, double>> transformationsMap =
      {}; // will be populated later by the build method of each ElementCard
  static final elementCardList = List<Widget>.generate(
    Constants.numberOfElements,
    (index) => ElementCard(
      atomicNumber:
          int.parse(Constants.elements[(index + 1).toString()].atomicNumber),
    ),
  );

  static initializeTransformationMap() {
    for (int atomicNumber = 1;
        atomicNumber <= numberOfElements;
        atomicNumber++) {
      double initialRotateX = (atomicNumber - 1) *
          (math.pi / Constants.numberOfElementsPerHalfCircle);
      Constants.transformationsMap[atomicNumber] = {};
      Constants.transformationsMap[atomicNumber]['translateOneX'] = math.sin(
              (atomicNumber - 1) *
                  (math.pi / Constants.numberOfElementsPerHalfCircle)) *
          Constants.radius;

      Constants.transformationsMap[atomicNumber]['translateOneY'] =
          atomicNumber * 3.0;
      Constants.transformationsMap[atomicNumber]['translateOneZ'] = -math.cos(
              (atomicNumber - 1) *
                  (math.pi / Constants.numberOfElementsPerHalfCircle)) *
          Constants.radius;
      Constants.transformationsMap[atomicNumber]['translateTwoX'] =
          Constants.elementCardHalfSize;
      Constants.transformationsMap[atomicNumber]['rotateThreeY'] =
          -initialRotateX * 1;
      Constants.transformationsMap[atomicNumber]['translateFourX'] =
          -Constants.elementCardHalfSize;
    }
  }
}
