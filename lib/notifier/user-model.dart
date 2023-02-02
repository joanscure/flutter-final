import 'package:flutter/cupertino.dart';
import 'package:flutterfire/src/models/user.dart';

class UserModel extends ChangeNotifier {

  UserLocal _user = UserLocal( email: "invitado@invitado.com", name: "Invitado");
  UserLocal get user => _user;

  void set(UserLocal newUser) {
    _user = newUser;
    notifyListeners();
  }

  void clear() {
    _user = getUserGuess();
    notifyListeners();
  }

  UserLocal getUserGuess(){
	return UserLocal(email: "invitado@invitado.com", name: "Invitado");
  }

}
