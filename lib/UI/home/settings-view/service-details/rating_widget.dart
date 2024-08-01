import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final double starSize;
  final Color activeColor;
  final Color inactiveColor;

  const RatingStars({
    super.key,
    required this.rating,
    this.starSize = 24.0,
    this.activeColor = Colors.amber,
    this.inactiveColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        5,
        (index) => Icon(
          index < rating.floor()
              ? Icons.star
              : index < rating ? Icons.star_half : Icons.star_border,
          color: index < rating.floor()
              ? activeColor
              : index < rating
                  ? activeColor
                  : inactiveColor,
          size: starSize,
        ),
      ),
    );
  }
}