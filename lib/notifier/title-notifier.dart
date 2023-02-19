import 'package:flutter/cupertino.dart';

class TitleNotifier extends ChangeNotifier {
  String _title = 'Patitas Felices';
  String get title => _title;

  void set(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  void clear() {
    _title = 'Patitas Felices';
    notifyListeners();
  }
}
