import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_final3/constants/gaps.dart';
import 'package:flutter_w10_final3/constants/sizes.dart';
import 'package:flutter_w10_final3/view_models/post_mood_view_model.dart';
import 'package:flutter_w10_final3/views/widgets/big_button.dart';

class PostScreen extends ConsumerStatefulWidget {
  static const String routeURL = "/post";
  const PostScreen({super.key});

  @override
  PostScreenState createState() => PostScreenState();
}

class PostScreenState extends ConsumerState<PostScreen> {
  final TextEditingController _controller = TextEditingController();
  int? _selectedMoodEmojiIndex;
  final List<String> _moodEmojiList = [
    "😀",
    "😍",
    "😊",
    "🥳",
    "😭",
    "🤬",
    "🫠",
    "🤮",
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(
      () {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _selectMoodEmoji(int index) {
    setState(() {
      _selectedMoodEmojiIndex = index;
    });
  }

  bool _validator() {
    if (_selectedMoodEmojiIndex == null ||
        _selectedMoodEmojiIndex! > _moodEmojiList.length) return false;
    if (_controller.text.isEmpty) return false;
    return true;
  }

  _onSubmitPost() {
    // print(_controller.text);
    // print(_moodEmojiList[_selectedMoodEmojiIndex!]);
    ref.read(postMoodProvider.notifier).postMood(
          content: _controller.text,
          moodEmoji: _moodEmojiList[_selectedMoodEmojiIndex!],
        );
    setState(() {
      _selectedMoodEmojiIndex = null;
      _controller.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.size20,
      ),
      child: ListView(
        children: [
          Gaps.v20,
          const Text(
            "How do you feel?",
            style: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.v10,
          Container(
            // height: 150,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size10,
            ),
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                Sizes.size6,
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
            child: TextField(
              controller: _controller,
              autofocus: true,
              maxLines: null,
              minLines: 5,
              decoration: const InputDecoration(
                isDense: true,
                hintText: "Write it down here!",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Gaps.v20,
          const Text(
            "What's your mood?",
            style: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.bold,
            ),
          ),
          Gaps.v10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int index = 0; index < _moodEmojiList.length; index++)
                GestureDetector(
                  onTap: () => _selectMoodEmoji(index),
                  child: Container(
                    width: Sizes.size32,
                    height: Sizes.size32,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _selectedMoodEmojiIndex == index
                          ? Theme.of(context).highlightColor
                          : Colors.white,
                      borderRadius: BorderRadius.circular(
                        Sizes.size6,
                      ),
                      border: Border.all(
                        width: 0.5,
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
                      _moodEmojiList[index],
                      style: const TextStyle(
                        fontSize: Sizes.size20,
                      ),
                    ),
                  ),
                )
            ],
          ),
          Gaps.v52,
          BigButton(
            text: "Post",
            fn: _onSubmitPost,
            color: Theme.of(context).highlightColor,
            width: MediaQuery.of(context).size.width * 0.7,
            enabled: _validator(),
            isLoading: ref.watch(postMoodProvider).isLoading,
            // height: 100,
          ),
          Gaps.v80
        ],
      ),
    );
  }
}
