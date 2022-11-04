import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_data/placeholder_data.dart';

import 'package:zataca_demo_app/configuration/theme_configuration.dart';
import 'package:zataca_demo_app/home_page.dart';

class App extends StatelessWidget {
  const App({super.key, required PlaceholderDataAPI dataRepository})
      : _dataRepository = dataRepository;

  final PlaceholderDataAPI _dataRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _dataRepository,
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Prueba nivel flutter Zataca',
      // Theming configuration
      theme: ThemeConfiguration.applyCustomization(ThemeData.light()),
      darkTheme: ThemeConfiguration.applyCustomization(ThemeData.dark()),
      // In case we want to align with the user's sytem preferences
      //themeMode: ThemeMode.system,
      themeMode: ThemeMode.light,
      home: const HomePage(title: 'Prueba nivel flutter Zataca'),
    );
  }
}
