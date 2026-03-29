import 'package:flutter/material.dart';

import 'app_palette.dart';

class AppPaletteScope extends InheritedWidget {
  const AppPaletteScope({
    super.key,
    required this.palette,
    required super.child,
  });

  final AppPalette palette;

  static AppPalette of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppPaletteScope>();
    assert(scope != null, 'AppPaletteScope not found above $context');
    return scope!.palette;
  }

  @override
  bool updateShouldNotify(covariant AppPaletteScope oldWidget) =>
      palette != oldWidget.palette;
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette => AppPaletteScope.of(this);
}
