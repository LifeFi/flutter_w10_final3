import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_final3/repos/authentication_repo.dart';
import 'package:flutter_w10_final3/views/login_screen.dart';
import 'package:flutter_w10_final3/views/main_navigation_screen.dart';
import 'package:flutter_w10_final3/views/sign_up_screen.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state) {
      print("state.matchedLocation: ${state.matchedLocation}");

      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.matchedLocation != SignUpScreen.routeURL &&
            state.matchedLocation != LoginScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: SignUpScreen.routeURL,
        name: SignUpScreen.routeName,
        builder: (context, state) {
          return const SignUpScreen();
        },
      ),
      GoRoute(
        path: LoginScreen.routeURL,
        name: LoginScreen.routeName,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: MainNavigationScreen.routeURL, // "/:tab(home|post)"
        name: MainNavigationScreen.routeName,
        builder: (context, state) {
          final tab = state.pathParameters["tab"]!;
          return MainNavigationScreen(tab: tab);
        },
      ),
    ],
  );
});
