import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
  @override
  List<Object?> get props => [];
}

class DashboardLoadRequested extends DashboardEvent {
  final String userId;
  const DashboardLoadRequested({required this.userId});
  @override
  List<Object?> get props => [userId];
}

class DashboardRefreshRequested extends DashboardEvent {
  const DashboardRefreshRequested();
}

class DashboardTipDismissed extends DashboardEvent {
  const DashboardTipDismissed();
}
