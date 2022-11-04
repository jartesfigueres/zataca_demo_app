import 'package:flutter/material.dart';
import 'package:zataca_demo_app/configuration/theme_configuration.dart';

class CustomActionButton extends StatelessWidget {
  const CustomActionButton(
      {super.key, required this.handler, required this.icon, this.tooltip});

  final Function()? handler;
  final Icon icon;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ThemeConfiguration.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: IconButton(
        tooltip: tooltip,
        onPressed: handler,
        icon: icon,
      ),
    );
  }
}
