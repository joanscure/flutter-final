import 'package:flutter/material.dart';

String text = "Selecciona la hora";

class SelectTimelWidget extends StatefulWidget {
  @override
  _SelectTimelWidgetState createState() => _SelectTimelWidgetState();
}

class _SelectTimelWidgetState extends State<SelectTimelWidget> {
  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void _selectTime() async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      setState(() {
        _time = newTime;
      });
      text = '${_time.format(context)}';
    }
  }

  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: _selectTime,
      child: Text(text),
    );
  }
}