import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qc_register/provider/app_provider.dart';
import 'package:qc_register/routes/personal.dart';
import 'package:qc_register/utils/route_template.dart';


class PersonalsRoute extends StatefulWidget {
  @override
  _PersonalsRouteState createState() => _PersonalsRouteState();
}

class _PersonalsRouteState extends State<PersonalsRoute> {
  @override
  Widget build(BuildContext context) {
    final personalProvider = Provider.of<AppProvider>(context);
    return RouteTemplateUtil(
      text: "اطلاعات فردی مالک",
      children: [
        ...personalProvider.personals.map((PersonalModel ownerModel) {
          return PersonalRoute(ownerModel);
        }).toList(),
        // ...ownerType,
        Container(
          child: Row(
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  child: Icon(Icons.add),
                  onTap: () => personalProvider.addToLastPersonals(),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  child: Icon(Icons.delete),
                  onTap: () => personalProvider.deleteLastPersonals(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
