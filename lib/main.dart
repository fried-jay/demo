import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:demo/pages/main/page.dart';

void main() async {
  runApp(
    ProviderScope(child: DemoApp()),
  );
}

class DemoApp extends HookConsumerWidget {
  const DemoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
            if (child == null) return const SizedBox();
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(1.0)),
              child: child,
            );
          },
          home: const MainPage(),
    );
  }
}
