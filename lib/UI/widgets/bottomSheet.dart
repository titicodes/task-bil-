import 'package:flutter/material.dart';
import 'package:taskitly/utils/widget_extensions.dart';

class BottomSheetScreen extends StatelessWidget {
  final Widget child;
  const BottomSheetScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Container(
                        width: width(context),
                        alignment: Alignment.bottomCenter,
                        padding: 16.0.padA,
                        color: Colors.white,
                        child: IntrinsicHeight(child: child))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
