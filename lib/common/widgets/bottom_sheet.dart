import 'package:flutter/material.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  static final List<Map<String, dynamic>> _actions = [
    {
      'image': 'assets/images/icons/folder.png',
      'text': 'Opción 1',
    },
    {
      'image': 'assets/images/icons/send_file.png',
      'text': 'Opción 2',
    },
    {
      'image': 'assets/images/icons/cancel.png',
      'text': 'Opción 3',
    },
    {
      'image': 'assets/images/icons/report.png',
      'text': 'Opción 4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Divider(indent: 100, endIndent: 100, thickness: 5),
      SizedBox(
        height: 200,
        child: ListView.builder(
          itemCount: _actions.length,
          itemBuilder: (context, index) {
            return ListTile(
              mouseCursor: MaterialStateMouseCursor.clickable,
              leading: ImageIcon(AssetImage(_actions[index]['image'])),
              minLeadingWidth: 0,
              dense: true,
              title: Text(_actions[index]['text'],
                  style: Theme.of(context).textTheme.labelMedium),
            );
          },
        ),
      )
    ]);
  }
}
