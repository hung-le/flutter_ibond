import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:ibond/sb_value.dart';

void main() {
  test('test 1', () {
    // The model should be able to receive the following data:
    final model = SbValueModel(
      issueYear: 2003,
      redemptionMonth: 8,
      redemptionYear: 2022,
      amounts: [],
    );

    expect(model.issueYear, 2003);
    expect(model.redemptionMonth, 8);
    expect(model.redemptionYear, 2022);
  });

  test('test 2', () {
    final file = File('test/test_resources/sb_value.json').readAsStringSync();
    final model =
        SbValueModel.fromJson(jsonDecode(file) as Map<String, dynamic>);

    // issue 12 2003
    // redemption 8 2022
    // 25.00 -> 47.58
    // 1000 -> 1903.20
    expect(model.issueYear, 2003);
    expect(model.redemptionMonth, 8);
    expect(model.redemptionYear, 2022);
    expect(model.amounts[11], 47.58);
    expect(model.amounts[11] * (1000 / 25), closeTo(1903.20, 0.01));
  });

  test('test 3', () {
    final file = File('test/test_resources/sb_values.json').readAsStringSync();

    SbValuesModel model =
        SbValuesModel.fromJson(jsonDecode(file) as Map<String, dynamic>);
    List<SbValueModel> values = model.values;
    expect(values.length, 11);

    var denomination = 1000;
    var issueYear = 2003;
    var issueMonth = 12;

    var redemptionYear = 2022;
    var redemptionMonth = 8;

    var amount = 1903.20;

    var months = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
    List<double> amounts = [
      2156.80,
      2137.20,
      2122.00,
      2106.80,
      1968.00,
      1951.20,
      1934.00,
      1917.20,
      1904.40,
      1891.60,
      1920.00,
      1903.20,
    ];
    for (var i = 0; i < 12; i++) {
      issueMonth = i + 1;
      amount = amounts[i];
      testAmount(model, issueYear, redemptionYear, redemptionMonth, issueMonth,
          denomination, amount);
    }
  });
}

void testAmount(SbValuesModel model, int issueYear, int redemptionYear,
    int redemptionMonth, int issueMonth, int denomination, double amount) {
  var items = model.values.where((element) {
    if ((element.issueYear == issueYear) &&
        (element.redemptionYear == redemptionYear) &&
        (element.redemptionMonth == redemptionMonth)) {
      return true;
    } else {
      return false;
    }
  });

  expect(items.length, 1);
  var item = items.first;
  expect(item.issueYear, issueYear);
  expect(item.redemptionYear, redemptionYear);
  expect(item.redemptionMonth, redemptionMonth);
  expect(item.amounts[issueMonth - 1] * (denomination / 25),
      closeTo(amount, 0.01));
}
