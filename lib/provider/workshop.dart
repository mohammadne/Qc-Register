import 'package:flutter/foundation.dart';

class WorkShopProvider with ChangeNotifier {
  String _workShopName;
  String get workShopName => _workShopName;
  set workShopName(String newWorkShopName) {
    this._workShopName = newWorkShopName;
  }

  String _workShopAddress;
  String get workShopAddress => _workShopAddress;
  set workShopAddress(String newWorkShopAddress) {
    this._workShopAddress = newWorkShopAddress;
  }

  String _phoneLocation;
  String get phoneLocation => _phoneLocation;
  set phoneLocation(String newPhoneLocation) {
    this._phoneLocation = newPhoneLocation;
  }

  String _mapLocation;
  String get mapLocation => _mapLocation;
  set mapLocation(String newmapLocation) {
    this._mapLocation = newmapLocation;
  }

  //API CALL
}
