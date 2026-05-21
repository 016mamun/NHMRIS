import 'package:equatable/equatable.dart';

class KickCounterState extends Equatable {
  final int kickCount;
  final bool isRunning;
  final int elapsedSeconds;
  final List<DateTime> kickTimes;

  const KickCounterState({
    this.kickCount = 0,
    this.isRunning = false,
    this.elapsedSeconds = 0,
    this.kickTimes = const [],
  });

  String get formattedTime {
    final m = (elapsedSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (elapsedSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  bool get isGoalReached => kickCount >= 10;

  KickCounterState copyWith({
    int? kickCount,
    bool? isRunning,
    int? elapsedSeconds,
    List<DateTime>? kickTimes,
  }) {
    return KickCounterState(
      kickCount: kickCount ?? this.kickCount,
      isRunning: isRunning ?? this.isRunning,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      kickTimes: kickTimes ?? this.kickTimes,
    );
  }

  @override
  List<Object?> get props => [kickCount, isRunning, elapsedSeconds];
}
