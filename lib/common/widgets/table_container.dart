import 'package:flutter/material.dart';
import 'package:zataca_demo_app/configuration/theme_configuration.dart';

class TableContainerWidget extends StatefulWidget {
  const TableContainerWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
  });

  final String title;
  final String subtitle;
  final List<String> options;

  @override
  State<StatefulWidget> createState() => _TableContainerState();
}

class _TableContainerState extends State<TableContainerWidget> {
  TextEditingController textareaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textareaController.text = widget.options[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: ThemeConfiguration.primaryColor,
                fontWeight: Theme.of(context).textTheme.titleLarge!.fontWeight),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Text(widget.subtitle,
              style: Theme.of(context).textTheme.labelMedium),
        ),
      ],
    );
  }
}
