import 'package:flutter/material.dart';

import '../models/scene_category.dart';
import 'detailed_scenario_models.dart';
import 'scene_detail_content.dart';

/// 户型示意平面图（俯视）
const String kDefaultFloorPlanUrl =
    'https://images.unsplash.com/photo-1600585154340-be6161a56a0c?auto=format&fit=crop&w=1400&q=80';

/// 各场景类轮播页默认「所需设备」展示（每类 5 台）
const Map<SceneCategory, List<DetailedDeviceSpec>> kCarouselCategoryDevices = {
  SceneCategory.security: [
    DetailedDeviceSpec(icon: Icons.door_front_door_outlined, name: '智能门锁', brief: '指纹/人脸与远程开锁记录'),
    DetailedDeviceSpec(icon: Icons.videocam_outlined, name: '门口摄像机', brief: '逗留侦测与云存储'),
    DetailedDeviceSpec(icon: Icons.sensors, name: '门窗传感器', brief: '开合状态实时上报'),
    DetailedDeviceSpec(icon: Icons.router_outlined, name: '家庭网关', brief: 'Zigbee/蓝牙子设备汇聚'),
    DetailedDeviceSpec(icon: Icons.campaign_outlined, name: '声光报警器', brief: '本地告警与联动播报'),
  ],
  SceneCategory.health: [
    DetailedDeviceSpec(icon: Icons.air, name: '新风机', brief: 'CO₂ 与 PM2.5 联动风量'),
    DetailedDeviceSpec(icon: Icons.water_drop_outlined, name: '恒湿器', brief: '卧室湿度目标曲线'),
    DetailedDeviceSpec(icon: Icons.thermostat_outlined, name: '温控面板', brief: '分区温度策略'),
    DetailedDeviceSpec(icon: Icons.watch_outlined, name: '睡眠手环', brief: '深睡阶段联动灯光'),
    DetailedDeviceSpec(icon: Icons.filter_alt_outlined, name: '空气净化器', brief: '滤芯寿命提醒'),
  ],
  SceneCategory.comfort: [
    DetailedDeviceSpec(icon: Icons.lightbulb_outline, name: '调光筒灯', brief: '色温与亮度场景'),
    DetailedDeviceSpec(icon: Icons.curtains_closed_outlined, name: '智能窗帘', brief: '日出日落自动开合'),
    DetailedDeviceSpec(icon: Icons.speaker_outlined, name: '全屋音箱', brief: '多房间同步播放'),
    DetailedDeviceSpec(icon: Icons.ac_unit, name: '中央空调网关', brief: '回家前预冷预热'),
    DetailedDeviceSpec(icon: Icons.switch_access_shortcut_outlined, name: '情景面板', brief: '一键触发组合动作'),
  ],
  SceneCategory.energy: [
    DetailedDeviceSpec(icon: Icons.electrical_services, name: '智能电表', brief: '分路用电统计'),
    DetailedDeviceSpec(icon: Icons.ev_station_outlined, name: '充电桩', brief: '谷电预约充电'),
    DetailedDeviceSpec(icon: Icons.solar_power_outlined, name: '逆变器采集', brief: '发电功率实时'),
    DetailedDeviceSpec(icon: Icons.outlet_outlined, name: '智能插座', brief: '待机功耗切断'),
    DetailedDeviceSpec(icon: Icons.dashboard_outlined, name: '能源中控屏', brief: '策略编排与报表'),
  ],
};

