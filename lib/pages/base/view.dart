import 'dart:io';

import 'package:flutter/material.dart';
import 'package:demo/pages/base/viewModel.dart';

abstract class BaseView<VM extends BaseViewModel> extends StatelessWidget {
  final BuildContext context;
  final VM viewModel;

  const BaseView({super.key, required this.context, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => viewModel.hideKeyboard(),
      child: PopScope(
        canPop: Platform.isIOS,
        child: Scaffold(
          resizeToAvoidBottomInset: Platform.isAndroid,
          backgroundColor: Colors.white,
          appBar: buildAppBar(),
          body: Center(
            child: Container(
              width: 360.0,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(color: Colors.white),
              child: SafeArea(
                maintainBottomViewPadding: true,
                child: buildBody(),
              ),
            ),
          ),
          bottomNavigationBar: buildBottomNavigationBar(),
          endDrawer: buildDrawer(),
          bottomSheet: buildBottomSheet(),
        ),
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          viewModel.onPopInvoked();
        },
      ),
    );
  }

  Widget buildBody();

  PreferredSizeWidget? buildAppBar() {
    return null;
  }

  Widget? buildBottomNavigationBar() {
    return null;
  }

  Widget? buildDrawer() {
    return null;
  }

  Widget? buildBottomSheet() {
    return null;
  }
}
