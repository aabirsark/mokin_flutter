// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:mokingbird_flutter/services/api/auth_api.serv.dart';
import 'package:mokingbird_flutter/services/api/thought_api.serv.dart';

void main() {
  group(
    "This is to check the api",
    () {
      test("test login feature", () async {
        final res = await AuthService.login(
          "",
          "",
        );
        expect(res, true);
      });

      test("test register feature", () async {
        final res = await AuthService.register("", "", "");
        expect(res, true);
      });

      test("This to test profile api", () async {
        final res = await AuthService.profile();
        expect(res, true);
      });
    },
  );

  group("This is to test {Post : thoughts/} API", () {
    test("Create new thought", () async {
      final res = await ThoughtAPIService.createNewThought("HEHEHEHE");
      expect(res, true);
    });

    test("Get all thoughts", () async {
      final res = await ThoughtAPIService.getAllThought();
      expect(res, true);
    });
  });
}
