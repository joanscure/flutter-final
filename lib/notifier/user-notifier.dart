import 'package:flutter/cupertino.dart';
import 'package:projectomovilfinal/models/user.dart';

class UserNotifier extends ChangeNotifier {
  UserLocal _user = UserLocal(id: "" , email: "invitado@invitado.com",name: "Invitado");
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
	return UserLocal(id: "" , email: "invitado@invitado.com", name: "Invitado", isAdmin: false, isClient: true);
  }

}
