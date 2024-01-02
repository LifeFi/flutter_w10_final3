import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_final3/constants/sizes.dart';
import 'package:flutter_w10_final3/repos/authentication_repo.dart';
import 'package:flutter_w10_final3/view_models/main_navigation_view_model.dart';
import 'package:flutter_w10_final3/view_models/user_profile_view_model.dart';
import 'package:flutter_w10_final3/views/home_screen.dart';
import 'package:flutter_w10_final3/views/login_screen.dart';
import 'package:flutter_w10_final3/views/post_screen.dart';
import 'package:flutter_w10_final3/views/widgets/nav_tab.dart';
import 'package:go_router/go_router.dart';

class MainNavigationScreen extends ConsumerStatefulWidget {
  static const String routeName = "mainNavigation";
  static const String routeURL = "/:tab(home|post)";
  final String tab;

  const MainNavigationScreen({
    super.key,
    this.tab = "home",
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MainNavigationScreenState();
}

class _MainNavigationScreenState extends ConsumerState<MainNavigationScreen> {
  final PageController _pageController = PageController();

  int _selectedIndex = 0;

  final List<String> _tabs = [
    "home",
    "post",
  ];

  DateTime? lastTapTime;
  int tapCount = 0;

  @override
  void initState() {
    super.initState();

    // Future.microtask(
    //   () {
    //     setState(() {
    //       _selectedIndex = _tabs.indexOf(widget.tab);
    //       _pageController.animateToPage(
    //         _selectedIndex,
    //         duration: const Duration(milliseconds: 200),
    //         curve: Curves.easeInOut,
    //       );
    //     });
    //   },
    // );
  }

  void _onTap(int index) {
    context.go("/${_tabs[index]}");
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  _onLogoutTap() {
    ref.read(authRepo).signOut();
    context.goNamed(LoginScreen.routeName);
  }

  Future<void> _showLogoutBottomsheet() async {
    ref.watch(usersProvider);
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          title: const Text("Log out"),
          message: Text(
            "${ref.watch(usersProvider).value?.name}, are you sure to logout?",
            style: const TextStyle(
              fontSize: Sizes.size18,
            ),
          ),
          actions: [
            CupertinoActionSheetAction(
              onPressed: _onLogoutTap,
              child: const Text(
                "Log out",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            isDefaultAction: true,
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
        );
      },
    );

    /*  await showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      elevation: 0,
      context: context,
      builder: (context) => const SizedBox(
        height: 100,
        child: Scaffold(
          body: SizedBox(
            height: 100,
            child: Text("Log Out"),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Sizes.size16),
          topRight: Radius.circular(Sizes.size16),
        ),
      ),
    ); */
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _eightTappedToLogout() {
    DateTime now = DateTime.now();
    if (lastTapTime == null || now.difference(lastTapTime!).inSeconds > 1) {
      // 1초가 넘었으면 카운트 초기화
      tapCount = 0;
    }
    lastTapTime = now;
    tapCount++;

    if (tapCount == 8) {
      // 8번 탭하면 실행
      _onLogoutTap();
      tapCount = 0; // 작업 실행 후 카운트 초기화
    }
    print(tapCount);
    setState(() {});
  }

  void _tapToggleShowBottomTabBar() {
    ref.read(showBottomTabBarProvider.notifier).update((state) => !state);
  }

  @override
  Widget build(BuildContext context) {
    print("_selectedIndex @MainNavigation : $_selectedIndex");
    ref.watch(showBottomTabBarProvider);

    if (mounted &&
        _pageController.hasClients &&
        _selectedIndex != _tabs.indexOf(widget.tab)) {
      _pageController.animateToPage(
        _tabs.indexOf(widget.tab),
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
      );
    }
    _selectedIndex = _tabs.indexOf(widget.tab);

    return GestureDetector(
      onTap: _tapToggleShowBottomTabBar,
      child: Scaffold(
        appBar: AppBar(
          title: GestureDetector(
            onLongPress: _showLogoutBottomsheet,
            child: const Text(
              "🔥 MOOD 🔥",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: _eightTappedToLogout,
              icon: Icon(
                Icons.logout,
                color: Colors.transparent,
                size: Sizes.size20 + tapCount * 3,
              ),
            )
          ],
        ),
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                context.go("/${_tabs[index]}");
                // setState(() {
                //   _selectedIndex = index;
                // });
              },
              children: const [
                HomeScreen(),
                PostScreen(),
                // 기타 탭 스크린들...
              ],
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: AnimatedSlide(
                  offset: Offset(
                    0.0,
                    _selectedIndex == 0
                        ? (ref.read(showBottomTabBarProvider.notifier).state
                            ? 0.0
                            : 1.0)
                        : 0.0,
                  ),
                  duration: const Duration(milliseconds: 150),
                  child: Container(
                    height: Sizes.size96,
                    padding: const EdgeInsets.only(
                      bottom: Sizes.size20,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      border: const Border(
                        top: BorderSide(
                          width: 1.5,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        NavTab(
                          isSelected: _selectedIndex == 0,
                          icon: Icons.home,
                          selectedIcon: Icons.home_filled,
                          onTap: () => _onTap(0),
                        ),
                        NavTab(
                          isSelected: _selectedIndex == 1,
                          icon: Icons.mode_edit_outlined,
                          selectedIcon: Icons.mode_edit,
                          onTap: () => _onTap(1),
                        )
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
