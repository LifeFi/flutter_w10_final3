import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_w10_final3/constants/sizes.dart';
import 'package:flutter_w10_final3/repos/authentication_repo.dart';
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

  @override
  Widget build(BuildContext context) {
    print("_selectedIndex @MainNavigation : $_selectedIndex");

    if (mounted &&
        _pageController.hasClients &&
        _selectedIndex != _tabs.indexOf(widget.tab)) {
      _pageController.animateToPage(
        _tabs.indexOf(widget.tab),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    }
    _selectedIndex = _tabs.indexOf(widget.tab);

    return Scaffold(
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
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const [
          HomeScreen(),
          PostScreen(),
          // 기타 탭 스크린들...
        ],
      ),

      /* 
       Stack(
        children: [
          Offstage(
            offstage: _selectedIndex != 0,
            child: const HomeScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const PostScreen(),
          )
        ],
      ),
       */
      bottomNavigationBar: Container(
        height: Sizes.size96,
        padding: const EdgeInsets.only(
          bottom: Sizes.size20,
        ),
        decoration: const BoxDecoration(
          // color: Colors.red,
          border: Border(
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
    );
  }
}
