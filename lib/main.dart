import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_final3/firebase_options.dart';
import 'package:flutter_w10_final3/repos/recent_login_email_repo.dart';
import 'package:flutter_w10_final3/router.dart';
import 'package:flutter_w10_final3/view_models/recent_email_login_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );

  GoRouter.optionURLReflectsImperativeAPIs = true;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final preferences = await SharedPreferences.getInstance();
  final repository = RecentLoginEmailRepository(preferences);

  runApp(
    ProviderScope(
      overrides: [
        recentLoginEmailProvider.overrideWith(
          () => RecentLoginEmailViewModel(repository),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Final 3 - Mood Tracker',
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFEDE6C2),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFEDE6C2),
          surfaceTintColor: Color(0xFFEDE6C2),
        ),
        primaryColor: const Color(0xFF74BEA9),
        highlightColor: const Color(0xFFFFA6F6),
      ),
    );
  }
}
