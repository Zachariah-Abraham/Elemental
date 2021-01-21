import 'package:flutter/material.dart';

class Element {
  Element(
      {@required this.atomicNumber, this.name, this.symbol, this.atomicWeight});
  final atomicNumber;
  String name;
  String symbol;
  String atomicWeight;

  void printElement() {
    print("$atomicNumber, $name, $symbol, $atomicWeight");
  }
}
