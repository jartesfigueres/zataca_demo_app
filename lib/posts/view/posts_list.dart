import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zataca_demo_app/configuration/theme_configuration.dart';

import 'package:zataca_demo_app/posts/posts.dart';
import 'package:zataca_demo_app/common/widgets/bottom_loader.dart';

class PostsList extends StatefulWidget {
  const PostsList({super.key, int? userId}) : _userId = userId ?? -1;

  final int _userId;

  @override
  State<PostsList> createState() => _PostsListState();
}

class _PostsListState extends State<PostsList> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        switch (state.status) {
          case PostStatus.failure:
            return const Center(child: Text('failed to fetch posts'));
          case PostStatus.success:
            if (state.posts.isEmpty) {
              return const Center(child: Text('no posts'));
            }
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      'Listado de post',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: ThemeConfiguration.primaryColor,
                          fontWeight: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .fontWeight),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                      child: Text(
                          'Vamos a mostrar los primeros 20 resultados que nos devuelve la petición:\n https://jsonplaceholder.typicode.com/posts?_start=0&_limit=20',
                          style: Theme.of(context).textTheme.labelMedium)),
                  const Divider(indent: 10, endIndent: 10),
                  Expanded(
                      child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return index >= state.posts.length
                          ? const BottomLoader()
                          : PostListItem(post: state.posts[index]);
                    },
                    itemCount: state.hasReachedMax
                        ? state.posts.length
                        : state.posts.length + 1,
                    controller: _scrollController,
                  ))
                ]);
          case PostStatus.initial:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PostBloc>().add(widget._userId == -1
          ? PostFetched()
          : PostByUserFetched(widget._userId));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
