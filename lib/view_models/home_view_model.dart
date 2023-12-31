import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

List<String> _cheersList = [
  "마카다미아 초코렛",
  "재미난 200화 이상의 웹툰 발견!",
  "산소 샤워 10K",
  "풀업 30개",
  "3단뛰기 100개",
  "앱으로 돈벌기",
  "😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍😍",
  "🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️🧘🏻‍♂️",
  "💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰💰",
];

class HomeScreenVideModel extends Notifier<String> {
  late int index;

  @override
  String build() {
    index = Random().nextInt(_cheersList.length);
    return _cheersList[index];
  }

  giveMeMore() {
    index = Random().nextInt(_cheersList.length);
    state = _cheersList[index];
  }
}

final homeScreenProvider = NotifierProvider<HomeScreenVideModel, String>(
  () => HomeScreenVideModel(),
);
