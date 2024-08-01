import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

SvgPicture buildSvgPicture(
        {required String image, required double size, Color? color}) =>
    SvgPicture.asset(
      image,
      height: size,
      width: size,
      color: color,
    );
