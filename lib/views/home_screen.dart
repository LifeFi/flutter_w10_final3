import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_final3/constants/gaps.dart';
import 'package:flutter_w10_final3/constants/sizes.dart';
import 'package:flutter_w10_final3/view_models/home_view_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  int sizePlus = 0;

  _sendMeCheers() {
    ref.read(homeScreenProvider.notifier).giveMeMore();
    setState(() {
      if (sizePlus < 100) {
        ++sizePlus;
      } else {
        sizePlus = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _sendMeCheers,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Be Ready!"),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  ref.watch(homeScreenProvider),
                  style: TextStyle(
                    fontSize: Sizes.size28 + sizePlus,
                  ),
                ),
                Gaps.v80,
                TextButton(
                  onPressed: _sendMeCheers,
                  child: const Text(
                    "응원 선물 받기 TAP!!",
                    style: TextStyle(fontSize: Sizes.size28),
                  ),
                ),
                Gaps.v80,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
