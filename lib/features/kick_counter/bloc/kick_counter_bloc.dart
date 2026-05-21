import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'kick_counter_event.dart';
import 'kick_counter_state.dart';

class KickCounterBloc extends Bloc<KickCounterEvent, KickCounterState> {
  Timer? _timer;

  KickCounterBloc() : super(const KickCounterState()) {
    on<KickCounterStarted>(_onStarted);
    on<KickCounterKickAdded>(_onKickAdded);
    on<KickCounterReset>(_onReset);
    on<KickCounterTimerTicked>(_onTimerTicked);
  }

  void _onStarted(KickCounterStarted event, Emitter<KickCounterState> emit) {
    if (!state.isRunning) {
      emit(state.copyWith(isRunning: true));
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        add(KickCounterTimerTicked(elapsed: state.elapsedSeconds + 1));
      });
    }
  }

  void _onTimerTicked(
    KickCounterTimerTicked event,
    Emitter<KickCounterState> emit,
  ) {
    emit(state.copyWith(elapsedSeconds: event.elapsed));
  }

  void _onKickAdded(
    KickCounterKickAdded event,
    Emitter<KickCounterState> emit,
  ) {
    if (!state.isRunning) {
      add(const KickCounterStarted());
    }
    final newKicks = [...state.kickTimes, DateTime.now()];
    emit(state.copyWith(
      kickCount: state.kickCount + 1,
      kickTimes: newKicks,
    ));
  }

  void _onReset(KickCounterReset event, Emitter<KickCounterState> emit) {
    _timer?.cancel();
    emit(const KickCounterState());
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
