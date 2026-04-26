import 'package:flutter_test/flutter_test.dart';

import 'package:circle_of_light/app/app.dart';

void main() {
  testWidgets('renders the Circle of Light shell', (tester) async {
    await tester.pumpWidget(const CircleOfLightApp());

    expect(find.text('Circle of Light'), findsOneWidget);
    expect(find.text('Grow in Quran with your circle'), findsOneWidget);
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('Circles'), findsOneWidget);
    expect(find.text('Profile'), findsOneWidget);
  });
}
