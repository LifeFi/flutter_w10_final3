import 'package:flutter/material.dart';
import 'package:flutter_w10_final3/constants/gaps.dart';
import 'package:flutter_w10_final3/constants/sizes.dart';
import 'package:flutter_w10_final3/utils.dart';

class MoodTile extends StatelessWidget {
  final String text;
  final DateTime createdAt;

  const MoodTile({
    super.key,
    required this.text,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // height: 150,
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
            vertical: Sizes.size10,
          ),
          // alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(
              Sizes.size18,
            ),
            border: Border.all(
              width: Sizes.size2,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.black, // 그림자 색상 및 투명도
                spreadRadius: 1, // 그림자의 범위를 조절
                blurRadius: 0, // 블러 정도
                offset: Offset(0, 2), // 우측과 하단으로 그림자의 위치 조절
              ),
            ],
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: Sizes.size16,
            ),
          ),
        ),
        Gaps.v10,
        Text(
          diffTimeString(dateTime: createdAt, isLong: true),
          style: TextStyle(
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        Gaps.v20,
      ],
    );
  }
}
