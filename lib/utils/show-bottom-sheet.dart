import 'package:flutter/material.dart';
import 'package:taskitly/constants/reuseables.dart';

import '../UI/widgets/bottomSheet.dart';

Future<dynamic> showAppBottomSheet(Widget child) async {
  var data = await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: navigationService.navigatorKey.currentState!.context,
    isScrollControlled: true,
    isDismissible: false,
    builder: (_) => BottomSheetScreen(child: child),
  );

  return data;
}
