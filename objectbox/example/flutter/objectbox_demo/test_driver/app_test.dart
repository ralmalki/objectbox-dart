// Temporary opt out of null-safety, flutter_driver is not null-safe yet
// @dart = 2.10

import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  // First, define the Finders and use them to locate widgets from the
  // test suite. Note: the Strings provided to the `byValueKey` method must
  // be the same as the Strings we used for the Keys in step 1.
  final inputTextFinder = find.byValueKey('input');
  final buttonFinder = find.byValueKey('submit');
  final firstItemFinder = find.byValueKey('list_item_0');

  FlutterDriver driver;

  // Connect to the Flutter driver before running any tests.
  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  // Close the connection to the driver after the tests have completed.
  tearDownAll(() async => await driver.close());

  test('starts with a pre-populated list', () async {
    expect(await driver.getText(firstItemFinder),
        'Quickly add a note by writing text and pressing Enter');
  });

  test('inserted item appears in the list', () async {
    final text = 'item text';
    await driver.tap(inputTextFinder);
    await driver.enterText(text);
    await driver.tap(buttonFinder);
    expect(await driver.getText(firstItemFinder), text);
  });
}
