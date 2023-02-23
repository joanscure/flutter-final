
import 'package:flutter/cupertino.dart';
import 'package:projectomovilfinal/settings/constant.dart';

class SelectViewModel extends ChangeNotifier {
  Section _selectView = Section.HOME;
  Section get selectView => _selectView;

  String _token = "";
  String get token => _token;

  void set(Section section, String token) {
    _selectView = section;
    _token = token;
    notifyListeners();
  }
}
