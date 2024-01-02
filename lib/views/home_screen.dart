import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_final3/constants/sizes.dart';
import 'package:flutter_w10_final3/repos/moods_repo.dart';
import 'package:flutter_w10_final3/view_models/main_navigation_view_model.dart';
import 'package:flutter_w10_final3/view_models/moods_view_model.dart';
import 'package:flutter_w10_final3/views/post_screen.dart';
import 'package:flutter_w10_final3/views/widgets/mood_tile.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static const String routeURL = "/home";
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends ConsumerState<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isMoreLoading = false;

  Future<void> _refresh() async {
    if (ref.read(moodsProvider).isLoading) return;
    await ref.read(moodsProvider.notifier).refresh();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_fetchNextItems);
    _scrollController.addListener(_scrollToggleShowBottomTabBar);
  }

  _scrollToggleShowBottomTabBar() {
    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        ref.read(showBottomTabBarProvider.notifier).state) {
      ref.read(showBottomTabBarProvider.notifier).state = false;
    } else if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        !ref.read(showBottomTabBarProvider.notifier).state) {
      ref.read(showBottomTabBarProvider.notifier).state = true;
    }
    print(ref.read(showBottomTabBarProvider.notifier).state);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _fetchNextItems() async {
    // print(
    //     "${_scrollController.position.pixels} ====  ${_scrollController.position.maxScrollExtent}");
    if (_isMoreLoading) return;
    if (ref.read(moodsProvider).value != null &&
        ref.read(moodsProvider).value!.length < fetchMoodsLimit) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent) {
      // 리스트 하단에 로딩바를 보여주기 위함.
      setState(() {
        _isMoreLoading = true;
      });
      await ref.read(moodsProvider.notifier).fetchNextItems();
      setState(() {
        _isMoreLoading = false;
      });
    }
  }

  _goToPost() {
    context.go(PostScreen.routeURL);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: _refresh,
      child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size20,
          ),
          child: ref.watch(moodsProvider).when(
                error: (error, stackTrace) => Center(
                  child: Text("Somthing is wrong: $error"),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                data: (data) {
                  // print(data.length);
                  if (data.isEmpty) {
                    return Container(
                      height: 120,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(
                        top: Sizes.size52,
                        bottom: Sizes.size28,
                      ),
                      child: GestureDetector(
                        onTap: _goToPost,
                        child: const Text(
                          "Write your first feeling 😀 →",
                          style: TextStyle(
                            fontSize: Sizes.size20,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      controller: _scrollController,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: data.length + 1,
                      itemBuilder: (context, index) {
                        if (index < data.length) {
                          return MoodTile(
                            text:
                                "Mood: ${data[index].moodEmoji}\n${data[index].content}",
                            createdAt: data[index].createdAt!.toDate(),
                          );
                        } else if (_isMoreLoading) {
                          return Container(
                            padding: const EdgeInsets.only(
                              top: Sizes.size10,
                              bottom: Sizes.size28,
                            ),
                            child: const Center(
                              child: CircularProgressIndicator.adaptive(),
                            ),
                          );
                        }
                        return Container(
                          padding: const EdgeInsets.only(
                            top: Sizes.size10,
                            bottom: Sizes.size28,
                          ),
                        );
                      },
                    );
                  }
                },
              )),
    );
  }
}
