import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zataca_demo_app/configuration/theme_configuration.dart';

import 'package:zataca_demo_app/readings/bloc/reading_bloc.dart';

class ReadingTable extends StatefulWidget {
  const ReadingTable({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  State<ReadingTable> createState() => _ReadingTableState();
}

class _ReadingTableState extends State<ReadingTable> {
  final DateFormat formatter = DateFormat('dd/MM/yyyy H:m');
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadingBloc, ReadingState>(
      builder: (context, state) {
        switch (state.status) {
          case ReadingStatus.failure:
            return const Center(child: Text('failed to fetch readings'));
          case ReadingStatus.success:
            if (state.readings.isEmpty) {
              return const Center(child: Text('no readings'));
            }
            final double width = MediaQuery.of(context).size.width;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: ThemeConfiguration.primaryColor,
                          fontWeight: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .fontWeight),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Text(widget.subtitle,
                        style: Theme.of(context).textTheme.labelMedium),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: DataTable(
                        columnSpacing: 0,
                        horizontalMargin: 0,
                        columns: [
                          DataColumn(
                            label: Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.only(left: 15),
                              width: width * .3,
                              child: const Text('Tipo'),
                            ),
                          ),
                          DataColumn(
                            label: Container(
                              alignment: Alignment.centerLeft,
                              width: width * .45,
                              child: const Text('Fecha'),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: width * .25,
                              child: const Text('Estado'),
                            ),
                          ),
                        ],
                        rows: List.generate(
                          state.readings.length,
                          (index) {
                            return DataRow(cells: [
                              DataCell(Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.only(left: 15),
                                width: width * .3,
                                child: Text(state.readings[index].type),
                              )),
                              DataCell(Container(
                                alignment: Alignment.centerLeft,
                                width: width * .45,
                                child: Text(formatter
                                    .format(state.readings[index].date)),
                              )),
                              DataCell(Tooltip(
                                  message: state.readings[index].active
                                      ? 'Activo'
                                      : 'Inactivo',
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(right: 15),
                                    width: width * .25,
                                    height: 10.0,
                                    decoration: BoxDecoration(
                                      color: state.readings[index].active
                                          ? Colors.green
                                          : Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                  ))),
                            ]);
                          },
                        ),
                      ),
                    ),
                  ),
                ]);
          case ReadingStatus.initial:
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
      context.read<ReadingBloc>().add(ReadingFetched());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }
}
