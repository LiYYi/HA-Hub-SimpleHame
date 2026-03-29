import 'package:flutter/material.dart';

import 'pages/ha_hub_home_page.dart';
import 'theme/app_palette.dart';
import 'theme/app_palette_scope.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final palette = await AppPalette.load();
  runApp(
    AppPaletteScope(
      palette: palette,
      child: HaHubApp(palette: palette),
    ),
  );
}

class HaHubApp extends StatelessWidget {
  const HaHubApp({super.key, required this.palette});

  final AppPalette palette;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HA-hub SimpleHome',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: palette.brand,
          brightness: Brightness.light,
          primary: palette.brand,
          surface: palette.themeSurface,
        ),
        scaffoldBackgroundColor: palette.pageBackground,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      ),
      home: const HaHubHomePage(),
    );
  }
}