/// 与 [kPrefabDetailScenarios] 顺序对应的完整设备清单（含名称与简介）
const List<List<DetailedDeviceSpec>> kPrefabFullDeviceSpecs = [
  [
    DetailedDeviceSpec(icon: Icons.door_front_door_outlined, name: '智能门锁', brief: '离家自动反锁与告警'),
    DetailedDeviceSpec(icon: Icons.videocam_outlined, name: '室内云台相机', brief: '移动追踪与隐私遮蔽'),
    DetailedDeviceSpec(icon: Icons.sensors, name: '人体/门窗传感', brief: '分区布防触发条件'),
    DetailedDeviceSpec(icon: Icons.router_outlined, name: '多模网关', brief: '子设备离线监测'),
    DetailedDeviceSpec(icon: Icons.phone_android_outlined, name: '家庭 App 中枢', brief: '推送与远程确认'),
  ],
  [
    DetailedDeviceSpec(icon: Icons.fingerprint, name: '智能门锁', brief: '儿童指纹独立权限'),
    DetailedDeviceSpec(icon: Icons.notifications_active_outlined, name: '消息推送服务', brief: '到家时间线记录'),
    DetailedDeviceSpec(icon: Icons.lightbulb_outline, name: '客厅主灯', brief: '归家亮灯欢迎'),
    DetailedDeviceSpec(icon: Icons.child_care_outlined, name: '儿童手表', brief: '地理围栏联动'),
    DetailedDeviceSpec(icon: Icons.videocam_outlined, name: '玄关摄像头', brief: '快照复核是否本人'),
  ],
  [
    DetailedDeviceSpec(icon: Icons.water_drop_outlined, name: '浸水传感器', brief: '地面积水秒级上报'),
    DetailedDeviceSpec(icon: Icons.electrical_services, name: '电动水阀', brief: '远程/自动关断总阀'),
    DetailedDeviceSpec(icon: Icons.phone_in_talk_outlined, name: '语音电话网关', brief: '紧急外呼联系人'),
    DetailedDeviceSpec(icon: Icons.warning_amber_outlined, name: '声光警示灯', brief: '本地强提醒'),
    DetailedDeviceSpec(icon: Icons.router_outlined, name: '边缘网关', brief: '断网本地逻辑'),
  ],
  [
    DetailedDeviceSpec(icon: Icons.elderly_woman_outlined, name: '毫米波雷达', brief: '姿态与驻留检测'),
    DetailedDeviceSpec(icon: Icons.mic_none_outlined, name: '智能音箱', brief: '语音呼救与播报'),
    DetailedDeviceSpec(icon: Icons.emergency_outlined, name: '紧急按钮', brief: '一键呼叫子女'),
    DetailedDeviceSpec(icon: Icons.watch_outlined, name: '健康手表', brief: '心率异常联动'),
    DetailedDeviceSpec(icon: Icons.bluetooth_connected, name: '蓝牙信标', brief: '房间级定位辅助'),
    DetailedDeviceSpec(icon: Icons.sms_outlined, name: '短信网关', brief: '备用通知通道'),
  ],
  [
    DetailedDeviceSpec(icon: Icons.kitchen_outlined, name: '智能灶具网关', brief: '火力状态上报'),
    DetailedDeviceSpec(icon: Icons.air, name: '变频油烟机', brief: '油烟浓度联动转速'),
    DetailedDeviceSpec(icon: Icons.local_fire_department_outlined, name: '燃气+烟雾传感', brief: '双冗余报警'),
    DetailedDeviceSpec(icon: Icons.electrical_services, name: '燃气切断阀', brief: '联动关气'),
  ],
  [
    DetailedDeviceSpec(icon: Icons.yard_outlined, name: '花园控制器', brief: '多路电磁阀'),
    DetailedDeviceSpec(icon: Icons.water, name: '土壤湿度计', brief: '分区灌溉策略'),
    DetailedDeviceSpec(icon: Icons.wb_sunny_outlined, name: '小型气象站', brief: '降雨预测跳过浇灌'),
    DetailedDeviceSpec(icon: Icons.schedule, name: '定时灌溉', brief: '与日历/假期联动'),
  ],
  [
    DetailedDeviceSpec(icon: Icons.garage_outlined, name: '车库门电机', brief: '升降状态回传'),
    DetailedDeviceSpec(icon: Icons.bluetooth, name: '车载蓝牙标签', brief: '接近自动开门'),
    DetailedDeviceSpec(icon: Icons.smartphone, name: '车主手机', brief: '远程确认关门'),
    DetailedDeviceSpec(icon: Icons.lock_reset, name: '行程终点检测', brief: '异常未关二次提醒'),
  ],
  [
    DetailedDeviceSpec(icon: Icons.pets, name: '宠物 AI 摄像', brief: '活动量识别'),
    DetailedDeviceSpec(icon: Icons.videocam_outlined, name: '客厅全景机', brief: '多镜头拼接'),
    DetailedDeviceSpec(icon: Icons.auto_awesome, name: '云端 AI 剪辑', brief: '每日高光生成'),
    DetailedDeviceSpec(icon: Icons.notifications_none, name: '异常静默告警', brief: '长时间无活动推送'),
    DetailedDeviceSpec(icon: Icons.cloud_upload_outlined, name: 'NAS/云存储', brief: '片段自动归档'),
  ],
  [
    DetailedDeviceSpec(icon: Icons.local_shipping_outlined, name: '可视门铃', brief: '快递员人脸识别'),
    DetailedDeviceSpec(icon: Icons.mic, name: '对讲音箱', brief: '远程语音指引'),
    DetailedDeviceSpec(icon: Icons.camera_outdoor_outlined, name: '户外枪机', brief: '包裹区录像'),
    DetailedDeviceSpec(icon: Icons.inventory_2_outlined, name: '快递格电磁锁', brief: '一次性取件码'),
  ],
  [
    DetailedDeviceSpec(icon: Icons.campaign_outlined, name: '高音警报器', brief: '入侵驱离'),
    DetailedDeviceSpec(icon: Icons.light_mode_outlined, name: '强闪灯带', brief: '夜间可见警示'),
    DetailedDeviceSpec(icon: Icons.person_search, name: '周界摄像', brief: '越线检测'),
    DetailedDeviceSpec(icon: Icons.pets, name: '宠物过滤算法', brief: '降低误报'),
    DetailedDeviceSpec(icon: Icons.tune, name: '规则引擎', brief: '灵敏度分时段'),
  ],
  [
    DetailedDeviceSpec(icon: Icons.lock_outline, name: '保险箱本体', brief: '内置震动传感'),
    DetailedDeviceSpec(icon: Icons.vibration, name: '加速度计模组', brief: '冲击波形分析'),
    DetailedDeviceSpec(icon: Icons.cloud_done_outlined, name: '云录像联动', brief: '告警前后预录'),
    DetailedDeviceSpec(icon: Icons.notifications_active_outlined, name: '本地蜂鸣', brief: '近距离威慑'),
  ],
  [
    DetailedDeviceSpec(icon: Icons.apartment, name: '物业广播主机', brief: '分区下发'),
    DetailedDeviceSpec(icon: Icons.speaker_group_outlined, name: '公区音箱', brief: '走廊/大堂覆盖'),
    DetailedDeviceSpec(icon: Icons.campaign, name: '应急话筒', brief: '人工插播'),
    DetailedDeviceSpec(icon: Icons.groups_outlined, name: '业主分组', brief: '按楼栋推送'),
    DetailedDeviceSpec(icon: Icons.security, name: '消防联动接口', brief: '强切告警音'),
    DetailedDeviceSpec(icon: Icons.settings_remote, name: '红外遥控', brief: ' legacy 功放控制'),
    DetailedDeviceSpec(icon: Icons.wifi_tethering, name: '4G 备份链路', brief: '断网仍可播报'),
  ],
];

