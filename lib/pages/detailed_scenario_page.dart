import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../data/detailed_scenario_models.dart';
import '../models/scene_category.dart';
import '../theme/app_palette.dart';
import '../theme/app_palette_scope.dart';
import '../widgets/simple_hame_logo.dart';

/// 第三层：详细场景详情（从场景详情轮播或瀑布流卡片进入）
class DetailedScenarioPage extends StatefulWidget {
  const DetailedScenarioPage({super.key, required this.content});

  final ScenarioDeepContent content;

  @override
  State<DetailedScenarioPage> createState() => _DetailedScenarioPageState();
}

class _DetailedScenarioPageState extends State<DetailedScenarioPage> {
  bool _favorited = false;
  bool _liked = false;
  int? _selectedFloorNodeId;

  late List<FloorPlanNode> _floorNodes;
  late List<FloorPlanEdge> _floorEdges;

  ScenarioDeepContent get _c => widget.content;

  @override
  void initState() {
    super.initState();
    final graph = _buildFloorGraph(_c.devices);
    _floorNodes = graph.nodes;
    _floorEdges = graph.edges;
  }

  @override
  void didUpdateWidget(covariant DetailedScenarioPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.content != widget.content) {
      final graph = _buildFloorGraph(_c.devices);
      _floorNodes = graph.nodes;
      _floorEdges = graph.edges;
      _selectedFloorNodeId = null;
    }
  }

  void _openDeepDetail(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('功能开发中，敬请期待')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Scaffold(
      backgroundColor: p.pageBackground,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _DeepDetailTopBar(onBack: () => Navigator.of(context).pop()),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroBlock(
                    content: _c,
                    favorited: _favorited,
                    liked: _liked,
                    onToggleFavorite: () => setState(() => _favorited = !_favorited),
                    onToggleLike: () => setState(() => _liked = !_liked),
                  ),
                  _SectionTitle(title: '场景介绍'),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      _c.officialIntro,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.65,
                        color: p.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  _SectionTitle(title: '所需设备'),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final w = constraints.maxWidth;
                        final cols = w >= 1000
                            ? 5
                            : w >= 720
                                ? 4
                                : w >= 480
                                    ? 3
                                    : 2;
                        final gap = 12.0;
                        final tileW = (w - gap * (cols - 1)) / cols;
                        return Wrap(
                          spacing: gap,
                          runSpacing: gap,
                          children: [
                            for (final d in _c.devices)
                              SizedBox(
                                width: tileW,
                                child: _DeviceTile(spec: d),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  _SectionTitle(title: '用户这样说'),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final w = constraints.maxWidth;
                        final half = (w - 12) / 2;
                        final useTwoCol = w >= 560;
                        if (!useTwoCol) {
                          return Column(
                            children: [
                              for (final v in _c.userVoices) ...[
                                _UserVoiceCard(text: v),
                                const SizedBox(height: 12),
                              ],
                            ],
                          );
                        }
                        return Wrap(
                          spacing: 12,
                          runSpacing: 12,
                          children: [
                            for (final v in _c.userVoices)
                              SizedBox(
                                width: half,
                                child: _UserVoiceCard(text: v),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),
                  _SectionTitle(title: '设备布局与通信'),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      '点击设备图标查看与其相连的通信路径；未选中时全部节点以正常配色显示。',
                      style: TextStyle(fontSize: 13, color: p.hintCaptionOnPage),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: _FloorPlanBlock(
                      imageUrl: _c.floorPlanImageUrl,
                      nodes: _floorNodes,
                      edges: _floorEdges,
                      selectedId: _selectedFloorNodeId,
                      onSelect: (id) => setState(() {
                        _selectedFloorNodeId = _selectedFloorNodeId == id ? null : id;
                      }),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () => _openDeepDetail(context),
                            style: FilledButton.styleFrom(
                              backgroundColor: p.brand,
                              foregroundColor: p.onBrand,
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('购买设备', style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () => _openDeepDetail(context),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: p.brand,
                              side: BorderSide(color: p.brand, width: 1.5),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Text('部署', style: TextStyle(fontWeight: FontWeight.w700)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DeepDetailTopBar extends StatelessWidget {
  const _DeepDetailTopBar({required this.onBack});

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
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back_rounded),
              color: p.textPrimary,
              tooltip: '返回',
            ),
            const Expanded(
              child: Center(
                child: SimpleHameLogo(fontSize: 20),
              ),
            ),
            _TopAuthButtons(),
          ],
        ),
      ),
    );
  }
}

class _TopAuthButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: p.textSecondary,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          ),
          child: const Text('登录', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        const SizedBox(width: 4),
        FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: p.brand,
            foregroundColor: p.onBrand,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('注册', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: p.textPrimary,
        ),
      ),
    );
  }
}

