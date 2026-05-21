import 'package:equatable/equatable.dart';

abstract class KickCounterEvent extends Equatable {
  const KickCounterEvent();
  @override
  List<Object?> get props => [];
}

class KickCounterStarted extends KickCounterEvent {
  const KickCounterStarted();
}

class KickCounterKickAdded extends KickCounterEvent {
  const KickCounterKickAdded();
}

class KickCounterReset extends KickCounterEvent {
  const KickCounterReset();
}

class KickCounterTimerTicked extends KickCounterEvent {
  final int elapsed;
  const KickCounterTimerTicked({required this.elapsed});
  @override
  List<Object?> get props => [elapsed];
}
