import 'dart:convert';

import 'package:flutter/services.dart';

/// 自 [ItemColorSetting.json] 加载的全局颜色表（修改 JSON 后热重启即可生效）
class AppPalette {
  const AppPalette({
    required this.brand,
    required this.textPrimary,
    required this.textSecondary,
    required this.surfaceCard,
    required this.surfaceMuted,
    required this.pageBackground,
    required this.themeSurface,
    required this.borderHairline,
    required this.borderCard,
    required this.divider,
    required this.footerSurface,
    required this.heroFallbackGradient1,
    required this.heroFallbackGradient2,
    required this.heroFallbackGradient3,
    required this.iconHubFallback,
    required this.imageOverlayHeroTop,
    required this.imageOverlayHeroBottom,
    required this.textShadowStrong,
    required this.onImagePrimary,
    required this.onImageSecondary,
    required this.imageOverlayCardBottom,
    required this.iconBrandMuted,
    required this.brandTabHighlightFill,
    required this.carouselDotInactive,
    required this.imageOverlayCarouselTop,
    required this.imageOverlayCarouselBottom,
    required this.imageOverlayDetailHeroTop,
    required this.imageOverlayDetailHeroBottom,
    required this.favoriteActive,
    required this.likeActive,
    required this.heroActionBackdrop,
    required this.quoteIconTint,
    required this.floorPlanPlaceholderIcon,
    required this.floorNodeNeighborBorder,
    required this.floorNodeDimmedBackground,
    required this.floorNodeDimmedIcon,
    required this.floorNodeDefaultBorder,
    required this.floorDeviceShadow,
    required this.floorEdgeHighlighted,
    required this.floorEdgeMutedWhenSelected,
    required this.floorEdgeIdle,
    required this.topBarShadow,
    required this.onBrand,
    required this.semanticTransparent,
    required this.footerCopyrightText,
    required this.hintCaptionOnPage,
  });

  final Color brand;
  final Color textPrimary;
  final Color textSecondary;
  final Color surfaceCard;
  final Color surfaceMuted;
  final Color pageBackground;
  final Color themeSurface;
  final Color borderHairline;
  final Color borderCard;
  final Color divider;
  final Color footerSurface;
  final Color heroFallbackGradient1;
  final Color heroFallbackGradient2;
  final Color heroFallbackGradient3;
  final Color iconHubFallback;
  final Color imageOverlayHeroTop;
  final Color imageOverlayHeroBottom;
  final Color textShadowStrong;
  final Color onImagePrimary;
  final Color onImageSecondary;
  final Color imageOverlayCardBottom;
  final Color iconBrandMuted;
  final Color brandTabHighlightFill;
  final Color carouselDotInactive;
  final Color imageOverlayCarouselTop;
  final Color imageOverlayCarouselBottom;
  final Color imageOverlayDetailHeroTop;
  final Color imageOverlayDetailHeroBottom;
  final Color favoriteActive;
  final Color likeActive;
  final Color heroActionBackdrop;
  final Color quoteIconTint;
  final Color floorPlanPlaceholderIcon;
  final Color floorNodeNeighborBorder;
  final Color floorNodeDimmedBackground;
  final Color floorNodeDimmedIcon;
  final Color floorNodeDefaultBorder;
  final Color floorDeviceShadow;
  final Color floorEdgeHighlighted;
  final Color floorEdgeMutedWhenSelected;
  final Color floorEdgeIdle;
  final Color topBarShadow;
  final Color onBrand;
  final Color semanticTransparent;
  final Color footerCopyrightText;
  final Color hintCaptionOnPage;

  static const String assetPath = 'assets/ItemColorSetting.json';

  static Future<AppPalette> load() async {
    try {
      final raw = await rootBundle.loadString(assetPath);
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return AppPalette.fromJson(map);
    } catch (_) {
      return fallback;
    }
  }

  /// 与 JSON 默认一致，供测试或资源加载失败时使用
  static final AppPalette fallback = AppPalette.fromJson(
    jsonDecode(_kEmbeddedDefaults) as Map<String, dynamic>,
  );

