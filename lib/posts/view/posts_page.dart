import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_data/placeholder_data.dart';
import 'package:zataca_demo_app/posts/posts.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: BlocProvider(
        create: (_) =>
            PostBloc(dataRepository: context.read<PlaceholderDataAPI>())
              ..add(PostFetched()),
        child: const PostsList(),
      ),
    );
  }
}
