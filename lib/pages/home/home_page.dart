import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi/common/paint_class.dart';
import 'package:pi/pages/home/widgets/alert_dialog.dart';
import 'package:pi/pages/home/widgets/drawer_custom.dart';
import 'package:pi/pages/home/widgets/slier_row.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey paintKey = GlobalKey();
  Offset _offset = Offset(0, 0);
  void realTimeChangeFunction() {
    if (realTimeChange) {
      myFancyPainter = MyFancyPainter(
        isSplain: false,
        x: x.map((i) => i.toInt()).toList(),
        y: y.map((i) => i.toInt()).toList(),
        showPoints: showPoint,
        showLines: showLines,
        offset: _offset,
      );
    }
  }

  late MyFancyPainter myFancyPainter;
  late bool showPoint;
  late bool showLines;
  late bool realTimeChange;

  late AlertDialog alertDialog;
  @override
  void initState() {
    super.initState();
    showPoint = false;
    showLines = false;
    realTimeChange = false;

    myFancyPainter = MyFancyPainter(
      isSplain: false,
      x: x.map((i) => i.toInt()).toList(),
      y: y.map((i) => i.toInt()).toList(),
      showPoints: showPoint,
      showLines: showLines,
      offset: _offset,
    );
  }

  List<double> x = [200, 120, 140, 180, 200];
  List<double> y = [210, 80, 50, 80, 20];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кривая Безье'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialogCustom(
                        realTimeChange: realTimeChange,
                        onChangeRealTime: (value) {
                          setState(() {
                            realTimeChange = value!;
                          });
                        },
                        showLines: showLines,
                        onChangeLine: (value) {
                          setState(() {
                            showLines = value!;
                          });
                        },
                        showPoints: showPoint,
                        onChange: (value) {
                          setState(() {
                            showPoint = value!;
                          });
                        },
                        onClose: () {
                          setState(() {
                            myFancyPainter = MyFancyPainter(
                              x: x.map((i) => i.toInt()).toList(),
                              y: y.map((i) => i.toInt()).toList(),
                              showPoints: showPoint,
                              showLines: showLines,
                              offset: _offset,
                              isSplain: false,
                            );
                          });
                        },
                      );
                    });
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      drawer: const DrawerCustom(),
      body: ListView(
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: Listener(
                onPointerDown: (PointerDownEvent event) {
                  Offset offset = event.position;
                  setState(() {
                    _offset = offset;
                  });
                },
                child: CustomPaint(painter: myFancyPainter)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                for (int i = 0; i < 4; i++)
                  Column(
                    children: [
                      SliderRow(
                        title: 'x${i + 1}',
                        onChange: (double value) {
                          setState(() {
                            x[i] = value;
                          });
                          realTimeChangeFunction();
                        },
                        value: x[i],
                      ),
                      SliderRow(
                        title: 'y${i + 1}',
                        onChange: (double value) {
                          setState(() {
                            y[i] = value;
                          });
                          realTimeChangeFunction();
                        },
                        value: y[i],
                      ),
                    ],
                  ),
                !realTimeChange
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                myFancyPainter = MyFancyPainter(
                                  x: x.map((i) => i.toInt()).toList(),
                                  y: y.map((i) => i.toInt()).toList(),
                                  showPoints: showPoint,
                                  showLines: showLines,
                                  offset: _offset,
                                  isSplain: false,
                                );
                              });
                            },
                            child: const Text('Постороить'),
                          ),
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
