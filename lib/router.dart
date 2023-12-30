import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_final3/views/home_screen.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});
