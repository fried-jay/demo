import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:demo/pages/main/viewModel.dart';
import 'package:demo/pages/main/view.dart';
import 'package:demo/pages/base/page.dart';

class MainPage extends BasePage<MainView, MainViewModel> {
  const MainPage({super.key});

  @override
  MainView initView({
    required BuildContext context,
    required WidgetRef ref,
    required MainViewModel viewModel,
  }) {
    return MainView(context: context, viewModel: viewModel);
  }

  @override
  MainViewModel initViewModel({
    required BuildContext context,
    required WidgetRef ref,
  }) {
    return MainViewModel(
      context: context,
      ref: ref,
    );
  }
}
