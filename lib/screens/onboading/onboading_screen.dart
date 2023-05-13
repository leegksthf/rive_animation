import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/screens/onboading/components/animated_btn.dart';
import 'package:rive_animation/screens/onboading/components/custom_sign_in_dialog.dart';

class OnBoadingScreen extends StatefulWidget {
  const OnBoadingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoadingScreen> createState() => _OnBoadingScreenState();
}

class _OnBoadingScreenState extends State<OnBoadingScreen> {
  bool isShowSignInDialog = false;
  late RiveAnimationController _btnAnimationController =
      OneShotAnimation('active', autoplay: false);

  @override
  void initState() {
    // _btnAnimationController = OneShotAnimation('active', autoplay: false); // initState에서 해줘도 되고, 위에서 바로 선언해줘도 됨
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // Positioned Widget 사용하려면 Stack 필수
        children: [
          // Let's add blur
          Positioned( // 위치 이동시켜 Stack에 배치시킴
            width: MediaQuery.of(context).size.width * 1.7,
            bottom: 200,
            left: 100,
            child: Image.asset('assets/Backgrounds/Spline.png'),
          ),
          // Positioned.fill(
          //     child: BackdropFilter(
          //   filter: ImageFilter.blur(sigmaX: 20, sigmaY: 10),
          // )),
          const RiveAnimation.asset('assets/RiveAssets/shapes.riv'),
          Positioned.fill( // Stack의 공간을 위젯으로 꽉 채울 수 있음
            child: BackdropFilter(
              // BackdropFilter: 기존 페인팅된 콘텐츠에 필터를 적용하는 위젯. 필터는 상위 또는 상위 위젯의 클립 내의 모든 영역에 적용됨. 클립이 없으면 필터가 전체 화면에 적용된다
              filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
              child: const SizedBox(),
              // 이미지에 각도변형, 블러 효과 줄 수 있음 (Matrix, blur)
              // BackdropFilter에 child를 만들어주면 해당 child에만 filter가 적용이 됨.
              // 특정 위젯의 배경에 효과를 주어 보이지 않게 하고싶다면 빈 Container를 추가해주면 됨
            ),
          ),
          AnimatedPositioned(
            top: isShowSignInDialog ? -50 : 0,
            duration: const Duration(milliseconds: 240),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 260,
                      child: Column(
                        children: const [
                          Text(
                            'Learn Design & code',
                            style: TextStyle(
                              fontSize: 60,
                              fontFamily: 'Poppins',
                              height: 1.2,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                              'Don’t skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools.')
                        ],
                      ),
                    ),
                    const Spacer(flex: 2),
                    AnimatedBtn(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;
                        Future.delayed(const Duration(milliseconds: 800), () {
                          setState(() {
                            isShowSignInDialog = true;
                          });
                          customSigninDialog(context, onClosed: (_) {
                            setState(() {
                              isShowSignInDialog = false;
                            });
                          });
                        });
                      },
                    ),
                    const Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                          "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates."),
                    )
                  ],
                ),
                // It's time to add the animated button
              ),
            ),
          )
        ],
      ),
    );
  }


}
