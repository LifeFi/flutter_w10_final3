import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_final3/repos/authentication_repo.dart';
import 'package:flutter_w10_final3/utils.dart';
import 'package:flutter_w10_final3/view_models/recent_email_login_view_model.dart';
import 'package:flutter_w10_final3/view_models/user_profile_view_model.dart';
import 'package:flutter_w10_final3/views/main_navigation_screen.dart';
import 'package:go_router/go_router.dart';

class EmailSignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> emailSignUp({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    state = const AsyncValue.loading();
    final user = ref.read(usersProvider.notifier);

    state = await AsyncValue.guard(() async {
      final userCredential = await _authRepo.emailSignUp(
        email,
        password,
      );
      await user.createProfile(userCredential);
    });
    if (!context.mounted) return;
    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      await resetProviders(ref);
      ref.read(recentLoginEmailProvider.notifier).resetLoginEmail(email);
      if (context.mounted) {
        context.goNamed(
          MainNavigationScreen.routeName,
          pathParameters: {"tab": "home"},
        );
      }
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final emailSignUpProvider = AsyncNotifierProvider<EmailSignUpViewModel, void>(
  () => EmailSignUpViewModel(),
);
