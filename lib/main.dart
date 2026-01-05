import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:demo/pages/main/page.dart';
import 'package:loader_overlay/loader_overlay.dart';

void main() async {
  runApp(
    const ProviderScope(child: DemoApp()),
  );
}

class DemoApp extends HookConsumerWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) => LoaderOverlay(
        overlayWidget: _buildOverlayWidget(),
        child: child ?? const SizedBox(),
      ),
      home: const MainPage(),
    );
  }

  Widget _buildOverlayWidget() {
    return const Center(child: CircularProgressIndicator());
  }
}
