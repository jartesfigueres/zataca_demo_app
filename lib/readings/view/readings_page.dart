import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:placeholder_data/placeholder_data.dart';
import 'package:zataca_demo_app/readings/bloc/reading_bloc.dart';
import 'package:zataca_demo_app/readings/view/reading_table.dart';

class ReadingsPage extends StatelessWidget {
  const ReadingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          ReadingBloc(dataRepository: context.read<PlaceholderDataAPI>())
            ..add(ReadingFetched()),
      child: const ReadingTable(
        title: 'Segunda parte',
        subtitle:
            'Aquí vamos a mostrar una tabla. Debes de intentar dejarlo lo mas parecido posible, al igual que hacerla dinámica.',
      ),
    );
  }
}
