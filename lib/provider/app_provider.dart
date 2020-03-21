import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

enum Jobs { Manager, Mechanic, BatteryMaker, Smoother, Backsmith, Painter }
const List jobsName = [
  "Manager",
  "Mechanic",
  "BatteryMaker",
  "Smoother",
  "Backsmith",
  "Painter"
];

enum SendDataState { NotPushed, Await, Seccess, Failed }

class AppProvider with ChangeNotifier {
  List<PersonalModel> _personals = [
    PersonalModel(title: "مالک :", carrier: Jobs.Manager),
  ];
  WorkShopModel _workShop = WorkShopModel();
  SendDataState sendDataState = SendDataState.NotPushed;

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

  Future calculateDistance() async => await Geolocator().distanceBetween(
        _workShop.locationSystem.latitude,
        _workShop.locationSystem.longitude,
        _workShop.locationManual.latitude,
        _workShop.locationManual.longitude,
      );

  editPersonalIndex({
    @required int index,
    String personalName,
    Jobs carrier,
    int mobOrTelIndex,
    String mobOrTel,
  }) {
    _personals[index].personalName =
        personalName ?? _personals[index].personalName;

    if (mobOrTelIndex != null) {
      _personals[index].mobsAndTels[mobOrTelIndex] =
          mobOrTel ?? _personals[index].mobsAndTels[mobOrTelIndex];
    }
    if (carrier != null) {
      _personals[index].carrier = carrier ?? _personals[index].carrier;
      notifyListeners();
    }
  }

  editWorkShop({
    String workShopName,
    String workhopAddress,
    LatLng locationSystem,
    LatLng locationManual,
  }) {
    _workShop.workShopName = workShopName ?? _workShop.workShopName;
    _workShop.workhopAddress = workhopAddress ?? _workShop.workhopAddress;
    _workShop.locationSystem = locationSystem ?? _workShop.locationSystem;
    _workShop.locationManual = locationManual ?? _workShop.locationManual;
  }

  Future<String> sendData() async {
    sendDataState = SendDataState.Await;
    notifyListeners();
    try {
      http.Response response = await http.post(
        "https://workshop.dinavision.org/api/v1/Workshop/setWorkshop",
        headers: {
          // "Accept": "application/json",
          "content-type": "application/json; charset=utf-8",
        },
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
                        "value": _workShop.workhopAddress,
                        "contactType_Id": "Address",
                      },
                      {
                        "value": _workShop.locationSystem,
                        "contactType_Id": "LocationSystem",
                      },
                      {
                        "value": _workShop.locationManual,
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
      print(response.statusCode);
      if (response.statusCode > 200 && response.statusCode < 300) {
        sendDataState = SendDataState.Seccess;
        notifyListeners();
        return null;
      } else {
        sendDataState = SendDataState.Failed;
        notifyListeners();
        return json.decode(response.body)["message"] as String;
      }
    } catch (e) {
      sendDataState = SendDataState.Failed;
      notifyListeners();
      return Future.value(e.toString()) as String;
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
  LatLng locationSystem;
  LatLng locationManual;
}
