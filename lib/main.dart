import 'package:flutter/material.dart';
import 'Constants.dart';
import 'ElementCardHolder.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:excel/excel.dart';
import 'ElementModel.dart' as element;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.initializeTransformationMap();
  ByteData data = await rootBundle.load("assets/Elements.xlsx");
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);
  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table].rows) {
      Constants.elements[row[0].toString()] = element.Element(
        atomicNumber: row[0].toString(),
        symbol: row[1].toString(),
        name: row[2].toString(),
        atomicWeight: row[3].toString(),
      );
    }
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elemental',
      home: Elements(),
    );
  }
}

class Elements extends StatefulWidget {
  @override
  _ElementsState createState() => _ElementsState();
}

class _ElementsState extends State<Elements> with TickerProviderStateMixin {
  AnimationController animationControllerX;
  AnimationController animationControllerY;

  void initState() {
    super.initState();
    animationControllerX = AnimationController(
      vsync: this,
      lowerBound: -Constants.maxRotate,
      upperBound: Constants.maxRotate,
      duration: Duration(milliseconds: 5000),
    );
    animationControllerY = AnimationController(
      vsync: this,
      lowerBound: -Constants.maxRotate,
      upperBound: Constants.maxRotate,
      duration: Duration(milliseconds: 5000),
    );
    animationControllerX.value = 0;
    animationControllerY.value = 0;
  }

  _onPanUpdate(DragUpdateDetails drag) {
    double deltaX = drag.delta.dx;
    double deltaY = drag.delta.dy;
    animationControllerX.value += deltaX / 10;
    animationControllerY.value += deltaY / 10;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Transform(
            transform: Matrix4.identity()..translate(0, 200),
            child: ElementCardHolder(
              animationControllerX: animationControllerX,
              animationControllerY: animationControllerY,
            ),
          ),
        ),
      ),
    );
  }
}
