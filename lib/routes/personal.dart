import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_register/provider/app_provider.dart';
import 'package:qc_register/utils/container_box.dart';
import 'package:qc_register/utils/gradient_border.dart';
import 'package:qc_register/utils/sizing.dart';
import 'package:qc_register/utils/text_field.dart';

class PersonalRoute extends StatefulWidget {
  final PersonalModel ownerModel;
  PersonalRoute(this.ownerModel);

  @override
  _PersonalRouteState createState() => _PersonalRouteState();
}

class _PersonalRouteState extends State<PersonalRoute> {
  bool showJobs = false;
  @override
  Widget build(BuildContext context) {
    Map items = {};
    for (var i = 0; i < widget.ownerModel.mobsAndTels.length; i++) {
      items.putIfAbsent(i, () => widget.ownerModel.mobsAndTels[i]);
    }
    final int personalIndex = Provider.of<AppProvider>(context)
        .findIndexWithTitle(widget.ownerModel.title);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ContainerBox(
          children: <Widget>[
            TextFieldUtil(
              hintText: widget.ownerModel.title,
              onChanged: (String input) =>
                  Provider.of<AppProvider>(context, listen: false)
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
                        onTap: () => setState(() => showJobs = !showJobs),
                        child: Icon(Icons.arrow_downward),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        if (showJobs)
          Container(
            margin: CustomPaddings.smallPadding,
            width: 150,
            decoration: BoxDecoration(
              borderRadius: CustomBorders.normalBorderRadius,
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade400,
                  Colors.white,
                ],
                stops: [0.0, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: UnicornOutlineButton(
              strokeWidth: 3,
              radius: 10,
              gradient: CustomGradient.gradient,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 10),
                  _buildJobItems("مدیریت", 0, personalIndex),
                  SizedBox(height: 5),
                  _buildJobItems("مکانیک", 1, personalIndex),
                  SizedBox(height: 5),
                  _buildJobItems("باطری ساز", 2, personalIndex),
                  SizedBox(height: 5),
                  _buildJobItems("صافکار", 3, personalIndex),
                  SizedBox(height: 5),
                  _buildJobItems("آهنگر", 4, personalIndex),
                  SizedBox(height: 5),
                  _buildJobItems("نقاش", 5, personalIndex),
                  SizedBox(height: 10),
                ],
              ),
            ),
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
                      onTap: () =>
                          Provider.of<AppProvider>(context, listen: false)
                              .addMobsAndTelsToPersonalIndex(personalIndex),
                      child: Icon(Icons.add),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: InkWell(
                      onTap: () =>
                          Provider.of<AppProvider>(context, listen: false)
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

  Widget _buildJobItems(String name, int index, int personalIndex) {
    int selectedJob = Provider.of<AppProvider>(context, listen: false)
        .getJobIndex(personalIndex)
        .index;
    return InkWell(
      onTap: () =>
          Provider.of<AppProvider>(context, listen: false).editPersonalIndex(
        index: personalIndex,
        carrier: Jobs.values[index],
      ),
      child: Row(
        children: <Widget>[
          Container(
            child: Text(
              name,
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              border: Border.all(color: Colors.black),
            ),
            child: selectedJob == index
                ? FittedBox(
                    child: Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                  )
                : Container(),
          )
        ],
      ),
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
    IconData iconData;
    try {
      iconData = Provider.of<AppProvider>(context)
              .personals[personalIndex]
              .mobsAndTels[mobsOrTelsIndex]
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
                  Provider.of<AppProvider>(context, listen: false)
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
