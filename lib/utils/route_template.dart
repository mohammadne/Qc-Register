import 'package:flutter/material.dart';
import 'package:qc_register/utils/circle_button.dart';

class RouteTemplateUtil extends StatefulWidget {
  final String text;
  final List<Widget> children;
  RouteTemplateUtil({
    @required this.text,
    @required this.children,
  });

  @override
  _RouteTemplateUtilState createState() => _RouteTemplateUtilState();
}

class _RouteTemplateUtilState extends State<RouteTemplateUtil>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.linear,
    );
  }

  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleButtonUtil(
          onPressed: () => setState(() {
            expanded = !expanded;
            if (expanded)
              controller.forward();
            else
              controller.reverse();
          }),
          text: widget.text,
        ),
        expanded
            ? FadeTransition(
                opacity: animation,
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: widget.children,
                ),
              )
            : Container(),
      ],
    );
  }
}
