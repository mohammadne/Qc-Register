import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_register/provider/personal.dart';
import 'package:qc_register/utils/container_box.dart';
import 'package:qc_register/utils/sizing.dart';
import 'package:qc_register/utils/text_field.dart';

class PersonalRoute extends StatelessWidget {
  final OwnerModel ownerModel;
  PersonalRoute(this.ownerModel);

  @override
  Widget build(BuildContext context) {
    Map items = {};
    for (var i = 0; i < ownerModel.mobsAndTels.length; i++) {
      items.putIfAbsent(i, () => ownerModel.mobsAndTels[i]);
    }
    final int personalIndex = Provider.of<PersonalProvider>(context)
        .findIndexWithTitle(ownerModel.title);
    return Column(
      children: <Widget>[
        ContainerBox(
          children: <Widget>[
            TextFieldUtil(
              hintText: ownerModel.title,
              submit: (String input) =>
                  Provider.of<PersonalProvider>(context, listen: false)
                      .editPersonalIndex(
                index: personalIndex,
                personalName: input,
              ),
            ),
          ],
        ),
        ContainerBox(
          children: <Widget>[
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                width: MediaQuery.of(context).size.width - 40,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("شغل :"),
                    Container(
                      height: 40,
                      width: 40,
                      child: InkWell(
                        onTap: () {},
                        child: Icon(Icons.arrow_downward),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        ContainerBox(
          children: <Widget>[
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(context).size.width - 40,
                child: Text("شماره تماس ها"),
              ),
            ),
            ...items
                .map((index, mobOrTel) {
                  return MapEntry(
                    index,
                    BuildContactPhone(
                      personalIndex: personalIndex,
                      mobsOrTelsIndex: index,
                    ),
                  );
                })
                .values
                .toList(),
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: InkWell(
                      onTap: () => Provider.of<PersonalProvider>(context)
                          .addMobsAndTelsToPersonalIndex(personalIndex),
                      child: Icon(Icons.add),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: InkWell(
                      onTap: () => Provider.of<PersonalProvider>(context)
                          .deleteMobsAndTelsAtPersonalIndex(personalIndex),
                      child: Icon(Icons.delete),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BuildContactPhone extends StatelessWidget {
  final int mobsOrTelsIndex;
  final int personalIndex;
  BuildContactPhone({
    @required this.mobsOrTelsIndex,
    @required this.personalIndex,
  });

  @override
  Widget build(BuildContext context) {
    final PersonalProvider personalProvider =
        Provider.of<PersonalProvider>(context);
    IconData iconData;
    try {
      iconData = personalProvider
              .personals[personalIndex].mobsAndTels[mobsOrTelsIndex]
              .startsWith("09")
          ? Icons.phone_android
          : Icons.call;
    } catch (e) {
      print(e);
    }
    return Container(
      height: CustomSize.itemSizes,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Container(
            height: 40,
            width: 40,
            child: InkWell(
              child: Icon(iconData),
            ),
          ),
          Expanded(
            child: TextField(
              cursorColor: Colors.black,
              decoration: InputDecoration.collapsed(hintText: ""),
              onChanged: (String text) =>
                  Provider.of<PersonalProvider>(context, listen: false)
                      .editPersonalIndex(
                index: personalIndex,
                mobOrTelIndex: mobsOrTelsIndex,
                mobOrTel: text,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
