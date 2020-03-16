import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:qc_register/provider/workshop.dart';
import 'package:qc_register/utils/container_box.dart';
import 'package:qc_register/utils/route_template.dart';
import 'package:qc_register/utils/text_field.dart';
import 'package:qc_register/utils/waiting.dart';

class WorkShopDataRoute extends StatefulWidget {
  @override
  _WorkShopDataRouteState createState() => _WorkShopDataRouteState();
}

class _WorkShopDataRouteState extends State<WorkShopDataRoute> {

  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    return RouteTemplateUtil(
      text: "اطلاعات کارگاهی",
      children: <Widget>[
        ContainerBox(
          children: <Widget>[
            TextFieldUtil(
              errorText: "نام کارگاه خالی است",
              textInputAction: TextInputAction.next,
              hintText: "نام کارگاه",
              submit: (String input) {},
            ),
          ],
        ),
        ContainerBox(
          children: <Widget>[
            TextFieldUtil(
              errorText: "آدرس کارگاه خالی است",
              textInputAction: TextInputAction.next,
              hintText: "آدرس کارگاه",
              submit: (String input) {},
            ),
            RaisedButton.icon(
              icon: Icon(Icons.map),
              label: Text("لوکیشن"),
              onPressed: _getCurrentLocation,
            ),
          ],
        ),
      ],
    );
  }

  _getCurrentLocation() async {
    await Geolocator().checkGeolocationPermissionStatus();
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    waitingDialog(context);

    for (int i = 0; i < 5; i++) {
      try {
        _currentPosition = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best,
        );
      } catch (e) {
        //TODO
      }
    }

    Provider.of<WorkShopProvider>(context, listen: false).phoneLocation =
        _currentPosition.toString();

    // return internetConnection().then(
    //   (bool connection) async {
    //     if (connection) {
    //       await Provider.of<UserProvider>(context, listen: false)
    //           .put()
    //           .then((String message) {
    //         Navigator.pop(context);
    //         showErrorDialog(
    //           context: context,
    //           massage: message,
    //         );
    //       });
    //     } else {
    //       Navigator.pop(context);
    //       showErrorDialog(
    //         context: context,
    //         massage: 'خطا در برقراری ارتباط',
    //       );
    //     }
    //   },
    // );
  }
}