class _HeroBlock extends StatelessWidget {
  const _HeroBlock({
    required this.content,
    required this.favorited,
    required this.liked,
    required this.onToggleFavorite,
    required this.onToggleLike,
  });

  final ScenarioDeepContent content;
  final bool favorited;
  final bool liked;
  final VoidCallback onToggleFavorite;
  final VoidCallback onToggleLike;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final screenH = MediaQuery.sizeOf(context).height;
          final naturalH = w * 9 / 16;
          final maxH = screenH * 0.34;
          final h = math.min(naturalH, maxH);
          return ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: SizedBox(
              width: w,
              height: h,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    content.heroImageUrl,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    errorBuilder: (context, _, _) => Container(
                      color: p.surfaceMuted,
                      child: Icon(Icons.image_not_supported_outlined, size: 56, color: p.textSecondary),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          p.imageOverlayDetailHeroTop,
                          p.imageOverlayDetailHeroBottom,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 22,
                    bottom: 20,
                    right: 108,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SimpleHameLogo(fontSize: 28, lightOnDark: true),
                        const SizedBox(height: 12),
                        Text(
                          content.scenarioName,
                          style: TextStyle(
                            color: p.onImagePrimary,
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                            height: 1.15,
                            shadows: [Shadow(blurRadius: 14, color: p.textShadowStrong)],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${content.category.label} · 共 ${content.deviceCount} 台设备',
                          style: TextStyle(
                            color: p.onImageSecondary,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 14,
                    bottom: 14,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _HeroIconButton(
                          icon: favorited ? Icons.star_rounded : Icons.star_outline_rounded,
                          color: favorited ? p.favoriteActive : p.onImagePrimary,
                          backdrop: p.heroActionBackdrop,
                          onPressed: onToggleFavorite,
                        ),
                        const SizedBox(width: 12),
                        _HeroIconButton(
                          icon: liked ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          color: liked ? p.likeActive : p.onImagePrimary,
                          backdrop: p.heroActionBackdrop,
                          onPressed: onToggleLike,
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
    );
  }
}

class _HeroIconButton extends StatelessWidget {
  const _HeroIconButton({
    required this.icon,
    required this.color,
    required this.backdrop,
    required this.onPressed,
  });

  final IconData icon;
  final Color color;
  final Color backdrop;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backdrop,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onPressed,
        child: SizedBox(
          width: 52,
          height: 52,
          child: Icon(icon, color: color, size: 30),
        ),
      ),
    );
  }
}

class _DeviceTile extends StatelessWidget {
  const _DeviceTile({required this.spec});

