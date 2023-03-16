import 'package:flutter/material.dart';
import 'package:riverpod_app/models/user_model.dart';
import 'package:riverpod_app/services/service.dart';

class Controller extends ChangeNotifier {
  PageController pageController = PageController(initialPage: 0);
  bool? isLoading;
  List<Datum> users = [];
  List<Datum> savedUsers = [];

  void getData() {
    MyService().fetch().then((value) => {
          if (value != null)
            {
              users = value.data.cast<Datum>(),
              isLoading = true,
              notifyListeners(),
            }
          else
            {
              isLoading = false,
              notifyListeners(),
            }
        });
  }

  void addSaved(Datum model) {
    savedUsers.add(model);
    users.remove(model);
    notifyListeners();
  }

  void deleteSaved(Datum model) {
    savedUsers.remove(model);
    users.add(model);
    notifyListeners();
  }

  notSavedButton() {
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }

  savedButton() {
    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
  }
}
