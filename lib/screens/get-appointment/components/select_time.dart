import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';

String text = "Selecciona la hora";

class SelectTimelWidget extends StatefulWidget {
  @override
  _SelectTimelWidgetState createState() => _SelectTimelWidgetState();
}

class _SelectTimelWidgetState extends State<SelectTimelWidget> {

  final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontWeight: FontWeight.bold), foregroundColor: vetPrimaryColor);
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
      style: style,
      onPressed: _selectTime,
      child: Text(text),
    );
  }
}