  factory AppPalette.fromJson(Map<String, dynamic> json) {
    Color c(String key) => _parseHex(json[key], key);
    return AppPalette(
      brand: c('brand'),
      textPrimary: c('textPrimary'),
      textSecondary: c('textSecondary'),
      surfaceCard: c('surfaceCard'),
      surfaceMuted: c('surfaceMuted'),
      pageBackground: c('pageBackground'),
      themeSurface: c('themeSurface'),
      borderHairline: c('borderHairline'),
      borderCard: c('borderCard'),
      divider: c('divider'),
      footerSurface: c('footerSurface'),
      heroFallbackGradient1: c('heroFallbackGradient1'),
      heroFallbackGradient2: c('heroFallbackGradient2'),
      heroFallbackGradient3: c('heroFallbackGradient3'),
      iconHubFallback: c('iconHubFallback'),
      imageOverlayHeroTop: c('imageOverlayHeroTop'),
      imageOverlayHeroBottom: c('imageOverlayHeroBottom'),
      textShadowStrong: c('textShadowStrong'),
      onImagePrimary: c('onImagePrimary'),
      onImageSecondary: c('onImageSecondary'),
      imageOverlayCardBottom: c('imageOverlayCardBottom'),
      iconBrandMuted: c('iconBrandMuted'),
      brandTabHighlightFill: c('brandTabHighlightFill'),
      carouselDotInactive: c('carouselDotInactive'),
      imageOverlayCarouselTop: c('imageOverlayCarouselTop'),
      imageOverlayCarouselBottom: c('imageOverlayCarouselBottom'),
      imageOverlayDetailHeroTop: c('imageOverlayDetailHeroTop'),
      imageOverlayDetailHeroBottom: c('imageOverlayDetailHeroBottom'),
      favoriteActive: c('favoriteActive'),
      likeActive: c('likeActive'),
      heroActionBackdrop: c('heroActionBackdrop'),
      quoteIconTint: c('quoteIconTint'),
      floorPlanPlaceholderIcon: c('floorPlanPlaceholderIcon'),
      floorNodeNeighborBorder: c('floorNodeNeighborBorder'),
      floorNodeDimmedBackground: c('floorNodeDimmedBackground'),
      floorNodeDimmedIcon: c('floorNodeDimmedIcon'),
      floorNodeDefaultBorder: c('floorNodeDefaultBorder'),
      floorDeviceShadow: c('floorDeviceShadow'),
      floorEdgeHighlighted: c('floorEdgeHighlighted'),
      floorEdgeMutedWhenSelected: c('floorEdgeMutedWhenSelected'),
      floorEdgeIdle: c('floorEdgeIdle'),
      topBarShadow: c('topBarShadow'),
      onBrand: c('onBrand'),
      semanticTransparent: c('semanticTransparent'),
      footerCopyrightText: c('footerCopyrightText'),
      hintCaptionOnPage: c('hintCaptionOnPage'),
    );
  }

  static Color _parseHex(dynamic value, String key) {
    if (value is! String) {
      throw FormatException('ItemColorSetting: "$key" must be a hex string');
    }
    var s = value.trim();
    if (s.isEmpty) throw FormatException('ItemColorSetting: "$key" is empty');
    if (s.startsWith('#')) s = s.substring(1);
    if (s.length == 6) {
      return Color(int.parse('FF$s', radix: 16));
    }
    if (s.length == 8) {
      return Color(int.parse(s, radix: 16));
    }
    throw FormatException('ItemColorSetting: "$key" invalid hex "$value"');
  }
}

/// 与 [assets/ItemColorSetting.json] 保持同步（资源失败时回退）
const String _kEmbeddedDefaults = '''
{
  "brand": "#4C3073",
  "textPrimary": "#2D2D32",
  "textSecondary": "#6B6B73",
  "surfaceCard": "#FFFFFF",
  "surfaceMuted": "#E8E8ED",
  "pageBackground": "#F2F2F5",
  "themeSurface": "#F2F2F5",
  "borderHairline": "#E0E0E6",
  "borderCard": "#E4E4EA",
  "divider": "#D8D8E0",
  "footerSurface": "#EAEAEF",
  "heroFallbackGradient1": "#3D2A5C",
  "heroFallbackGradient2": "#4C3073",
  "heroFallbackGradient3": "#6B5B8C",
  "iconHubFallback": "#3DFFFFFF",
  "imageOverlayHeroTop": "#59000000",
  "imageOverlayHeroBottom": "#8C000000",
  "textShadowStrong": "#73000000",
  "onImagePrimary": "#FFFFFF",
  "onImageSecondary": "#EBFFFFFF",
  "imageOverlayCardBottom": "#40000000",
  "iconBrandMuted": "#724C3073",
  "brandTabHighlightFill": "#1A4C3073",
  "carouselDotInactive": "#596B6B73",
  "imageOverlayCarouselTop": "#26000000",
  "imageOverlayCarouselBottom": "#A6000000",
  "imageOverlayDetailHeroTop": "#33000000",
  "imageOverlayDetailHeroBottom": "#8C000000",
  "favoriteActive": "#FFD54F",
  "likeActive": "#F48FB1",
  "heroActionBackdrop": "#59000000",
  "quoteIconTint": "#8C4C3073",
  "floorPlanPlaceholderIcon": "#724C3073",
  "floorNodeNeighborBorder": "#4C3073",
  "floorNodeDimmedBackground": "#8CFFFFFF",
  "floorNodeDimmedIcon": "#806B6B73",
  "floorNodeDefaultBorder": "#D9FFFFFF",
  "floorDeviceShadow": "#42000000",
  "floorEdgeHighlighted": "#EB4C3073",
  "floorEdgeMutedWhenSelected": "#38FFFFFF",
  "floorEdgeIdle": "#724C3073",
  "topBarShadow": "#1F000000",
  "onBrand": "#FFFFFF",
  "semanticTransparent": "#00000000",
  "footerCopyrightText": "#D96B6B73",
  "hintCaptionOnPage": "#E66B6B73"
}
''';
