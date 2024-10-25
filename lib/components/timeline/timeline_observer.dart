import 'package:flame/components.dart';
import 'package:flame7years/commits/contributions.dart';
import 'package:flame7years/components/timeline/timeline_manager.dart';

mixin TimelineObserver on Component {
  late TimelineManager _manager;
  static const totalYears = 7;

  @override
  void onMount() {
    super.onMount();
    _manager = ancestors(includeSelf: true)
        .firstWhere((c) => c is TimelineManager) as TimelineManager;
    _manager.currentDateIndexNotifier.addListener(_onDateChanged);
  }

  void _onDateChanged() {
    final data = _manager.contributionData;
    final dateIndex = _manager.currentDateIndexNotifier.value;
    final allDates = data.dates.length - 1;
    int year = (dateIndex ~/ (allDates / totalYears)) + 1;
    if (year >= 8) {
      year = 7;
      return;
    }
    final month = (dateIndex % 12) + 1;
    onDateChanged(
      data,
      dateIndex,
      year,
      month,
    );
  }

  void onDateChanged(
    ContributionDataEntity data,
    int dateIndex,
    int year,
    int month,
  );

  @override
  void onRemove() {
    _manager.currentDateIndexNotifier.removeListener(_onDateChanged);
    super.onRemove();
  }
}
