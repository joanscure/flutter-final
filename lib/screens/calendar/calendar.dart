import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectomovilfinal/models/event.dart';
import 'package:projectomovilfinal/models/user.dart';
import 'package:projectomovilfinal/notifier/user-notifier.dart';
import 'package:projectomovilfinal/screens/calendar/calendar.service.dart';
import 'package:projectomovilfinal/settings/constant.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:provider/provider.dart';

class CalendarScreen extends StatefulWidget {
  @override
  State<CalendarScreen> createState() => _CalendarScreen();
}

class _CalendarScreen extends State<CalendarScreen> {
  late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  late LinkedHashMap<DateTime, List<Event>> kEvents =
      LinkedHashMap<DateTime, List<Event>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  List<Map<String, dynamic>> users = [];

  late UserLocal user = context.read<UserNotifier>().user;

  @override
  void initState() {
    super.initState();
    user = context.read<UserNotifier>().user;

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    getUsers();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  getUsers() async {
    print("asdasd");
    var refClients = await FirebaseFirestore.instance
        .collection("users")
        .where('isClient', isEqualTo: true)
        .get();

    List<Map<String, dynamic>> usersTemp = [];
    refClients.docs.forEach((element) {
      usersTemp.add({...element.data(), 'id': element.id});
    });
    setState(() {
      print(usersTemp.length);
      users = usersTemp;
    });
  }

  getAppointments() {
    if (user.isClient)
      return FirebaseFirestore.instance
          .collection("appointments")
          .where("userId", isEqualTo: objectID)
          .snapshots();

    return FirebaseFirestore.instance
        .collection("appointments")
        .where("assignedId", isEqualTo: objectID)
        .snapshots();
  }

  List<Event> _getEventsForDay(DateTime day) {
    if (kEvents.isEmpty) return [];
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return Center(
        child: Text("Cargando"),
      );
    }

    return StreamBuilder(
        stream: getAppointments(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var size = snapshot.data!.docs.length;
          Map<DateTime, List<Event>> _kEventSource = {};

          final f = DateFormat('hh:mm');

          for (var i = 0; i < size; i++) {
            Map<String, dynamic> data =
                snapshot.data!.docs[i].data() as Map<String, dynamic>;
            var time = f.format(
                DateTime.fromMillisecondsSinceEpoch(data['date'] * 1000));
            var otherUser = '';
            if (user.isClient) {
              otherUser = data['assignedName'] != ''
                  ? data['assignedName']
                  : 'No asignado aun';
            } else {
              print(users);

              print(data['userId']);
              users.forEach((element) {
                if (element['id'] == data['userId']) {
                  otherUser = element['fullname'];
                  return;
                }
              });
            }
            _kEventSource.addAll({
              DateTime.fromMillisecondsSinceEpoch(data['date']): [
                Event(data['reason'], otherUser, time,
                    data['notes'] != '' ? data['notes'] : '--', data['petName'])
              ]
            });
          }

          kEvents = LinkedHashMap<DateTime, List<Event>>(
            equals: isSameDay,
            hashCode: getHashCode,
          )..addAll(_kEventSource);

          return Column(
            children: [
              TableCalendar<Event>(
                firstDay: kFirstDay,
                lastDay: kLastDay,
                locale: 'es_ES',
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                rangeStartDay: _rangeStart,
                rangeEndDay: _rangeEnd,
                calendarFormat: _calendarFormat,
                rangeSelectionMode: _rangeSelectionMode,
                eventLoader: _getEventsForDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                calendarStyle: const CalendarStyle(
                  outsideDaysVisible: false,
                ),
                onDaySelected: _onDaySelected,
                onRangeSelected: _onRangeSelected,
                onFormatChanged: (format) {
                  if (_calendarFormat != format) {
                    setState(() {
                      _calendarFormat = format;
                    });
                  }
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
              ),
              const SizedBox(height: 8.0),
              Expanded(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        var text = user.isClient
                            ? "Mascota: ${value[index].pet}\nHora: ${value[index].time} \nVeterinario: ${value[index].vet}\nNotas: ${value[index].notes}"
                            : "Mascota: ${value[index].pet}\nHora: ${value[index].time} \nCliente: ${value[index].vet}\nNotas: ${value[index].notes}";

                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            onTap: () => print('${value[index]}'),
                            title: Text('${value[index].title}'),
                            subtitle: Text(text),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        });
  }
}
