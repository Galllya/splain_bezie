import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pi/common/paint_class.dart';
import 'package:pi/pages/home/widgets/alert_dialog.dart';

class SplainPage extends StatefulWidget {
  const SplainPage({Key? key}) : super(key: key);

  @override
  _SplainPageState createState() => _SplainPageState();
}

class _SplainPageState extends State<SplainPage> {
  late MyFancyPainter myFancyPainter;
  late List<int> x;
  late List<int> y;
  late bool showPoints;
  late bool showLines;
  late bool showSer, showOtnos, showP;

  @override
  void initState() {
    super.initState();
    showPoints = true;
    showLines = true;
    showSer = false;
    showOtnos = false;
    showP = false;
    x = [];
    y = [];
    myFancyPainter = MyFancyPainter(
      showPoints: showPoints,
      isSplain: true,
      showLines: showLines,
      offset: _offset,
      x: x,
      y: y,
    );
  }

  Offset _offset = Offset(0, 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Сплайн кривой Безье'),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialogCustom(
                        showLines: showLines,
                        onChangeLine: (value) {
                          setState(() {
                            showLines = value!;
                          });
                        },
                        showPoints: showPoints,
                        onChange: (value) {
                          setState(() {
                            showPoints = value!;
                          });
                        },
                        showSer: showSer,
                        onChangeshowSer: (value) {
                          setState(() {
                            showSer = value!;
                          });
                        },
                        showOtnos: showOtnos,
                        onChangeshowOtnos: (value) {
                          setState(() {
                            showOtnos = value!;
                          });
                        },
                        showP: showP,
                        onChangeshowP: (value) {
                          setState(() {
                            showP = value!;
                          });
                        },
                        onClose: () {
                          setState(() {
                            myFancyPainter = MyFancyPainter(
                              isSplain: true,
                              x: x,
                              y: y,
                              showPoints: showPoints,
                              showLines: showLines,
                              showSer: showSer,
                              showOtnos: showOtnos,
                              showP: showP,
                            );
                          });
                        },
                      );
                    });
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      body: SizedBox(
        height: 700,
        width: 400,
        child: Listener(
          onPointerDown: (PointerDownEvent event) {
            Offset offset = event.position;
            int appBarHeight = AppBar().preferredSize.height.toInt() +
                MediaQuery.of(context).padding.top.toInt();
            x.add(offset.dx.toInt());
            y.add(offset.dy.toInt() - appBarHeight);

            setState(() {
              _offset = offset;
              myFancyPainter = MyFancyPainter(
                isSplain: true,
                x: x,
                y: y,
                showPoints: showPoints,
                showLines: showLines,
                showSer: showSer,
                showOtnos: showOtnos,
                showP: showP,
              );
            });
          },
          child: CustomPaint(
            painter: myFancyPainter,
          ),
        ),
      ),
    );
  }
}