List<String> _userVoicesFor(String scenarioName, SceneCategory category) {
  final cat = category.label;
  return [
    '「我每天出门前都会看一眼 $scenarioName 是否已就绪，全家都省心。」——上班族 李先生',
    '「爸妈不太会折腾设置，我帮他们设好 $scenarioName 后，他们只要正常用就行。」——子女用户 王女士',
    '「物业推荐我们接入 $cat 类方案后，$scenarioName 在业主群里反馈挺好的。」——业委会代表',
    '「作为智能家居新手，官方把 $scenarioName 的步骤写得很清楚，按提示买设备就能跑通。」——新用户',
  ];
}

String _officialIntroFromPrefab(PrefabDetailScenario p, SceneCategory category) {
  return '${p.description}\n\n'
      'SimpleHome 官方为该场景提供标准化联动模板与设备兼容性认证。您可在 App 中一键套用，'
      '系统将根据您已绑定的设备自动生成推荐规则；若需定制触发条件与通知对象，也可在高级模式中逐项调整。'
      '本方案归属「${category.label}」场景族，支持与同族其它子场景并存运行。';
}

String _officialIntroFromCarousel(SceneCarouselSlide slide, SceneCategory category) {
  return '${slide.subtitle}\n\n'
      'SimpleHome 将该能力封装为可复用的官方场景模板，设备接入后自动完成协议握手与权限校验。'
      '建议在完成基础配网后执行一次「场景演练」，确认各节点响应时序符合预期。'
      '当前介绍对应「${category.label}」分类下的「${slide.title}」应用实例。';
}

/// 从瀑布流卡片（预制索引）生成详情页数据
ScenarioDeepContent scenarioDeepFromPrefab(int prefabIndex, SceneCategory category) {
  final i = prefabIndex % kPrefabDetailScenarios.length;
  final p = kPrefabDetailScenarios[i];
  final devices = kPrefabFullDeviceSpecs[i];
  return ScenarioDeepContent(
    scenarioName: p.name,
    category: category,
    heroImageUrl: p.imageUrl,
    officialIntro: _officialIntroFromPrefab(p, category),
    devices: devices,
    userVoices: _userVoicesFor(p.name, category),
    floorPlanImageUrl: kDefaultFloorPlanUrl,
  );
}

/// 从轮播当前页生成详情页数据
ScenarioDeepContent scenarioDeepFromCarousel(SceneCategory category, int slideIndex) {
  final slides = kSceneCarouselByCategory[category]!;
  final s = slides[slideIndex.clamp(0, slides.length - 1)];
  final devices = kCarouselCategoryDevices[category]!;
  return ScenarioDeepContent(
    scenarioName: s.title,
    category: category,
    heroImageUrl: s.imageUrl,
    officialIntro: _officialIntroFromCarousel(s, category),
    devices: devices,
    userVoices: _userVoicesFor(s.title, category),
    floorPlanImageUrl: kDefaultFloorPlanUrl,
  );
}
