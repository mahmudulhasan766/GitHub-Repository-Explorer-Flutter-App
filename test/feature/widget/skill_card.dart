import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:readback/core/components/custom_svg.dart';
import 'package:readback/core/components/gradient_circular_progrees_bar.dart';
import 'package:readback/core/constants/app_text_style.dart';

void main() {
  testWidgets('SkillCard renders with title, value and progress', (WidgetTester tester) async {


    // Expect to find title text
    expect(find.text('Reading Skill'), findsOneWidget);

    // Expect to find value text
    expect(find.text('Advanced'), findsOneWidget);

    // Expect to find AnimatedCircularProgressBar
    expect(find.byType(AnimatedCircularProgressBar), findsOneWidget);

    // Should NOT find the lock icon
    expect(find.byType(CustomSvg), findsNothing);
  });



    // Expect to find lock icon
    expect(find.byType(CustomSvg), findsOneWidget);

    // Should NOT find progress bar
}
