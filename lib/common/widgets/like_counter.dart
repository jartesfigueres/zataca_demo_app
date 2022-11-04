import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LikeCounterWidget extends StatefulWidget {
  const LikeCounterWidget({super.key});

  @override
  State<StatefulWidget> createState() => _LikeCounterState();
}

class _LikeCounterState extends State<LikeCounterWidget> {
  bool _userLikes = false;
  int _counter = 0;

  void _toggleLikeItem() {
    setState(() {
      _userLikes = !_userLikes;
      _counter = _counter + (_userLikes ? 1 : -1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          mouseCursor: MaterialStateMouseCursor.clickable,
          onPressed: _toggleLikeItem,
          icon: FaIcon(
            _userLikes ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            color: _userLikes ? Colors.red : Colors.black,
          ),
        ),
        Text('$_counter'),
        const VerticalDivider(thickness: 5),
        const Text('Me gusta'),
      ],
    );
  }
}
