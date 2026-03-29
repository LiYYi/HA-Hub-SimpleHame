import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../data/detailed_scenario_content.dart';
import '../data/scene_detail_content.dart';
import '../models/scene_category.dart';
import '../theme/app_palette_scope.dart';
import 'detailed_scenario_page.dart';

/// 场景详情：顶栏四场景切换、轮播、按内容高度的瀑布流与触底加载更多
class SceneDetailPage extends StatefulWidget {
  const SceneDetailPage({super.key, required this.category});

  final SceneCategory category;

  @override
  State<SceneDetailPage> createState() => _SceneDetailPageState();
}

class _SceneDetailPageState extends State<SceneDetailPage> {
  static const int _initialRows = 4;
  static const int _cols = 3;
  static const int _initialCount = _initialRows * _cols; // 12
  static const int _loadMoreRows = 3;
  static const int _loadMoreCount = _loadMoreRows * _cols; // 9

  late SceneCategory _category;
  late List<PrefabDetailScenario> _items;
  late PageController _carouselController;
  final ScrollController _scrollController = ScrollController();

  int _carouselIndex = 0;
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    _category = widget.category;
    _items = _initialItems();
    _carouselController = PageController(viewportFraction: 1);
    _scrollController.addListener(_onScroll);
  }

  List<PrefabDetailScenario> _initialItems() {
    return List<PrefabDetailScenario>.generate(
      _initialCount,
      (i) => kPrefabDetailScenarios[i % kPrefabDetailScenarios.length],
    );
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _carouselController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_loadingMore) return;
    final pos = _scrollController.position;
    if (!pos.hasPixels || !pos.hasViewportDimension) return;
    if (pos.pixels >= pos.maxScrollExtent - 280) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_loadingMore || !mounted) return;
    setState(() => _loadingMore = true);
    await Future<void>.delayed(const Duration(milliseconds: 650));
    if (!mounted) return;
    setState(() {
      final start = _items.length;
      for (var i = 0; i < _loadMoreCount; i++) {
        _items.add(kPrefabDetailScenarios[(start + i) % kPrefabDetailScenarios.length]);
      }
      _loadingMore = false;
    });
  }

  void _switchCategory(SceneCategory c) {
    if (c == _category) return;
    setState(() {
      _category = c;
      _items = _initialItems();
      _carouselIndex = 0;
    });
    _carouselController.jumpToPage(0);
    _scrollController.jumpTo(0);
  }

  int _crossAxisCountForWidth(double w) {
    if (w >= 900) return 3;
    if (w >= 520) return 2;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final slides = kSceneCarouselByCategory[_category]!;

    return Scaffold(
      backgroundColor: p.pageBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SceneDetailTopBar(
            current: _category,
            onSelect: _switchCategory,
            onBack: () => Navigator.of(context).pop(),
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = _crossAxisCountForWidth(constraints.maxWidth);
                return CustomScrollView(
                  controller: _scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: _CarouselSection(
                        slides: slides,
                        controller: _carouselController,
                        currentIndex: _carouselIndex,
                        onPageChanged: (i) => setState(() => _carouselIndex = i),
                        onOpenSlide: (slideIndex) {
                          final content = scenarioDeepFromCarousel(_category, slideIndex);
                          Navigator.of(context).push<void>(
                            MaterialPageRoute<void>(
                              builder: (context) => DetailedScenarioPage(content: content),
                            ),
                          );
                        },
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                      sliver: SliverMasonryGrid.count(
                        crossAxisCount: crossAxisCount,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childCount: _items.length,
                        itemBuilder: (context, index) {
                          return _DetailScenarioCard(
                            scenario: _items[index],
                            prefabIndex: index % kPrefabDetailScenarios.length,
                            category: _category,
                          );
                        },
                      ),
                    ),
                    if (_loadingMore)
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 28),
                          child: Center(
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: p.brand,
                              ),
                            ),
                          ),
                        ),
                      ),
                    const SliverToBoxAdapter(child: SizedBox(height: 32)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SceneDetailTopBar extends StatelessWidget {
  const _SceneDetailTopBar({
    required this.current,
    required this.onSelect,
    required this.onBack,
  });

  final SceneCategory current;
  final ValueChanged<SceneCategory> onSelect;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: p.surfaceCard,
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: p.borderHairline)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 640;
            return Row(
              children: [
                IconButton(
                  onPressed: onBack,
                  icon: const Icon(Icons.arrow_back_rounded),
                  color: p.textPrimary,
                  tooltip: '返回',
                ),
                Expanded(
                  child: narrow
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              for (final c in SceneCategory.values) ...[
                                _SceneTab(
                                  label: c.label,
                                  selected: c == current,
                                  onTap: () => onSelect(c),
                                ),
                                const SizedBox(width: 4),
                              ],
                            ],
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (final c in SceneCategory.values) ...[
                              _SceneTab(
                                label: c.label,
                                selected: c == current,
                                onTap: () => onSelect(c),
                              ),
                              const SizedBox(width: 8),
                            ],
                          ],
                        ),
                ),
                const SizedBox(width: 48),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SceneTab extends StatelessWidget {
  const _SceneTab({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        foregroundColor: selected ? p.brand : p.textPrimary,
        backgroundColor: selected ? p.brandTabHighlightFill : null,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
          fontSize: 15,
        ),
      ),
    );
  }
}