  final DetailedDeviceSpec spec;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: p.surfaceCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: p.borderCard),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(spec.icon, size: 28, color: p.brand),
            const SizedBox(height: 10),
            Text(
              spec.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 14,
                color: p.textPrimary,
                height: 1.25,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              spec.brief,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 12,
                color: p.textSecondary,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserVoiceCard extends StatelessWidget {
  const _UserVoiceCard({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: p.surfaceCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: p.borderCard),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.format_quote_rounded, size: 26, color: p.quoteIconTint),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.55,
                  color: p.textPrimary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloorPlanBlock extends StatelessWidget {
  const _FloorPlanBlock({
    required this.imageUrl,
    required this.nodes,
    required this.edges,
    required this.selectedId,
    required this.onSelect,
  });

  final String imageUrl;
  final List<FloorPlanNode> nodes;
  final List<FloorPlanEdge> edges;
  final int? selectedId;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AspectRatio(
      aspectRatio: 16 / 10,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final w = constraints.maxWidth;
            final h = constraints.maxHeight;
            final neighbors = selectedId != null
                ? () {
                    final s = <int>{};
                    for (final e in edges) {
                      if (e.a == selectedId) s.add(e.b);
                      if (e.b == selectedId) s.add(e.a);
                    }
                    return s;
                  }()
                : <int>{};

            return Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, _, _) => ColoredBox(
                    color: p.surfaceMuted,
                    child: Icon(Icons.apartment, size: 48, color: p.floorPlanPlaceholderIcon),
                  ),
                ),
                Positioned.fill(
                  child: CustomPaint(
                    painter: _FloorEdgePainter(
                      nodes: nodes,
                      edges: edges,
                      selectedId: selectedId,
                      palette: p,
                    ),
                  ),
                ),
                for (final n in nodes)
                  Positioned(
                    left: n.nx * w - 22,
                    top: n.ny * h - 22,
                    child: _FloorDeviceMarker(
                      node: n,
                      selectedId: selectedId,
                      isNeighbor: neighbors.contains(n.id),
                      onTap: () => onSelect(n.id),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _FloorDeviceMarker extends StatelessWidget {
  const _FloorDeviceMarker({
    required this.node,
    required this.selectedId,
    required this.isNeighbor,
    required this.onTap,
  });

  final FloorPlanNode node;
  final int? selectedId;
  final bool isNeighbor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final sel = selectedId == node.id;
    final dimOthers = selectedId != null && !sel && !isNeighbor;

    final bg = sel
        ? p.brand
        : isNeighbor
            ? p.surfaceCard
            : dimOthers
                ? p.floorNodeDimmedBackground
                : p.surfaceCard;
    final fg = sel
        ? p.onBrand
        : dimOthers
            ? p.floorNodeDimmedIcon
            : p.brand;
    final border = isNeighbor && !sel
        ? Border.all(color: p.floorNodeNeighborBorder, width: 2.5)
        : Border.all(color: p.floorNodeDefaultBorder, width: 1.5);

    return Material(
      color: p.semanticTransparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: Ink(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: bg,
            boxShadow: [
              BoxShadow(blurRadius: 8, offset: const Offset(0, 2), color: p.floorDeviceShadow),
            ],
            border: border,
          ),
          child: Icon(node.icon, size: 22, color: fg),
        ),
      ),
    );
  }
}

class _FloorEdgePainter extends CustomPainter {
  _FloorEdgePainter({
    required this.nodes,
    required this.edges,
    required this.selectedId,
    required this.palette,
  });

  final List<FloorPlanNode> nodes;
  final List<FloorPlanEdge> edges;
  final int? selectedId;
  final AppPalette palette;

  Offset _center(FloorPlanNode n, Size size) {
    return Offset(n.nx * size.width, n.ny * size.height);
  }

  FloorPlanNode? _node(int id) {
    for (final x in nodes) {
      if (x.id == id) return x;
    }
    return null;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (final e in edges) {
      final na = _node(e.a);
      final nb = _node(e.b);
      if (na == null || nb == null) continue;
      final p1 = _center(na, size);
      final p2 = _center(nb, size);
      final incident = selectedId != null && (e.a == selectedId || e.b == selectedId);
      final paint = Paint()
        ..color = incident
            ? palette.floorEdgeHighlighted
            : selectedId != null
                ? palette.floorEdgeMutedWhenSelected
                : palette.floorEdgeIdle
        ..strokeWidth = incident ? 2.4 : 1.4
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      _drawDashedLine(canvas, p1, p2, paint);
    }
  }

  void _drawDashedLine(Canvas canvas, Offset a, Offset b, Paint paint) {
    final d = b - a;
    final len = d.distance;
    if (len < 1) return;
    final dir = d / len;
    const dash = 7.0;
    const gap = 5.0;
    var t = 0.0;
    while (t < len) {
      final end = math.min(t + dash, len);
      canvas.drawLine(a + dir * t, a + dir * end, paint);
      t += dash + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _FloorEdgePainter oldDelegate) {
    return oldDelegate.selectedId != selectedId ||
        oldDelegate.edges != edges ||
        oldDelegate.nodes != nodes ||
        oldDelegate.palette != palette;
  }
}

/// 由所需设备列表生成户型图上的节点与边（星型 + 少量横向互联）
({List<FloorPlanNode> nodes, List<FloorPlanEdge> edges}) _buildFloorGraph(List<DetailedDeviceSpec> devices) {
  final n = math.min(math.max(devices.length, 3), 7);
  final nodes = <FloorPlanNode>[];
  nodes.add(FloorPlanNode(id: 0, icon: devices[0].icon, nx: 0.5, ny: 0.48));
  for (var i = 1; i < n; i++) {
    final angle = 2 * math.pi * (i - 1) / (n - 1) - math.pi / 2;
    nodes.add(
      FloorPlanNode(
        id: i,
        icon: devices[i].icon,
        nx: 0.5 + 0.36 * math.cos(angle),
        ny: 0.48 + 0.32 * math.sin(angle),
      ),
    );
  }
  final edges = <FloorPlanEdge>[];
  for (var i = 1; i < n; i++) {
    edges.add(FloorPlanEdge(0, i));
  }
  if (n > 3) {
    edges.add(FloorPlanEdge(1, 2));
  }
  if (n > 5) {
    edges.add(FloorPlanEdge(2, 3));
  }
  return (nodes: nodes, edges: edges);
}
