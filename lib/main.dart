import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

import 'app_router.dart';

void main() {
  runApp(const ProviderScope(child: Loshical()));
}

class Loshical extends StatelessWidget {
  const Loshical({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,
      routerConfig: goRouter,
      // home: QuestionScreen(),
    );
  }
}