class _CarouselSection extends StatelessWidget {
  const _CarouselSection({
    required this.slides,
    required this.controller,
    required this.currentIndex,
    required this.onPageChanged,
    required this.onOpenSlide,
  });

  final List<SceneCarouselSlide> slides;
  final PageController controller;
  final int currentIndex;
  final ValueChanged<int> onPageChanged;
  final ValueChanged<int> onOpenSlide;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 7,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: PageView.builder(
                controller: controller,
                itemCount: slides.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, i) {
                  final s = slides[i];
                  return Material(
                    color: p.semanticTransparent,
                    child: InkWell(
                      onTap: () => onOpenSlide(i),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            s.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, _, _) => Container(
                              color: p.surfaceMuted,
                              child: Icon(Icons.image_not_supported_outlined, size: 48, color: p.textSecondary),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  p.imageOverlayCarouselTop,
                                  p.imageOverlayCarouselBottom,
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 20,
                            right: 20,
                            bottom: 20,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  s.title,
                                  style: TextStyle(
                                    color: p.onImagePrimary,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                    shadows: [Shadow(blurRadius: 12, color: p.textShadowStrong)],
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  s.subtitle,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: p.onImageSecondary,
                                    fontSize: 14,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(slides.length, (i) {
              final active = i == currentIndex;
              return AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: active ? 22 : 8,
                height: 8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: active ? p.brand : p.carouselDotInactive,
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

class _DetailScenarioCard extends StatelessWidget {
  const _DetailScenarioCard({
    required this.scenario,
    required this.prefabIndex,
    required this.category,
  });

  final PrefabDetailScenario scenario;
  final int prefabIndex;
  final SceneCategory category;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: p.surfaceCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: p.borderCard),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          final content = scenarioDeepFromPrefab(prefabIndex, category);
          Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (context) => DetailedScenarioPage(content: content),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  scenario.imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  errorBuilder: (context, _, _) => Container(
                    color: p.surfaceMuted,
                    child: Icon(Icons.devices_other_outlined, size: 40, color: p.brand),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    scenario.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: p.textPrimary,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 48,
                    child: _DeviceIconRow(icons: scenario.deviceIcons),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    scenario.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: p.textSecondary,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ≤4 个设备：均分整行宽度；>4 个：前 3 格均分 + 「+余下数量」
class _DeviceIconRow extends StatelessWidget {
  const _DeviceIconRow({required this.icons});

  final List<IconData> icons;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    if (icons.isEmpty) return const SizedBox.shrink();

    if (icons.length <= 4) {
      return LayoutBuilder(
        builder: (context, c) {
          final n = icons.length;
          final slotW = c.maxWidth / n;
          final iconSize = math.min(40.0, math.max(28.0, slotW * 0.58));
          return Row(
            children: [
              for (final ic in icons)
                Expanded(
                  child: Center(
                    child: Icon(ic, size: iconSize, color: p.brand),
                  ),
                ),
            ],
          );
        },
      );
    }

    final rest = icons.length - 3;
    return LayoutBuilder(
      builder: (context, c) {
        final slotW = c.maxWidth / 4;
        final iconSize = math.min(36.0, math.max(26.0, slotW * 0.55));
        return Row(
          children: [
            Expanded(child: Center(child: Icon(icons[0], size: iconSize, color: p.brand))),
            Expanded(child: Center(child: Icon(icons[1], size: iconSize, color: p.brand))),
            Expanded(child: Center(child: Icon(icons[2], size: iconSize, color: p.brand))),
            Expanded(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: p.surfaceMuted,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '+$rest',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: p.brand,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
