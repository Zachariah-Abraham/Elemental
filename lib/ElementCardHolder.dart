import 'package:flutter/material.dart';
import 'Constants.dart';
import 'dart:collection';

class ElementCardHolder extends StatelessWidget {
  ElementCardHolder({
    @required this.animationControllerX,
    @required this.animationControllerY,
  });
  final animationControllerX;
  final animationControllerY;

  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.identity()
        ..translate(MediaQuery.of(context).size.width / 2, -100),
      child: AnimatedBuilder(
        animation: animationControllerX,
        builder: (context, child) {
          double rotateX =
              animationControllerX.value / Constants.turnResolution;
          double rotateY =
              animationControllerY.value / Constants.turnResolution;
          return Flow(
            clipBehavior: Clip.none,
            delegate: CustomFlowDelegate(rotateY: -rotateX, rotateX: rotateY),
            children: Constants.elementCardList,
          );
        },
      ),
    );
  }
}

class CustomFlowDelegate extends FlowDelegate {
  CustomFlowDelegate({this.rotateX, this.rotateY});
  final rotateY, rotateX;
  @override
  void paintChildren(FlowPaintingContext context) {
    Map<int, double> zValue = {};
    for (int i = 0; i < context.childCount; i++) {
      var map = Constants.transformationsMap[i + 1];
      Matrix4 transformedMatrix = Matrix4.identity()
        ..setEntry(3, 2, 0.0007)
        ..rotateY(this.rotateY)
        ..rotateX(this.rotateX)
        ..translate(
            map['translateOneX'], map['translateOneY'], map['translateOneZ'])
        ..translate(map['translateTwoX'])
        ..rotateY(map['rotateThreeY'])
        ..translate(map['translateFourX']);
      zValue[i + 1] = transformedMatrix.getRow(2)[2];
    }
    var sortedKeys = zValue.keys.toList(growable: false)
      ..sort((k1, k2) => zValue[k1].compareTo(zValue[k2]));
    LinkedHashMap sortedMap = new LinkedHashMap.fromIterable(sortedKeys,
        key: (k) => k, value: (k) => zValue[k]);
    for (int key in sortedMap.keys) {
      var map = Constants.transformationsMap[key];
      context.paintChild(
        key - 1,
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.0007)
          ..rotateY(this.rotateY)
          ..rotateX(this.rotateX)
          ..translate(
              map['translateOneX'], map['translateOneY'], map['translateOneZ'])
          ..translate(map['translateTwoX'])
          ..rotateY(map['rotateThreeY'])
          ..translate(map['translateFourX']),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }
}
