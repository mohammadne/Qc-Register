import 'package:flutter/foundation.dart';

class AppProvider with ChangeNotifier {
  List<PersonalModel> _personals = [
    PersonalModel(title: "مالک :"),
  ];
  WorkShopModel _workShop = WorkShopModel();

  List<PersonalModel> get personals => _personals;
  int get personalsLength => _personals.length;
  WorkShopModel get workShop => _workShop;

  void addToLastPersonals() {
    _personals.add(
      PersonalModel(
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

  int findIndexWithTitle(String title) => _personals
      .indexWhere((PersonalModel personal) => personal.title == title);

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

  editWorkShop({
    String workShopName,
    String workhopAddress,
    String locationSystem,
    String locationManual,
  }) {
    _workShop.workShopName = workShopName ?? _workShop.workShopName;
    _workShop.workhopAddress = workhopAddress ?? _workShop.workhopAddress;
    _workShop.locationSystem = locationSystem ?? _workShop.locationSystem;
    _workShop.locationManual = locationManual ?? _workShop.locationManual;
  }
}

class PersonalModel {
  final String title;
  String personalName;
  String carrier;
  List<String> mobsAndTels = ["09", "0"];
  PersonalModel({
    @required this.title,
  });
}

class WorkShopModel {
  String workShopName;
  String workhopAddress;
  String locationSystem;
  String locationManual;
}
