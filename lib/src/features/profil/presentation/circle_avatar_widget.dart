import 'package:cash_track/src/config/config_colors.dart';
import 'package:flutter/material.dart';

class CircleAvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String defaultImageUrl = 'https://via.placeholder.com/150';
  final double radius;
  final Color backgroundColor;
  final Color iconColor;
  final double iconSize;

  const CircleAvatarWidget({
    super.key,
    this.imageUrl,
    this.radius = 50,
    this.backgroundColor = Colors.grey,
    this.iconColor = primeryColor,
    this.iconSize = 70,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: backgroundColor,
      backgroundImage: imageUrl != null ? NetworkImage(imageUrl!) : NetworkImage(defaultImageUrl),
      onBackgroundImageError: (_, __) {},
      child: imageUrl == null
          ? Icon(
              Icons.person,
              size: iconSize,
              color: iconColor,
            )
          : null,
    );
  }
}
