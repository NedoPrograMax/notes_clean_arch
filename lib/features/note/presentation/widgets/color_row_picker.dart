import 'package:flutter/material.dart';

class ColorRowPicker extends StatelessWidget {
  ColorRowPicker({
    required this.pickColor,
    super.key,
  });
  final _colors = [
    Colors.red,
    Colors.amber,
    Colors.green,
    Colors.blue,
    Colors.deepPurple,
    Colors.white,
    Colors.lime
  ];
  final PickColor pickColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        itemCount: _colors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: GestureDetector(
            onTap: () => pickColor(_colors[index]),
            child: CircleAvatar(
              backgroundColor: _colors[index],
            ),
          ),
        ),
      ),
    );
  }
}

typedef PickColor = void Function(Color color);
