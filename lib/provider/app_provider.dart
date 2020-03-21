import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

enum Jobs { Manager, Mechanic, BatteryMaker, Smoother, Backsmith, Painter }
const List jobsName = [
  "Manager",
  "Mechanic",
  "BatteryMaker",
  "Smoother",
  "Backsmith",
  "Painter"
];

class AppProvider with ChangeNotifier {
  List<PersonalModel> _personals = [
    PersonalModel(title: "مالک :", carrier: Jobs.Manager),
  ];
  WorkShopModel _workShop = WorkShopModel();

  List<PersonalModel> get personals => _personals;
  int get personalsLength => _personals.length;
  WorkShopModel get workShop => _workShop;

  void addToLastPersonals() {
    _personals.add(
      PersonalModel(title: "مالک $personalsLength :", carrier: Jobs.Manager),
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

  Jobs getJobIndex(int index) {
    return _personals[index].carrier;
  }

  int findIndexWithTitle(String title) => _personals
      .indexWhere((PersonalModel personal) => personal.title == title);

  editPersonalIndex({
    @required int index,
    String personalName,
    Jobs carrier,
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

  Future sendData() async {
    print("object");
    try {
      http.Response response = await http.post(
        "https://workshop.dinavision.org/api/v1/Workshop/setWorkshop",
        headers: {"content-type": "application/json"},
        body: json.encode(
          {
            "name": _workShop.workShopName,
            "people": _personals
                .map(
                  (PersonalModel personal) => {
                    "fname": personal.personalName,
                    "job_Id": jobsName[personal.carrier.index],
                    "contacts": [
                      {
                        "value": "1232123",
                        "contactType_Id": "Address",
                      },
                      {
                        "value": "1232123",
                        "contactType_Id": "LocationSystem",
                      },
                      {
                        "value": "1232123",
                        "contactType_Id": "LocationManual",
                      },
                      ...personal.mobsAndTels.map((String val) {
                        return val.startsWith("09")
                            ? {
                                "value": val,
                                "contactType_Id": "Mobile",
                              }
                            : {
                                "value": val,
                                "contactType_Id": "Tel",
                              };
                      }).toList(),
                    ],
                  },
                )
                .toList(),
          },
        ),
      );
      print(response.body);
    } catch (e) {
      print(e);
      return Future.value(e.toString());
    }
  }
}

class PersonalModel {
  final String title;
  String personalName;
  Jobs carrier;
  List<String> mobsAndTels = ["09", "0"];
  PersonalModel({@required this.title, @required this.carrier});
}

class WorkShopModel {
  String workShopName;
  String workhopAddress;
  String locationSystem;
  String locationManual;
}
