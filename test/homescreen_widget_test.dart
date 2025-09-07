import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readback/core/constants/app_strings.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  });

  testWidgets('HomeScreen renders correctly and shows key widgets',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // Wrap with ScreenUtilInit and MockEasyLocalization for proper rendering
    /*await tester.pumpWidget(
      MaterialApp(
        home: ScreenUtilInit(
          designSize: const Size(375, 812), // Your design size
          builder: (context, child) => MockEasyLocalization(
            child: const HomeScreen(),
          ),
        ),
      ),
    );*/



    // Verify that the "Skill Level" text is present.
    // Ensure that AppStrings.skillLevel is loaded correctly.
    // If you have issues with .tr(), you might need to ensure EasyLocalization
    // is properly initialized or mock its behavior.
    expect(find.text(AppStrings.success.tr()), findsOneWidget);

    await tester.drag(
        find.byType(SingleChildScrollView), const Offset(0, -300)); // Drag down
    await tester.pumpAndSettle(); // Wait for animations to complete

  });
}
