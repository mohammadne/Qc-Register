import 'package:flutter/material.dart';
import 'package:qc_register/utils/sizing.dart';

class TextFieldUtil extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function submit;
  final String errorText;
  final String hintText;
  TextFieldUtil({
    this.errorText,
    @required this.hintText,
    this.focusNode,
    this.submit,
    this.textEditingController,
    this.textInputAction,
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
          controller: textEditingController,
          focusNode: focusNode,
          cursorColor: Colors.black,
          decoration: InputDecoration.collapsed(
            hintText: hintText,
          ),
          textInputAction: textInputAction,
          onEditingComplete: () {},
          onSubmitted: submit,
        ),
      ),
    );
  }
}
