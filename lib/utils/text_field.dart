import 'package:flutter/material.dart';
import 'package:qc_register/utils/sizing.dart';

class TextFieldUtil extends StatelessWidget {
  final void Function(String text) onChanged;
  final String hintText;
  TextFieldUtil({
    @required this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CustomSize.itemSizes,
      alignment: Alignment.center,
      width: MediaQuery.of(context).size.width - 40,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          cursorColor: Colors.black,
          decoration: InputDecoration.collapsed(
            hintText: hintText,
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
