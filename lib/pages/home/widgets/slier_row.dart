import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliderRow extends StatelessWidget {
  final String title;
  final double value;
  final Function onChange;
  const SliderRow({
    Key? key,
    required this.onChange,
    required this.value,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('$title: ${value.round()}'),
        Expanded(
          child: SizedBox(
            width: double.maxFinite,
            child: Slider(
              min: 0,
              max: 400,
              value: value,
              onChanged: (value) {
                onChange(value);
                value = value;
              },
            ),
          ),
        )
      ],
    );
  }
}
