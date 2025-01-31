import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';

class ExpandedViewmodel extends BlocBase {
  final _isExpandedController = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get isExpandedStream => _isExpandedController.stream;

  void toggledExpansion() {
    bool current = _isExpandedController.value;

    _isExpandedController.add(!current);
  }

  @override
  void dispose() {
    super.dispose();
    _isExpandedController.close();
  }
}
