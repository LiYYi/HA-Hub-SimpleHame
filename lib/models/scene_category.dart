/// 四大场景（与首页入口一致）
enum SceneCategory {
  security,
  health,
  comfort,
  energy,
}

extension SceneCategoryX on SceneCategory {
  String get label => switch (this) {
        SceneCategory.security => '安全',
        SceneCategory.health => '健康',
        SceneCategory.comfort => '舒适',
        SceneCategory.energy => '节能',
      };
}
