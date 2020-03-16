import 'package:flutter/foundation.dart';

class PersonalProvider with ChangeNotifier {
  List<OwnerModel> _personals = [
    OwnerModel(title: "مالک :"),
  ];

  int get personalsLength => _personals.length;

  List<OwnerModel> get personals => _personals;

  // PersonalProvider findByTitle({@required String title}) {
  //   return _pesonals
  //       .firstWhere((PersonalProvider persProv) => title == persProv.title);
  // }

  void addToLastPersonals() {
    _personals.add(
      OwnerModel(
        title: "مالک $personalsLength :",
      ),
    );
    notifyListeners();
  }

  void deleteLastPersonals() {
    if (personalsLength > 1) {
      _personals.removeLast();
      notifyListeners();
    }
  }

  addMobsAndTelsToPersonalIndex(int index) {
    _personals[index].mobsAndTels.add("09");
    notifyListeners();
  }

  deleteMobsAndTelsAtPersonalIndex(int index) {
    if (_personals[index].mobsAndTels.length > 2) {
      _personals[index].mobsAndTels.removeLast();
      notifyListeners();
    }
  }

  int findIndexWithTitle(String title) =>
      _personals.indexWhere((OwnerModel personal) => personal.title == title);

  editPersonalIndex({
    @required int index,
    String personalName,
    String carrier,
    int mobOrTelIndex,
    String mobOrTel,
  }) {
    _personals[index].personalName =
        personalName ?? _personals[index].personalName;
    _personals[index].carrier = carrier ?? _personals[index].carrier;
    if (mobOrTelIndex != null) {
      _personals[index].mobsAndTels[mobOrTelIndex] =
          mobOrTel ?? _personals[index].mobsAndTels[mobOrTelIndex];
    }
  }
}

class OwnerModel {
  final String title;
  String personalName;
  String carrier;
  List<String> mobsAndTels = ["09", "0"];
  OwnerModel({
    @required this.title,
  });
}
