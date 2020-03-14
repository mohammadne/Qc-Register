import 'package:flutter/material.dart';
import 'package:qc_register/utils/container_box.dart';
import 'package:qc_register/utils/route_template.dart';
import 'package:qc_register/utils/text_field.dart';

class WorkShopDataRoute extends StatelessWidget {
  final TextEditingController _workShopNameTextEditingController =
      TextEditingController();
  final TextEditingController _workShopAddressTextEditingController =
      TextEditingController();

  final FocusNode _workShopNameFocusNode = FocusNode();
  final FocusNode _workShopAddressFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return RouteTemplateUtil(
      text: "اطلاعات کارگاهی",
      children: <Widget>[
        ContainerBox(
          children: <Widget>[
            TextFieldUtil(
              textEditingController: _workShopNameTextEditingController,
              focusNode: _workShopNameFocusNode,
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
              textEditingController: _workShopAddressTextEditingController,
              focusNode: _workShopAddressFocusNode,
              errorText: "آدرس کارگاه خالی است",
              textInputAction: TextInputAction.next,
              hintText: "آدرس کارگاه",
              submit: (String input) {},
            ),
            RaisedButton.icon(
              icon: Icon(Icons.map),
              label: Text("لوکیشن"),
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}
