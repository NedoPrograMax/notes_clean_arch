import "package:flutter/material.dart";
import 'package:intl/intl.dart';

class NoteListItem extends StatelessWidget {
  const NoteListItem({
    Key? key,
    required this.title,
    required this.text,
    required this.date,
    required this.borderColor,
    this.backgroundColor,
  }) : super(key: key);

  final String title;
  final String text;
  final DateTime date;
  final Color? backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        elevation: 6,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: borderColor, width: 2)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      )),
                  Text(DateFormat("yyyy-MM-dd").format(date),
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                text,
                style: const TextStyle(fontSize: 15),
              )
            ],
          ),
        ),
      ),
    );
  }
}
