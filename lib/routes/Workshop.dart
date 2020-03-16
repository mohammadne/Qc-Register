import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:qc_register/provider/app_provider.dart';
import 'package:qc_register/utils/container_box.dart';
import 'package:qc_register/utils/route_template.dart';
import 'package:qc_register/utils/text_field.dart';
import 'package:qc_register/utils/waiting.dart';

class WorkShopRoute extends StatefulWidget {
  @override
  _WorkShopRouteState createState() => _WorkShopRouteState();
}

class _WorkShopRouteState extends State<WorkShopRoute> {
  Position _currentPosition;

  @override
  Widget build(BuildContext context) {
    return RouteTemplateUtil(
      text: "اطلاعات کارگاهی",
      children: <Widget>[
        ContainerBox(
          children: <Widget>[
            TextFieldUtil(
              hintText: "نام کارگاه",
              onChanged: (String input) =>
                  Provider.of<AppProvider>(context, listen: false)
                      .editWorkShop(workShopName: input),
            ),
          ],
        ),
        ContainerBox(
          children: <Widget>[
            TextFieldUtil(
              hintText: "آدرس کارگاه",
              onChanged: (String input) =>
                  Provider.of<AppProvider>(context, listen: false)
                      .editWorkShop(workhopAddress: input),
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
        print(e);
      }
    }

    Provider.of<AppProvider>(context, listen: false).editWorkShop(
      locationSystem: _currentPosition.toString()
    );


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
