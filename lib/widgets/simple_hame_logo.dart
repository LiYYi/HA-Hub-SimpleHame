import 'package:flutter/material.dart';

import '../theme/app_palette_scope.dart';

/// Logo 文案：Simple**Ha**me（Ho → Ha，品牌色强调）
class SimpleHameLogo extends StatelessWidget {
  const SimpleHameLogo({
    super.key,
    this.fontSize = 20,
    /// 深色底图时使用：Simple/me 为浅色字，Ha 仍为品牌色
    this.lightOnDark = false,
  });

  final double fontSize;
  final bool lightOnDark;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final baseStyle = TextStyle(
      fontWeight: FontWeight.w800,
      fontSize: fontSize,
      height: 1.1,
      color: lightOnDark ? p.onImagePrimary : p.textPrimary,
      letterSpacing: -0.5,
      shadows: lightOnDark
          ? [Shadow(blurRadius: 10, color: p.textShadowStrong)]
          : null,
    );
    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: [
          TextSpan(
            text: 'Simple',
            style: TextStyle(color: lightOnDark ? p.onImagePrimary : p.textPrimary),
          ),
          TextSpan(
            text: 'Ha',
            style: TextStyle(color: p.brand),
          ),
          TextSpan(
            text: 'me',
            style: TextStyle(color: lightOnDark ? p.onImagePrimary : p.textPrimary),
          ),
        ],
      ),
    );
  }
}
