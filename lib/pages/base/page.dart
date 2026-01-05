import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:demo/pages/base/view.dart';
import 'package:demo/pages/base/viewModel.dart';

abstract class BasePage<V extends BaseView, VM extends BaseViewModel> extends HookConsumerWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = initViewModel(context: context, ref: ref);
    return initView(context: context, ref: ref, viewModel: viewModel);
  }

  V initView({required BuildContext context, required WidgetRef ref, required VM viewModel});

  VM initViewModel({required BuildContext context, required WidgetRef ref});
}
