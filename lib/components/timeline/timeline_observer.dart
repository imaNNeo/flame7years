import 'package:flame/components.dart';
import 'package:flame7years/commits/contributions.dart';
import 'package:flame7years/components/timeline/timeline_manager.dart';

mixin TimelineObserver on Component {
  late TimelineManager _manager;

  @override
  void onMount() {
    super.onMount();
    _manager = ancestors(includeSelf: true)
        .firstWhere((c) => c is TimelineManager) as TimelineManager;
    _manager.currentDateIndexNotifier.addListener(_onDateChanged);
  }

  void _onDateChanged() {
    onDateChanged(
      _manager.contributionData,
      _manager.currentDateIndexNotifier.value,
    );
  }

  void onDateChanged(ContributionDataEntity data, int dateIndex);

  @override
  void onRemove() {
    _manager.currentDateIndexNotifier.removeListener(_onDateChanged);
    super.onRemove();
  }
}
