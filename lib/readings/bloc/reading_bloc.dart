import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:placeholder_data/placeholder_data.dart';
import 'package:zataca_demo_app/common/bloc/event_transformer.dart';

part 'reading_event.dart';
part 'reading_state.dart';

const throttleDuration = Duration(milliseconds: 100);

class ReadingBloc extends Bloc<ReadingEvent, ReadingState> {
  ReadingBloc({required PlaceholderDataAPI dataRepository})
      : _dataRepository = dataRepository,
        super(const ReadingState()) {
    on<ReadingFetched>(
      _onReeadingFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  final PlaceholderDataAPI _dataRepository;

  Future<void> _onReeadingFetched(
    ReadingFetched event,
    Emitter<ReadingState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ReadingStatus.initial) {
        final readings = await _dataRepository.fetchReadings();
        return emit(
          state.copyWith(
            status: ReadingStatus.success,
            readings: readings,
            hasReachedMax: false,
          ),
        );
      }
      final readings =
          await _dataRepository.fetchReadings(state.readings.length);
      readings.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: ReadingStatus.success,
                readings: List.of(state.readings)..addAll(readings),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: ReadingStatus.failure));
    }
  }
}
