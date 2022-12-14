import 'package:flutter/material.dart';

import 'package:zataca_demo_app/common/widgets/bottom_sheet.dart';
import 'package:zataca_demo_app/common/widgets/action_button.dart';
import 'package:zataca_demo_app/common/widgets/expanded_image.dart';
import 'package:zataca_demo_app/common/widgets/like_counter.dart';
import 'package:zataca_demo_app/common/widgets/multitab_container.dart';
import 'package:zataca_demo_app/configuration/theme_configuration.dart';
import 'package:zataca_demo_app/posts/view/posts_page.dart';
import 'package:zataca_demo_app/readings/view/readings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          CustomActionButton(
            tooltip: 'Ver opciones',
            icon: const Icon(
              Icons.settings,
              color: ThemeConfiguration.secondaryColor,
            ),
            handler: () {
              showModalBottomSheet(
                context: context,
                constraints: const BoxConstraints(maxHeight: 220),
                builder: (BuildContext context) {
                  return const CustomBottomSheet();
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const ExpandedImage(
                imagePath:
                    'assets/images/background/pexels-jaime-reimer-2662116.jpg'),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                children: [
                  const LikeCounterWidget(),
                  const Divider(indent: 10, endIndent: 10),
                  const MultiTabContainerWidget(
                    title: 'Primera parte',
                    subtitle:
                        'Vamos a mostrar dos tabs, que a su vez mostrar??n informaci??n diferente en su interior.',
                    options: [
                      'Lake Oeschinen lies at the foot of the Bl??emlisalp in the Bernese.\nAlps. Situated 1,578 meters above sea level, it is one of the.\nLarger Alpine Lakes. A gondola ride from Kandersteg, followed by a.',
                      'Vestibulum eu quam nec neque pellentesque efficitur id eget nisl. Proin porta est convallis lacus blandit pretium sed non enim. Maecenas lacinia non orci at aliquam.',
                    ],
                  ),
                  const ReadingsPage(),
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                            ),
                            backgroundColor:
                                const MaterialStatePropertyAll(Colors.blue),
                          ),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => const PostsPage(
                                  title: 'Prueba nivel flutter Zataca'),
                            ),
                          ),
                          child: const Text('Ir a la siguiente vista'),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
