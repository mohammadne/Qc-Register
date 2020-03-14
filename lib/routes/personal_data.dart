import 'package:flutter/material.dart';
import 'package:qc_register/routes/owner_type.dart';
import 'package:qc_register/utils/container_box.dart';
import 'package:qc_register/utils/route_template.dart';
import 'package:qc_register/utils/sizing.dart';
import 'package:qc_register/utils/text_field.dart';

class PersonalDataRoute extends StatefulWidget {
  @override
  _PersonalDataRouteState createState() => _PersonalDataRouteState();
}

class _PersonalDataRouteState extends State<PersonalDataRoute> {
  List<OwnerType> ownerType = [
    OwnerType(title: "مالک"),
  ];

  @override
  Widget build(BuildContext context) {
    return RouteTemplateUtil(
      text: "اطلاعات فردی مالک",
      children: [
        ...ownerType,
        Container(
          // width: MediaQuery.of(context).size.width - 40,
          child: Row(
            children: <Widget>[
              Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  child: Icon(Icons.add),
                  onTap: () => setState(
                    () => ownerType.add(
                      OwnerType(title: "مالک ${ownerType.length+1}"),
                    ),
                  ),
                ),
              ),
              Container(
                height: 40,
                width: 40,
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: InkWell(
                  child: Icon(Icons.delete),
                  onTap: () => setState(() => ownerType.removeLast()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
