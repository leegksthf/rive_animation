import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:rive_animation/components/info_card.dart';
import 'package:rive_animation/components/side_menu_tile.dart';
import 'package:rive_animation/const.dart';
import 'package:rive_animation/models/rive_asset.dart';
import 'package:rive_animation/utils/rive_utils.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  RiveAsset selectedMenu = sideMenus.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: backgroundColor2,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                name: '이한솔',
                profession: 'Youtuber',
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'Browse'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenus.map(
                (menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    StateMachineController controller = RiveUtils.getRiveController(artboard, stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI('active') as SMIBool;
                  },
                  press: () {
                    menu.input!.change(true);
                    setState(() {
                      selectedMenu = menu;
                    });
                    Future.delayed(Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  'History'.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sideMenus2.map(
                    (menu) => SideMenuTile(
                  menu: menu,
                  riveonInit: (artboard) {
                    StateMachineController controller = RiveUtils.getRiveController(artboard, stateMachineName: menu.stateMachineName);
                    menu.input = controller.findSMI('active') as SMIBool;
                  },
                  press: () {
                    menu.input!.change(true);
                    setState(() {
                      selectedMenu = menu;
                    });
                    Future.delayed(Duration(seconds: 1), () {
                      menu.input!.change(false);
                    });
                  },
                  isActive: selectedMenu == menu,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
