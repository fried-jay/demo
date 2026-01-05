import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

abstract class BaseViewModel {
  final BuildContext context;
  final WidgetRef ref;
  BaseViewModel({required this.context, required this.ref});

  final _rebuild = useState(false);
  final _backButtonPressedTime = useState<DateTime?>(null);

  final _shouldHandleDragRef = useState<bool>(false); 
  bool get shouldHandleDrag => _shouldHandleDragRef.value;

  void rebuild() {
    _rebuild.value = !_rebuild.value;
  }

  hideKeyboard() {
    FocusScope.of(context).unfocus();
  }

  onPopInvoked() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }

    DateTime currentTime = DateTime.now();
    bool isPendingExit =
        _backButtonPressedTime.value == null ||
            currentTime.difference(_backButtonPressedTime.value!) >
                const Duration(seconds: 2);
    if (isPendingExit) {
      _backButtonPressedTime.value = currentTime;
      return;
    }
    SystemNavigator.pop();
  }
}
