import 'package:go_router/go_router.dart';
import 'package:loshical/question_screen.dart';
import 'package:loshical/results_screen.dart';

enum AppRoute {
  startPage,
  resultScreen,
}

final goRouter = GoRouter(
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        name: AppRoute.startPage.name,
        builder: (context, state) => const QuestionScreen(),
        routes: [
          GoRoute(
            path: 'result/:id',
            name: AppRoute.resultScreen.name,
            builder: (context, state) {
              final imageId = state.pathParameters['id'];
              return ResultScreen(
                id: imageId,
              );
            },
          )
        ]),
    // settingsScreenRoutings(),
  ],
);
