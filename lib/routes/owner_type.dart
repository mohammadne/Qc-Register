import 'package:flutter/material.dart';
import 'package:qc_register/utils/container_box.dart';
import 'package:qc_register/utils/sizing.dart';
import 'package:qc_register/utils/text_field.dart';

class OwnerType extends StatefulWidget {
  final String title;
  OwnerType({
    @required this.title,
  });
  @override
  _OwnerTypeState createState() => _OwnerTypeState();
}

class _OwnerTypeState extends State<OwnerType> {
  final TextEditingController _ownerNameTextEditingController =
      TextEditingController();
  final TextEditingController _mobileTextEditingController =
      TextEditingController();
  final TextEditingController _phoneTextEditingController =
      TextEditingController();

  final FocusNode _ownerNameFocusNode = FocusNode();
  final FocusNode _mobileFocusNode = FocusNode();
  final FocusNode _phoneFocusNode = FocusNode();

  List<Widget> extraFields = [];
  List<TextEditingController> extraTextEditingControllers = [];
  List<FocusNode> extraFocusNode = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ContainerBox(
          children: <Widget>[
            TextFieldUtil(
              textEditingController: _ownerNameTextEditingController,
              focusNode: _ownerNameFocusNode,
              errorText: "نام ${widget.title} خالی است",
              textInputAction: TextInputAction.next,
              hintText: widget.title,
              submit: (String input) {},
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
                        child: Icon(Icons.train),
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
            BuildContactPhone(
              textEditingController: _mobileTextEditingController,
              focusNode: _mobileFocusNode,
              iconData: Icons.phone_android,
              hintText: "09",
            ),
            BuildContactPhone(
              textEditingController: _phoneTextEditingController,
              focusNode: _phoneFocusNode,
              iconData: Icons.call,
              hintText: "0",
            ),
            ...extraFields,
            Container(
              width: MediaQuery.of(context).size.width - 40,
              child: Row(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          extraTextEditingControllers
                              .add(TextEditingController());
                          extraFocusNode.add(FocusNode());
                          extraFields.add(
                            BuildContactPhone(
                              textEditingController:
                                  extraTextEditingControllers.last,
                              focusNode: extraFocusNode.last,
                              iconData: Icons.phone_android,
                              hintText: "0",
                            ),
                          );
                        });
                      },
                      child: Icon(Icons.add),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    child: InkWell(
                      onTap: extraFields.isEmpty
                          ? null
                          : () {
                              setState(() {
                                extraTextEditingControllers.removeLast();
                                extraFocusNode.removeLast();
                                extraFields.removeLast();
                              });
                            },
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
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final IconData iconData;
  final String hintText;
  BuildContactPhone({
    this.focusNode,
    this.textEditingController,
    this.iconData,
    this.hintText,
  });
  @override
  Widget build(BuildContext context) {
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
              onTap: () {},
              child: Icon(iconData),
            ),
          ),
          Expanded(
            child: TextField(
              controller: textEditingController,
              focusNode: focusNode,
              cursorColor: Colors.black,
              decoration: InputDecoration.collapsed(
                hintText: hintText,
              ),
              textInputAction: TextInputAction.next,
              onEditingComplete: () {},
              onSubmitted: (_) {},
            ),
          ),
        ],
      ),
    );
  }
}
