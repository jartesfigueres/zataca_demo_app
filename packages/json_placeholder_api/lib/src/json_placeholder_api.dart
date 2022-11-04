import 'dart:convert';
import 'package:dio/dio.dart';

import 'package:placeholder_data/placeholder_data.dart';

class JSONPlaceholderAPI extends PlaceholderDataAPI {
  JSONPlaceholderAPI({Dio? client}) : _client = client ?? Dio();

  static const String _domain = 'jsonplaceholder.typicode.com';

  static const int _userLimit = 20;
  static const int _postLimit = 20;
  static const int _commentLimit = 20;
  static const int _taskLimit = 20;

  final Dio _client;

  Future<List<dynamic>> _fetchData(
    String entityName, {
    int startIndex = 0,
    int? limit,
  }) async {
    try {
      final response = await _client.get<String>(
        Uri.https(
          _domain,
          '/$entityName',
          <String, String>{'_start': '$startIndex', '_limit': '$limit'},
        ).toString(),
      );
      if (response.data == null) {
        return [];
      } else {
        final body = response.data ?? '';
        return json.decode(body) as List;
      }
    } catch (e) {
      throw Exception('error fetching $entityName');
    }
  }

  @override
  Future<List<User>> fetchUsers([int startIndex = 0]) async {
    final items =
        await _fetchData('users', startIndex: startIndex, limit: _userLimit);
    return items.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return User(
        id: map['id'] as int,
        name: map['name'] as String,
        username: map['username'] as String,
        email: map['email'] as String,
      );
    }).toList();
  }

  @override
  Future<List<Post>> fetchUserPosts(int userId, [int startIndex = 0]) async {
    final items = await _fetchData(
      'user/$userId/posts',
      startIndex: startIndex,
      limit: _postLimit,
    );
    return items.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Post(
        id: map['id'] as int,
        title: map['title'] as String,
        body: map['body'] as String,
        userId: map['userId'] as int,
      );
    }).toList();
  }

  @override
  Future<List<Task>> fetchUserTasks(int userId, [int startIndex = 0]) async {
    final items = await _fetchData(
      'user/$userId/todos',
      startIndex: startIndex,
      limit: _taskLimit,
    );
    return items.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Task(
        id: map['id'] as int,
        title: map['title'] as String,
        completed: map['completed'] as bool,
        userId: map['userId'] as int,
      );
    }).toList();
  }

  @override
  Future<List<Post>> fetchPosts([int startIndex = 0]) async {
    final items =
        await _fetchData('posts', startIndex: startIndex, limit: _postLimit);
    return items.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Post(
        id: map['id'] as int,
        title: map['title'] as String,
        body: map['body'] as String,
        userId: map['userId'] as int,
      );
    }).toList();
  }

  @override
  Future<List<Comment>> fetchComments(int postId, [int startIndex = 0]) async {
    final items = await _fetchData(
      'posts/$postId/comments',
      startIndex: startIndex,
      limit: _commentLimit,
    );
    return items.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Comment(
        id: map['id'] as int,
        name: map['name'] as String,
        email: map['email'] as String,
        body: map['body'] as String,
        postId: map['postId'] as int,
      );
    }).toList();
  }

  @override
  Future<List<Task>> fetchTasks([int startIndex = 0]) async {
    final items =
        await _fetchData('todos', startIndex: startIndex, limit: _taskLimit);
    return items.map((dynamic json) {
      final map = json as Map<String, dynamic>;
      return Task(
        id: map['id'] as int,
        title: map['title'] as String,
        completed: map['completed'] as bool,
        userId: map['userId'] as int,
      );
    }).toList();
  }

  @override
  Future<List<Reading>> fetchReadings([int startIndex = 0]) {
    // Generate fake data
    return Future.delayed(
      const Duration(seconds: 1),
      () => <Reading>[
        Reading(
          id: 1,
          type: 'Consumos',
          date: DateTime(2020, 10, 23, 13, 21),
          active: true,
        ),
        Reading(
          id: 2,
          type: 'Consumos',
          date: DateTime(2020, 10, 19, 10, 20),
          active: true,
        ),
        Reading(
          id: 1,
          type: 'Potencias',
          date: DateTime(2020, 2, 5, 20, 35),
          active: false,
        ),
        Reading(
          id: 1,
          type: 'Datos',
          date: DateTime(2020, 10, 23, 23, 40),
          active: true,
        ),
        Reading(
          id: 1,
          type: 'Consumos',
          date: DateTime(2020, 10, 23, 8, 23),
          active: false,
        ),
        Reading(
          id: 1,
          type: 'Potencias',
          date: DateTime(2020, 10, 23, 8, 23),
          active: true,
        ),
        Reading(
          id: 1,
          type: 'Potencias',
          date: DateTime(2020, 10, 23, 8, 23),
          active: true,
        ),
      ],
    );
  }
}
