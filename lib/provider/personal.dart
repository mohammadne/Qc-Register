import 'package:flutter/foundation.dart';

class PersonalProvider with ChangeNotifier {
  List<OwnerModel> _owners = [];
  int get ownerNumbers => _owners.length;

  addOwnerToLast({@required OwnerModel owner}) => _owners.add(owner);
  deleteOwnerAtLast() => _owners.removeLast();
  editOwnerIndex({@required int index, @required OwnerModel owner}) {
    _owners[index].ownerName = owner.ownerName ?? _owners[index].ownerName;
    _owners[index].carrier = owner.carrier ?? _owners[index].carrier;
    _owners[index].phoneAndMobiles =
        owner.phoneAndMobiles ?? _owners[index].phoneAndMobiles;
  }
}

//MODEL
class OwnerModel {
  String ownerName;
  String carrier;
  List<String> phoneAndMobiles;
}
