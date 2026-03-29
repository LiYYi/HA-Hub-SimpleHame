import 'package:flutter/material.dart';

import '../models/scene_category.dart';

/// 轮播单页
class SceneCarouselSlide {
  const SceneCarouselSlide({
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  final String title;
  final String subtitle;
  final String imageUrl;
}

/// 瀑布流详细场景（预制 12 条，加载更多时循环使用）
class PrefabDetailScenario {
  const PrefabDetailScenario({
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.deviceIcons,
  });

  final String name;
  final String description;
  final String imageUrl;
  final List<IconData> deviceIcons;
}

/// 各场景主题轮播（每类 3 条）
final Map<SceneCategory, List<SceneCarouselSlide>> kSceneCarouselByCategory = {
  SceneCategory.security: const [
    SceneCarouselSlide(
      title: '门锁接近拍照',
      subtitle: '有人在门口停留时自动抓拍并推送手机，留存访客影像。',
      imageUrl:
          'https://images.unsplash.com/photo-1558002038-1055907df827?auto=format&fit=crop&w=1200&q=80',
    ),
    SceneCarouselSlide(
      title: '燃气泄漏自动关阀',
      subtitle: '探测器报警后联动电动阀门切断气源，并同步通知家人与物业。',
      imageUrl:
          'https://images.unsplash.com/photo-1581578731548-c64695cc6952?auto=format&fit=crop&w=1200&q=80',
    ),
    SceneCarouselSlide(
      title: '异常开锁提醒',
      subtitle: '非授权时段开锁、多次试错立即告警，可联动摄像头复核现场。',
      imageUrl:
          'https://images.unsplash.com/photo-1563013544-824ae1b704d3?auto=format&fit=crop&w=1200&q=80',
    ),
  ],
  SceneCategory.health: const [
    SceneCarouselSlide(
      title: '空气质量联动新风',
      subtitle: 'PM2.5、CO₂ 超标时自动加大新风，睡眠时段切换静音档位。',
      imageUrl:
          'https://images.unsplash.com/photo-1540555700478-4be289fbecef?auto=format&fit=crop&w=1200&q=80',
    ),
    SceneCarouselSlide(
      title: '睡眠环境柔光',
      subtitle: '入睡后渐暗灯光、拉上窗帘，起床前模拟日出 gently 唤醒。',
      imageUrl:
          'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=1200&q=80',
    ),
    SceneCarouselSlide(
      title: '湿度与净化协同',
      subtitle: '干燥加湿、潮湿除湿，与空气净化器联动保持恒定舒适区间。',
      imageUrl:
          'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1200&q=80',
    ),
  ],
  SceneCategory.comfort: const [
    SceneCarouselSlide(
      title: '回家一键场景',
      subtitle: '开门即亮灯、开空调至偏好温度，背景音乐轻启欢迎回家。',
      imageUrl:
          'https://images.unsplash.com/photo-1586023492125-27b2c045efd7?auto=format&fit=crop&w=1200&q=80',
    ),
    SceneCarouselSlide(
      title: '观影模式',
      subtitle: '灯光渐暗、窗帘闭合、电视与音响同步切换，一键进入影院感。',
      imageUrl:
          'https://images.unsplash.com/photo-1593784991095-a205069470b6?auto=format&fit=crop&w=1200&q=80',
    ),
    SceneCarouselSlide(
      title: '起夜柔光路径',
      subtitle: '人体感应点亮低位灯带，避免强光刺眼，结束后自动熄灭。',
      imageUrl:
          'https://images.unsplash.com/photo-1505693416388-ac5ce068fe85?auto=format&fit=crop&w=1200&q=80',
    ),
  ],
  SceneCategory.energy: const [
    SceneCarouselSlide(
      title: '离家节能模式',
      subtitle: '全屋非必要设备待机，空调与照明按策略降载，降低待机能耗。',
      imageUrl:
          'https://images.unsplash.com/photo-1497435334941-636c87e06b4b?auto=format&fit=crop&w=1200&q=80',
    ),
    SceneCarouselSlide(
      title: '峰谷电智能调度',
      subtitle: '热水器、充电桩等在谷电时段自动运行，账单可视化对比。',
      imageUrl:
          'https://images.unsplash.com/photo-1473341304170-971dccb5ac1e?auto=format&fit=crop&w=1200&q=80',
    ),
    SceneCarouselSlide(
      title: '光伏与负载平衡',
      subtitle: '发电充裕时优先大功率设备，余量上网或储能，减少浪费。',
      imageUrl:
          'https://images.unsplash.com/photo-1509391366360-2e959784a276?auto=format&fit=crop&w=1200&q=80',
    ),
  ],
};

/// 12 条不同的详细场景预制（全站复用，加载更多时循环）
const List<PrefabDetailScenario> kPrefabDetailScenarios = [
  PrefabDetailScenario(
    name: '离家一键布防',
    description: '关闭非必要电器、启动移动侦测与门窗传感，摄像头进入警戒录像。',
    imageUrl:
        'https://images.unsplash.com/photo-1600607687939-ce8a6c25118c?auto=format&fit=crop&w=800&q=80',
    deviceIcons: [Icons.door_front_door_outlined, Icons.videocam_outlined, Icons.sensors],
  ),
  PrefabDetailScenario(
    name: '儿童归家通知',
    description: '指纹或儿童手表到家后推送消息，可联动客厅灯与摄像头快照确认。',
    imageUrl:
        'https://images.unsplash.com/photo-1600566753190-17f0baa2a6c3?auto=format&fit=crop&w=800&q=80',
    deviceIcons: [
      Icons.fingerprint,
      Icons.notifications_active_outlined,
      Icons.lightbulb_outline,
      Icons.child_care_outlined,
    ],
  ),
  PrefabDetailScenario(
    name: '漏水即时关水',
    description: '地面浸水传感器触发后关闭总阀电磁阀，并电话与 App 双重提醒。',
    imageUrl:
        'https://images.unsplash.com/photo-1600585154526-990dced4db0d?auto=format&fit=crop&w=800&q=80',
    deviceIcons: [
      Icons.water_drop_outlined,
      Icons.electrical_services,
      Icons.phone_in_talk_outlined,
      Icons.warning_amber_outlined,
      Icons.router_outlined,
    ],
  ),
  PrefabDetailScenario(
    name: '老人跌倒辅助',
    description: '毫米波雷达异常姿态识别后通知紧急联系人，可联动语音音箱喊话。',
    imageUrl:
        'https://images.unsplash.com/photo-1574362848149-11496d93a7c6?auto=format&fit=crop&w=800&q=80',
    deviceIcons: [
      Icons.elderly_woman_outlined,
      Icons.mic_none_outlined,
      Icons.emergency_outlined,
      Icons.watch_outlined,
      Icons.bluetooth_connected,
      Icons.sms_outlined,
    ],
  ),
  PrefabDetailScenario(
    name: '厨房油烟联动',
    description: '灶具开启后油烟机自动升档，燃气与烟雾双传感保障烹饪安全。',
    imageUrl:
        'https://images.unsplash.com/photo-1556911220-bff31c812dba?auto=format&fit=crop&w=800&q=80',
    deviceIcons: [Icons.kitchen_outlined, Icons.air, Icons.local_fire_department_outlined],
  ),
  PrefabDetailScenario(
    name: '花园浇灌定时',
    description: '根据土壤湿度与天气预报决定是否浇灌，避免雨天误喷浪费水源。',
    imageUrl:
        'https://images.unsplash.com/photo-1416879595882-3373a0480b5b?auto=format&fit=crop&w=800&q=80',
    deviceIcons: [Icons.yard_outlined, Icons.water, Icons.wb_sunny_outlined, Icons.schedule],
  ),
  PrefabDetailScenario(
    name: '车库门远程确认',
    description: '车辆蓝牙接近自动抬杆，异常未关推送并可远程一键落锁。',
    imageUrl:
        'https://images.unsplash.com/photo-1503376780353-7e6692767b70?auto=format&fit=crop&w=800&q=80',
    deviceIcons: [
      Icons.garage_outlined,
      Icons.bluetooth,
      Icons.smartphone,
      Icons.lock_reset,
    ],
  ),
  PrefabDetailScenario(
    name: '宠物活动剪影',
    description: '摄像头 AI 识别宠物活动生成每日短视频，异常长时间无活动提醒。',
    imageUrl:
        'https://images.unsplash.com/photo-1548199973-03cce0bbc87b?auto=format&fit=crop&w=800&q=80',
    deviceIcons: [
      Icons.pets,
      Icons.videocam_outlined,
      Icons.auto_awesome,
      Icons.notifications_none,
      Icons.cloud_upload_outlined,
    ],
  ),
  PrefabDetailScenario(
    name: '快递门口暂存',
    description: '门铃识别快递员后解锁快递格或语音指引放门口，录像留存交接。',
    imageUrl:
        'https://images.unsplash.com/photo-1607082348824-0a96f2a4b9da?auto=format&fit=crop&w=800&q=80',
    deviceIcons: [Icons.local_shipping_outlined, Icons.mic, Icons.camera_outdoor_outlined],
  ),
  PrefabDetailScenario(
    name: '声光驱离演示',
    description: '围栏入侵联动强闪灯与警报音，可区分宠物与人员降低误报。',
    imageUrl:
        'https://images.unsplash.com/photo-1516450360452-9312f5e86fc7?auto=format&fit=crop&w=800&q=80',
    deviceIcons: [
      Icons.campaign_outlined,
      Icons.light_mode_outlined,
      Icons.person_search,
      Icons.pets,
      Icons.tune,
    ],
  ),
  PrefabDetailScenario(
    name: '保险箱震动告警',
    description: '高敏加速度计检测搬动或冲击，本地蜂鸣并上传云端录像片段。',
    imageUrl:
        'https://images.unsplash.com/photo-1554224155-6726b3ff858f?auto=format&fit=crop&w=800&q=80',
    deviceIcons: [Icons.lock_outline, Icons.vibration, Icons.cloud_done_outlined],
  ),
  PrefabDetailScenario(
    name: '邻里联防广播',
    description: '物业紧急通知一键下发至各户音箱，可选仅公共区域或全屋播报。',
    imageUrl:
        'https://images.unsplash.com/photo-1486406146926-c627a92ad3ab?auto=format&fit=crop&w=800&q=80',
    deviceIcons: [
      Icons.apartment,
      Icons.speaker_group_outlined,
      Icons.campaign,
      Icons.groups_outlined,
      Icons.security,
      Icons.settings_remote,
      Icons.wifi_tethering,
    ],
  ),
];
