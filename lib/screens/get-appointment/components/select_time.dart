import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';

String text = "Selecciona la hora";
typedef OnTimeSelectedCallback = void Function(TimeOfDay timeOfDay);

class SelectTimelWidget extends StatefulWidget {
  SelectTimelWidget({super.key, this.onTimeSelected});

  final OnTimeSelectedCallback? onTimeSelected;

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
      widget.onTimeSelected!(_time);
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
