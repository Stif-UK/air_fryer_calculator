import 'package:flutter/material.dart';

class AirFryerNotes extends StatefulWidget {
  const AirFryerNotes({Key? key}) : super(key: key);

  @override
  State<AirFryerNotes> createState() => _AirFryerNotesState();
}

class _AirFryerNotesState extends State<AirFryerNotes> {
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.note_alt_outlined),
          Text("Your Notebook is currently empty"),
        ],
      ),
    );
  }
}