import 'package:flutter/material.dart';
import 'package:zataca_demo_app/configuration/theme_configuration.dart';

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}

class MultiTabContainerWidget extends StatefulWidget {
  const MultiTabContainerWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
  });

  final String title;
  final String subtitle;
  final List<String> options;

  @override
  State<StatefulWidget> createState() => _MultiTabContainerState();
}

class _MultiTabContainerState extends State<MultiTabContainerWidget> {
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
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: Row(
            children: [
              for (var index = 0; index < widget.options.length; index++)
                Expanded(
                    flex: 1,
                    child: Padding(
                        padding: index < widget.options.length - 1
                            ? const EdgeInsets.fromLTRB(0, 0, 5, 0)
                            : EdgeInsets.zero,
                        child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: textareaController.text ==
                                      widget.options[index]
                                  ? null
                                  : const MaterialStatePropertyAll(
                                      Color.fromRGBO(109, 112, 128, 1),
                                    ),
                              backgroundColor: textareaController.text ==
                                      widget.options[index]
                                  ? Theme.of(context)
                                      .elevatedButtonTheme
                                      .style!
                                      .backgroundColor
                                  : const MaterialStatePropertyAll(
                                      Color.fromRGBO(223, 223, 223, 1),
                                    ),
                            ),
                            onPressed: () {
                              setState(() {
                                textareaController.text = widget.options[index];
                              });
                            },
                            child: Text('Tab ${index + 1}'))))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
          child: TextField(
            keyboardType: TextInputType.multiline,
            maxLines: 6,
            controller: textareaController,
            readOnly: true,
            focusNode: AlwaysDisabledFocusNode(),
            decoration: const InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 1, color: Color.fromRGBO(184, 184, 184, 1)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
