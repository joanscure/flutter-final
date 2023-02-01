import 'package:flutter/material.dart';
import 'package:projectomovilfinal/settings/constant.dart';

String text = 'Selecciona la fecha';
typedef OnDateSelectedCallback = void Function(DateTime date);

class SelectDatelWidget extends StatefulWidget {
  SelectDatelWidget({super.key, this.restorationId, this.onDateSelected});

  final String? restorationId;
  final OnDateSelectedCallback? onDateSelected;

  @override
  State<SelectDatelWidget> createState() => _SelectDatelWidgetState();
}

class _SelectDatelWidgetState extends State<SelectDatelWidget>
    with RestorationMixin {
      final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontWeight: FontWeight.bold), foregroundColor: vetPrimaryColor);
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
  RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
      BuildContext context,
      Object? arguments,
      ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2022),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
      });
      text = '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
      widget.onDateSelected!(_selectedDate.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: style,
      onPressed: () {
        _restorableDatePickerRouteFuture.present();
      },
      child: Text(text),
    );
  }
}
