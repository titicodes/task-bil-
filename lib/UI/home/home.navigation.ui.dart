import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskitly/constants/palette.dart';

import '../../constants/reuseables.dart';
import '../base/base.ui.dart';
import '../widgets/apptexts.dart';
import 'home.navigation.vm.dart';
import 'package:badges/badges.dart' as badges;

class HomeScreen extends StatelessWidget {
  final int selectedIndex;
  const HomeScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeTabViewModel>(
      onModelReady: (m) => m.init(selectedIndex),
      builder: (_, model, child) => WillPopScope(
        onWillPop: () async {
          model.popUp("Close Taskitly", model.pop);
          return false;
        },
        child: Scaffold(
            body: model.pages[model.selectedPage],
            //   body: IndexedStack(
            //     index: model.selectedPage,
            //     children: ,
            //   ),
            bottomNavigationBar: _BottomNavigationBar(
              onItemSelected: model.onNavigationItem,
              selectedIndex: model.selectedPage,
              model: model,
            )),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    Key? key,
    required this.onItemSelected,
    required this.selectedIndex,
    required this.model,
  }) : super(key: key);

  final Function(int) onItemSelected;
  final int selectedIndex;
  final HomeTabViewModel model;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: grey, blurRadius: 4)]),
      margin: const EdgeInsets.all(0),
      child: SafeArea(
        top: false,
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.only(),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NavigationBarItem(
                  icon: AppImages.homeBlank,
                  isSelectedIcon: AppImages.homeFilled,
                  label: 'Home',
                  isSelected: (selectedIndex == 0),
                  index: 0,
                  onTap: onItemSelected,
                  model: model,
                ),
                _NavigationBarItem(
                  icon: userService.isUserServiceProvider
                      ? AppImages.chatBlank
                      : AppImages.browseBlank,
                  isSelectedIcon: userService.isUserServiceProvider
                      ? AppImages.chatFilled
                      : AppImages.browseFilled,
                  label: userService.isUserServiceProvider ? 'Chats' : 'Browse',
                  isSelected: (selectedIndex == 1),
                  index: 1,
                  onTap: onItemSelected,
                  model: model,
                ),
                _NavigationBarItem(
                  icon: AppImages.requestBlank,
                  isSelectedIcon: AppImages.requestFilled,
                  label: 'Requests',
                  isSelected: (selectedIndex == 2),
                  index: 2,
                  onTap: onItemSelected,
                  model: model,
                ),
                _NavigationBarItem(
                  icon: AppImages.billsBlank,
                  isSelectedIcon: AppImages.billsBlank,
                  label: 'Bills',
                  isSelected: (selectedIndex == 3),
                  index: 3,
                  onTap: onItemSelected,
                  model: model,
                ),
                _NavigationBarItem(
                  icon: AppImages.settingsBlank,
                  isSelectedIcon: AppImages.settingsFilled,
                  label: 'Settings',
                  isSelected: (selectedIndex == 4),
                  index: 4,
                  model: model,
                  onTap: onItemSelected,
                ),
              ]),
        ),
      ),
    );
  }
}

class _NavigationBarItem extends StatelessWidget {
  _NavigationBarItem(
      {Key? key,
      required this.label,
      required this.icon,
      required this.isSelectedIcon,
      required this.index,
      this.isSelected = false,
      required this.onTap,
      required this.model})
      : super(key: key);

  final String label;
  final String icon;
  final HomeTabViewModel model;
  final String isSelectedIcon;
  final int index;
  final bool isSelected;
  ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          onTap(index);
        },
        child: SizedBox(
          height: 80,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 78.5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (label != "Chats")
                      Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.02)
                                : Colors.transparent,
                          ),
                          child: SvgPicture.asset(
                            isSelected ? isSelectedIcon : icon,
                            height: 24,
                            color: isSelected
                                ? primaryColor
                                : Theme.of(context).disabledColor,
                            width: 24,
                            fit: BoxFit.cover,
                          ))
                    else
                      Container(
                          height: 40,
                          width: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: isSelected
                                ? Theme.of(context)
                                    .primaryColor
                                    .withOpacity(0.02)
                                : Colors.transparent,
                          ),
                          child: ValueListenableBuilder(
                            valueListenable: model.someValueNotifier,
                            builder: (context, value, child) {
                              return value == 0
                                  ? SvgPicture.asset(
                                      isSelected ? isSelectedIcon : icon,
                                      height: 24,
                                      color: isSelected
                                          ? primaryColor
                                          : Theme.of(context).disabledColor,
                                      width: 24,
                                      fit: BoxFit.cover,
                                    )
                                  : badges.Badge(
                                      showBadge: true,
                                      badgeContent: AppText(
                                        '$value',
                                        size: 8,
                                        weight: FontWeight.w600,
                                        color: white,
                                      ),
                                      badgeStyle: badges.BadgeStyle(
                                        // padding: EdgeInsets.only(bottom: 30, left: 30),
                                        badgeColor: primaryColor,
                                      ),
                                      child: SvgPicture.asset(
                                        isSelected ? isSelectedIcon : icon,
                                        height: 24,
                                        color: isSelected
                                            ? primaryColor
                                            : Theme.of(context).disabledColor,
                                        width: 24,
                                        fit: BoxFit.cover,
                                      ),
                                    );

                              Text('Value from ViewModel: $value');
                            },
                          )),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      label,
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Inter',
                          color: isSelected
                              ? primaryColor
                              : Theme.of(context).disabledColor),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
