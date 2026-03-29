import 'package:flutter/material.dart';

import '../models/scene_category.dart';
import '../theme/app_palette_scope.dart';
import '../widgets/simple_hame_logo.dart';
import 'scene_detail_page.dart';

class HaHubHomePage extends StatelessWidget {
  const HaHubHomePage({super.key});

  static const List<String> _navItems = ['案例', '场景', '设备', '指南'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _TopBar(navItems: _navItems),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _HeroSection(),
                  _SceneCardsSection(),
                  _FooterSection(navItems: _navItems),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.navItems});

  final List<String> navItems;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Material(
      color: p.surfaceCard,
      elevation: 0,
      shadowColor: p.topBarShadow,
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: p.borderHairline),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final narrow = constraints.maxWidth < 720;
            if (narrow) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const SimpleHameLogo(fontSize: 18),
                      const Spacer(),
                      _AuthButtons(compact: true),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        for (final item in navItems) ...[
                          _NavLink(label: item),
                          const SizedBox(width: 20),
                        ],
                      ],
                    ),
                  ),
                ],
              );
            }
            return Row(
              children: [
                const SimpleHameLogo(fontSize: 20),
                const SizedBox(width: 28),
                for (final item in navItems) ...[
                  _NavLink(label: item),
                  const SizedBox(width: 28),
                ],
                const Spacer(),
                _AuthButtons(compact: false),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AuthButtons extends StatelessWidget {
  const _AuthButtons({required this.compact});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final gap = compact ? 8.0 : 10.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: p.textSecondary,
            padding: EdgeInsets.symmetric(horizontal: compact ? 12 : 16, vertical: 10),
          ),
          child: const Text('登录', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
        SizedBox(width: gap),
        FilledButton(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: p.brand,
            foregroundColor: p.onBrand,
            padding: EdgeInsets.symmetric(horizontal: compact ? 16 : 22, vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('注册', style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class _NavLink extends StatelessWidget {
  const _NavLink({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: p.textPrimary,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
    );
  }
}

class _HeroSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return AspectRatio(
      aspectRatio: 21 / 9,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(0)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1558002038-1055907df827?auto=format&fit=crop&w=1920&q=80',
              fit: BoxFit.cover,
              errorBuilder: (context, _, _) => Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      p.heroFallbackGradient1,
                      p.heroFallbackGradient2,
                      p.heroFallbackGradient3,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(Icons.hub_outlined, size: 80, color: p.iconHubFallback),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    p.imageOverlayHeroTop,
                    p.imageOverlayHeroBottom,
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 48,
                        height: 1.05,
                        letterSpacing: -1,
                        shadows: [
                          Shadow(blurRadius: 24, color: p.textShadowStrong),
                        ],
                      ),
                      children: [
                        TextSpan(text: 'Simple', style: TextStyle(color: p.onImagePrimary)),
                        TextSpan(text: 'Ha', style: TextStyle(color: p.brand)),
                        TextSpan(text: 'me', style: TextStyle(color: p.onImagePrimary)),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '智能家居互联 · 未来生活',
                    style: TextStyle(
                      color: p.onImageSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1.2,
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

class _SceneCardsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    final cards = [
      _SceneData(
        '安全',
        '门锁、摄像与告警联动',
        Icons.shield_outlined,
        'https://images.unsplash.com/photo-1563013544-824ae1b704d3?auto=format&fit=crop&w=800&q=80',
        SceneCategory.security,
      ),
      _SceneData(
        '健康',
        '空气、睡眠与环境关怀',
        Icons.favorite_outline,
        'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=800&q=80',
        SceneCategory.health,
      ),
      _SceneData(
        '舒适',
        '灯光、温控与场景一键切换',
        Icons.weekend_outlined,
        'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&w=800&q=80',
        SceneCategory.comfort,
      ),
      _SceneData(
        '节能',
        '用电洞察与智能调度',
        Icons.energy_savings_leaf_outlined,
        'https://images.unsplash.com/photo-1497435334941-636c87e06b4b?auto=format&fit=crop&w=800&q=80',
        SceneCategory.energy,
      ),
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '场景入口',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: p.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '从四大场景开始，搭建你的 SimpleHome',
            style: TextStyle(fontSize: 15, color: p.textSecondary),
          ),
          const SizedBox(height: 28),
          LayoutBuilder(
            builder: (context, constraints) {
              final w = constraints.maxWidth;
              if (w < 600) {
                return Column(
                  children: [
                    for (final c in cards) ...[
                      _SceneCard(data: c),
                      const SizedBox(height: 16),
                    ],
                  ],
                );
              }
              if (w < 1000) {
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: cards
                      .map((c) => SizedBox(width: (w - 24 - 16) / 2, child: _SceneCard(data: c)))
                      .toList(),
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var i = 0; i < cards.length; i++) ...[
                    Expanded(child: _SceneCard(data: cards[i])),
                    if (i < cards.length - 1) const SizedBox(width: 16),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SceneData {
  _SceneData(this.title, this.subtitle, this.icon, this.imageUrl, this.category);

  final String title;
  final String subtitle;
  final IconData icon;
  final String imageUrl;
  final SceneCategory category;
}

class _SceneCard extends StatelessWidget {
  const _SceneCard({required this.data});

  final _SceneData data;

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
          Navigator.of(context).push<void>(
            MaterialPageRoute<void>(
              builder: (context) => SceneDetailPage(category: data.category),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 10,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    data.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, _, _) => Container(
                      color: p.surfaceMuted,
                      child: Icon(data.icon, size: 48, color: p.iconBrandMuted),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          p.semanticTransparent,
                          p.imageOverlayCardBottom,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(data.icon, size: 20, color: p.brand),
                      const SizedBox(width: 8),
                      Text(
                        data.title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: p.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    data.subtitle,
                    style: TextStyle(fontSize: 13, color: p.textSecondary, height: 1.35),
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

class _FooterSection extends StatelessWidget {
  const _FooterSection({required this.navItems});

  final List<String> navItems;

  @override
  Widget build(BuildContext context) {
    final p = context.palette;
    return Container(
      color: p.footerSurface,
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SimpleHameLogo(fontSize: 22),
          const SizedBox(height: 8),
          Text(
            'HA-hub SimpleHome',
            style: TextStyle(fontSize: 13, color: p.textSecondary, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 28),
          Text(
            '导航',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: p.textSecondary,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final item in navItems)
                Padding(
                  padding: const EdgeInsets.only(right: 16, bottom: 4),
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: p.textPrimary,
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(item, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),
          Divider(height: 1, color: p.divider),
          const SizedBox(height: 20),
          Wrap(
            spacing: 16,
            runSpacing: 12,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: p.textSecondary),
                child: const Text('登录', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(foregroundColor: p.brand),
                child: const Text('注册', style: TextStyle(fontWeight: FontWeight.w600)),
              ),
              Text(
                '© ${DateTime.now().year} HA-hub · SimpleHome',
                style: TextStyle(fontSize: 12, color: p.footerCopyrightText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
