import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_final3/view_models/moods_view_model.dart';
import 'package:flutter_w10_final3/view_models/user_profile_view_model.dart';

String diffTimeString({required DateTime dateTime, bool isLong = false}) {
  final curTime = DateTime.now();
  final diffMSec =
      curTime.millisecondsSinceEpoch - dateTime.millisecondsSinceEpoch;
  String result;
  if (diffMSec < 60 * 60 * 1000) {
    result =
        "${(diffMSec / (60 * 1000)).round()}${isLong ? " minutes ago" : "m"}";
  } else if (diffMSec < 24 * 60 * 60 * 1000) {
    result =
        "${(diffMSec / (60 * 60 * 1000)).round()}${isLong ? " hours ago" : "h"}";
  } else {
    result =
        "${(diffMSec / (24 * 60 * 60 * 1000)).round()}${isLong ? " days ago" : "d"}";
  }
  return result;
}

void showFirebaseErrorSnack(
  BuildContext context,
  Object? error,
) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      behavior: SnackBarBehavior.fixed,
      content:
          // Text((error as FirebaseException).message ?? "Something went wrong."),
          Text(
              "${(error is FirebaseException ? error.code : error)}\nCheck your email & password."),
    ),
  );
}

Future<void> resetProviders(AsyncNotifierProviderRef ref) async {
  await ref.container.refresh(usersProvider.future);
  await ref.container.refresh(moodsProvider.future);
}
