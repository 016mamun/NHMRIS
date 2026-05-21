import 'package:equatable/equatable.dart';
import '../models/module_model.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();
  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

class DashboardLoaded extends DashboardState {
  final List<ModuleModel> modules;
  final String dailyTip;
  final bool showTip;

  const DashboardLoaded({
    required this.modules,
    required this.dailyTip,
    this.showTip = true,
  });

  DashboardLoaded copyWith({
    List<ModuleModel>? modules,
    String? dailyTip,
    bool? showTip,
  }) {
    return DashboardLoaded(
      modules: modules ?? this.modules,
      dailyTip: dailyTip ?? this.dailyTip,
      showTip: showTip ?? this.showTip,
    );
  }

  @override
  List<Object?> get props => [modules, dailyTip, showTip];
}

class DashboardError extends DashboardState {
  final String message;
  const DashboardError({required this.message});
  @override
  List<Object?> get props => [message];
}
