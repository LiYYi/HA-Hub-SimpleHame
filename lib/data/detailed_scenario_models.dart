import 'package:flutter/material.dart';

import '../models/scene_category.dart';

/// 所需设备卡片
class DetailedDeviceSpec {
  const DetailedDeviceSpec({
    required this.icon,
    required this.name,
    required this.brief,
  });

  final IconData icon;
  final String name;
  final String brief;
}

/// 户型图上的设备节点（坐标为相对宽高 0~1）
class FloorPlanNode {
  const FloorPlanNode({
    required this.id,
    required this.icon,
    required this.nx,
    required this.ny,
  });

  final int id;
  final IconData icon;
  final double nx;
  final double ny;
}

/// 设备之间的通信链路
class FloorPlanEdge {
  const FloorPlanEdge(this.a, this.b);

  final int a;
  final int b;
}

/// 详细场景详情页完整内容
class ScenarioDeepContent {
  const ScenarioDeepContent({
    required this.scenarioName,
    required this.category,
    required this.heroImageUrl,
    required this.officialIntro,
    required this.devices,
    required this.userVoices,
    required this.floorPlanImageUrl,
  });

  final String scenarioName;
  final SceneCategory category;
  final String heroImageUrl;
  final String officialIntro;
  final List<DetailedDeviceSpec> devices;
  final List<String> userVoices;
  final String floorPlanImageUrl;

  int get deviceCount => devices.length;
}
