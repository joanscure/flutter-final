import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';

class RequestAppointmentButton extends StatelessWidget {
  final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontWeight: FontWeight.bold), backgroundColor: vetPrimaryColor);
  final Function()? onpressed;
  final String text;

  RequestAppointmentButton({
    Key? key,
    required this.onpressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style,
      onPressed: onpressed,
      child: Text(text),
    );
  }
}

