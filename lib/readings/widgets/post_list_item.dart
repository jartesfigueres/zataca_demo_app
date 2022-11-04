import 'package:flutter/material.dart';
import 'package:placeholder_data/placeholder_data.dart';

class PostListItem extends StatelessWidget {
  const PostListItem({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: RichText(
          text: TextSpan(
              style: Theme.of(context).textTheme.bodyLarge,
              children: <TextSpan>[
            TextSpan(text: '${post.id} ${post.title}')
          ])),
      subtitle: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: RichText(
              text: TextSpan(
                  style: Theme.of(context).textTheme.bodyMedium,
                  children: <TextSpan>[TextSpan(text: post.body)]))),
      dense: false,
    );
  }
}
