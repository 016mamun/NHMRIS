import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/module_model.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  static const List<String> _tips = [
    'পর্যাপ্ত পানি পান করুন এবং পুষ্টিকর খাবার খান। আপনার শিশুর বৃদ্ধি ত্বরান্বিত হচ্ছে।',
    'প্রতিদিন ৩০ মিনিট হালকা হাঁটাহাঁটি করুন। এটি আপনার ও শিশুর জন্য উপকারী।',
    'প্রতিদিন কমপক্ষে ৮-১০ গ্লাস পানি পান করুন। হাইড্রেটেড থাকুন।',
    'ডাক্তারের পরামর্শ অনুযায়ী আয়রন ও ফলিক অ্যাসিড ট্যাবলেট খান।',
    'পর্যাপ্ত ঘুম নিশ্চিত করুন। দিনে কমপক্ষে ৮ ঘণ্টা ঘুমান।',
    'মানসিক চাপ কমাতে ধ্যান বা শ্বাস-প্রশ্বাসের ব্যায়াম করুন।',
    'নিয়মিত ANC চেকআপ করান। আপনার পরবর্তী ভিজিট সময়মতো করুন।',
  ];

  DashboardBloc() : super(const DashboardInitial()) {
    on<DashboardLoadRequested>(_onLoadRequested);
    on<DashboardRefreshRequested>(_onRefreshRequested);
    on<DashboardTipDismissed>(_onTipDismissed);
  }

  Future<void> _onLoadRequested(
    DashboardLoadRequested event,
    Emitter<DashboardState> emit,
  ) async {
    emit(const DashboardLoading());
    await Future.delayed(const Duration(milliseconds: 400));
    final dayOfWeek = DateTime.now().weekday - 1;
    final tip = _tips[dayOfWeek % _tips.length];
    emit(
      DashboardLoaded(
        modules: ModuleModel.allModules,
        dailyTip: tip,
      ),
    );
  }

  Future<void> _onRefreshRequested(
    DashboardRefreshRequested event,
    Emitter<DashboardState> emit,
  ) async {
    if (state is DashboardLoaded) {
      final current = state as DashboardLoaded;
      await Future.delayed(const Duration(milliseconds: 300));
      emit(current.copyWith());
    }
  }

  void _onTipDismissed(
    DashboardTipDismissed event,
    Emitter<DashboardState> emit,
  ) {
    if (state is DashboardLoaded) {
      final current = state as DashboardLoaded;
      emit(current.copyWith(showTip: false));
    }
  }
}
