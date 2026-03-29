import 'package:flutter_test/flutter_test.dart';

import 'package:ah_hub_simple_home/main.dart';
import 'package:ah_hub_simple_home/theme/app_palette.dart';
import 'package:ah_hub_simple_home/theme/app_palette_scope.dart';

void main() {
  testWidgets('HA-hub home smoke test', (WidgetTester tester) async {
    final palette = AppPalette.fallback;
    await tester.pumpWidget(
      AppPaletteScope(
        palette: palette,
        child: HaHubApp(palette: palette),
      ),
    );
    expect(find.textContaining('Simple'), findsWidgets);
    expect(find.text('案例'), findsNWidgets(2));
    expect(find.text('安全'), findsOneWidget);
  });
}
