import 'package:flutter/material.dart';

class AlertDialogCustom extends StatefulWidget {
  final Function onChange;
  final bool showPoints;
  final Function onClose;
  final Function onChangeLine;
  final bool showLines;
  final bool? realTimeChange;
  final Function? onChangeRealTime;
  final bool? showSer, showOtnos, showP;
  final Function? onChangeshowSer, onChangeshowOtnos, onChangeshowP;
  const AlertDialogCustom({
    Key? key,
    required this.onChange,
    required this.showPoints,
    required this.onClose,
    required this.onChangeLine,
    required this.showLines,
    this.onChangeRealTime,
    this.realTimeChange,
    this.showOtnos,
    this.showP,
    this.showSer,
    this.onChangeshowOtnos,
    this.onChangeshowP,
    this.onChangeshowSer,
  }) : super(key: key);

  @override
  _AlertDialogCustomState createState() => _AlertDialogCustomState();
}

class _AlertDialogCustomState extends State<AlertDialogCustom> {
  late bool showPoints;
  late bool showLines;
  late bool realTimeChange;
  late int numberOfInfo;
  late bool showSer, showOtnos, showP;

  @override
  void initState() {
    super.initState();
    showPoints = widget.showPoints;
    showLines = widget.showLines;
    numberOfInfo = 2;
    if (widget.realTimeChange != null) {
      realTimeChange = widget.realTimeChange!;
      numberOfInfo++;
    }
    if (widget.showSer != null) {
      showSer = widget.showSer!;
      numberOfInfo++;
    }
    if (widget.showOtnos != null) {
      showOtnos = widget.showOtnos!;
      numberOfInfo++;
    }
    if (widget.showP != null) {
      showP = widget.showP!;
      numberOfInfo++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Настройки'),
      content: SizedBox(
        height: numberOfInfo * 48,
        child: Column(
          children: [
            Row(
              children: [
                const Text('Показывать точки'),
                Checkbox(
                    value: showPoints,
                    onChanged: (value) {
                      setState(() {
                        showPoints = value!;
                      });
                      widget.onChange(value);
                    })
              ],
            ),
            Row(
              children: [
                const Text('Показывать линии'),
                Checkbox(
                    value: showLines,
                    onChanged: (value) {
                      setState(() {
                        showLines = value!;
                      });
                      widget.onChangeLine(value);
                    })
              ],
            ),
            if (widget.realTimeChange != null)
              Row(
                children: [
                  const Text('Менять синхронно'),
                  Checkbox(
                      value: realTimeChange,
                      onChanged: (value) {
                        setState(() {
                          realTimeChange = value!;
                        });
                        widget.onChangeRealTime!(value);
                      })
                ],
              ),
            if (widget.showSer != null)
              Row(
                children: [
                  const Text('Показывать средние точки'),
                  Checkbox(
                      value: showSer,
                      onChanged: (value) {
                        setState(() {
                          showSer = value!;
                        });
                        widget.onChangeshowSer!(value);
                      })
                ],
              ),
            if (widget.showOtnos != null)
              Row(
                children: [
                  const Text('Показывать относ. точки'),
                  Checkbox(
                      value: showOtnos,
                      onChanged: (value) {
                        setState(() {
                          showOtnos = value!;
                        });
                        widget.onChangeshowOtnos!(value);
                      })
                ],
              ),
            if (widget.showP != null)
              Row(
                children: [
                  const Text('Показывать опорные точки'),
                  Checkbox(
                      value: showP,
                      onChanged: (value) {
                        setState(() {
                          showP = value!;
                        });
                        widget.onChangeshowP!(value);
                      })
                ],
              ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Применить'),
          onPressed: () {
            Navigator.of(context).pop();
            widget.onClose();
          },
        ),
      ],
    );
  }
}
