import 'package:flutter/material.dart';
import 'package:taskitly/constants/palette.dart';
import 'package:taskitly/utils/widget_extensions.dart';
import '../../constants/reuseables.dart';

class AppBars extends StatelessWidget implements PreferredSizeWidget {
  final bool hasLead;
  final Widget? title;
  final Widget? leading;
  final String? text;
  final bool? hasNotification;
  final bool? automaticallyImplyLeading;
  final Widget? flexibleSpace;
  final double? elevation;
  final Color? backgroundColor;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;
  const AppBars(
      {Key? key,
      this.hasLead = true,
      this.title,
      this.actions,
      this.flexibleSpace,
      this.bottom,
      this.text,
      this.hasNotification,
      this.leading,
      this.elevation,
      this.backgroundColor,
      this.automaticallyImplyLeading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading ?? false,
      leading: Navigator.of(context).canPop()
          ? (hasLead == false ? null : leading ?? const BackButtons())
          : null,
      title: title ?? (text != null ? Text("$text") : null),
      flexibleSpace: flexibleSpace,
      backgroundColor: backgroundColor,
      bottom: bottom,
      centerTitle: true,
      elevation: elevation,
    );
  }

  //:(hasLead==false? null:leading?? const BackButtons())

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class BackButtons extends StatelessWidget {
  final VoidCallback? onTap;
  const BackButtons({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? navigationService.goBack,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: 10.0.padL,
          width: 30,
          height: 30,
          padding: 7.0.padA,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey.shade400.withOpacity(0.6)),
          child: const Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 16,
          ),
        ),
      ),
    );
  }
}

class ForwardButtons extends StatelessWidget {
  final VoidCallback? onTap;
  const ForwardButtons({Key? key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ?? navigationService.goBack,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          margin: 10.0.padL,
          width: 30,
          height: 30,
          padding: 7.0.padA,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: secondaryColor),
          child: const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
          ),
        ),
      ),
    );
  }
}
