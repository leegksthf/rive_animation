import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/components/animated_bar.dart';
import 'package:rive_animation/components/side_menu.dart';
import 'package:rive_animation/const.dart';
import 'package:rive_animation/models/menu_btn.dart';
import 'package:rive_animation/models/rive_asset.dart';
import 'package:rive_animation/screens/home/home_screen.dart';

import 'utils/rive_utils.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({Key? key}) : super(key: key);

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  RiveAsset selectedBottomNav = bottomNavs.first;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scalAnimation;
  late SMIBool isSideBarClosed;

  bool isSideMenuClosed = true;

  @override
  void initState() {
    // vsync는 AnimationController에 필수속성
    // 애니메이션 최적화 및 언제 재생할지 시간을 세어주는 등의 기능을 위해 필요
    // this는 위에서 레퍼런스가 존재하는 '객체'가 vsync역할을 해줌
    // SingleTickerProviderStateMixin을 활용했기때문에 가능. 이것을 넣지 않으면 vsync에 할당할 수 없다.
    // 애니메이션 여러 개를 쓰려면 멀티Ticker 사용하면 됨
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(children: [
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          curve: Curves.fastOutSlowIn,
          width: 288,
          left: isSideMenuClosed ? 10 : 0,
          height: MediaQuery.of(context).size.height,
          child: SideMenu(),
        ),
        Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateY(animation.value - 30 * animation.value * pi / 180),
          child: Transform.translate(
            offset: Offset(animation.value * 265, 0),
            child: Transform.scale(
              scale: scalAnimation.value,
              child: ClipRRect(
                child: const HomeScreen(),
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
            ),
          ),
        ),
        // HomeScreen(),
        AnimatedPositioned(
          duration: Duration(milliseconds: 200),
          top: 16,
          curve: Curves.fastOutSlowIn,
          left: isSideMenuClosed ? 0 : 220,
          child: MenuBtn(
            riveOnInit: (artboard) {
              StateMachineController controller = RiveUtils.getRiveController(
                  artboard,
                  stateMachineName: 'State Machine');
              isSideBarClosed = controller.findSMI('isOpen') as SMIBool;
              isSideBarClosed.value = true;
            },
            press: () {
              isSideBarClosed.value = !isSideBarClosed.value;
              if (isSideMenuClosed) {
                _animationController.forward(); // 애니메이션 시작
              } else {
                _animationController.reverse(); // 애니메이션 역순 재생
              }
              setState(() {
              isSideMenuClosed = isSideBarClosed.value;
              });
            },
          ),
        ),
      ]),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavs.length,
                (index) => GestureDetector(
                  onTap: () {
                    // searchTrigger.change(true);
                    bottomNavs[index].input!.change(true);
                    if (bottomNavs[index] != selectedBottomNav) {
                      setState(() {
                        selectedBottomNav = bottomNavs[index];
                      });
                    }
                    Future.delayed(Duration(seconds: 1), () {
                      bottomNavs[index].input!.change(false);
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // 크기만큼만 차지. max: 남은 영역을 모두 사용
                    children: [
                      AnimatedBar(
                          isActive: bottomNavs[index] == selectedBottomNav),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity:
                              bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            bottomNavs[0].src,
                            artboard: bottomNavs[index].artboard,
                            onInit: (artboard) {
                              StateMachineController controller =
                                  RiveUtils.getRiveController(artboard,
                                      stateMachineName:
                                          bottomNavs[index].stateMachineName);
                              bottomNavs[index].input =
                                  controller.findSMI('active') as SMIBool;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
