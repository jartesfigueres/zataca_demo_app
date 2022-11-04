part of 'reading_bloc.dart';

enum ReadingStatus { initial, success, failure }

class ReadingState extends Equatable {
  const ReadingState({
    this.status = ReadingStatus.initial,
    this.readings = const <Reading>[],
    this.hasReachedMax = false,
  });

  final ReadingStatus status;
  final List<Reading> readings;
  final bool hasReachedMax;

  ReadingState copyWith({
    ReadingStatus? status,
    List<Reading>? readings,
    bool? hasReachedMax,
  }) {
    return ReadingState(
      status: status ?? this.status,
      readings: readings ?? this.readings,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ReadingState { status: $status, hasReachedMax: $hasReachedMax, posts: ${readings.length} }''';
  }

  @override
  List<Object> get props => [status, readings, hasReachedMax];
}
