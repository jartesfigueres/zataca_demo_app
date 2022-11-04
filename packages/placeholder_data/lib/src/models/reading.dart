import 'package:equatable/equatable.dart';

class Reading extends Equatable {
  const Reading({
    required this.id,
    required this.type,
    required this.date,
    required this.active,
  });

  final int id;
  final String type;
  final DateTime date;
  final bool active;

  @override
  List<Object> get props => [id, type, date, active];
}
