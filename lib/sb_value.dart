class SbValueModel {
  /*
{
  "issue_apr_amt": "52.67",
  "issue_aug_amt": "47.93",
  "issue_dec_amt": "47.58",
  "issue_feb_amt": "53.43",
  "issue_jan_amt": "53.92",
  "issue_jul_amt": "48.35",
  "issue_jun_amt": "48.78",
  "issue_mar_amt": "53.05",
  "issue_may_amt": "49.20",
  "issue_nov_amt": "48.00",
  "issue_oct_amt": "47.29",
  "issue_sep_amt": "47.61",
  "issue_year": "2003",
  "redemp_period": "2022-08",
  "redemption_month": "8",
  "redemption_year": "2022",
  "series_cd": "I",
  "src_line_nbr": "107"
}
   */
  final int issueYear;
  final int redemptionMonth;
  final int redemptionYear;

  List<double> amounts = [];

  SbValueModel({
    required this.issueYear,
    required this.redemptionMonth,
    required this.redemptionYear,
    required this.amounts,
  });

  factory SbValueModel.fromJson(Map<String, dynamic> json) {
    List<String> months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];
    List<double> amounts = [];
    for (var month in months) {
      // issue_apr_amt
      var key = 'issue_${month}_amt';
      var value = json[key];
      amounts.add(double.parse(value));
    }

    SbValueModel model = SbValueModel(
      issueYear: int.parse(json['issue_year']),
      redemptionMonth: int.parse(json['redemption_month']),
      redemptionYear: int.parse(json['redemption_year']),
      amounts: amounts,
    );
    return model;
  }
}

class SbValuesModel {
  List<SbValueModel> values = [];

  SbValuesModel({
    required this.values,
  });

  factory SbValuesModel.fromJson(Map<String, dynamic> json) {
    List<SbValueModel> values = [];

    Iterable items = json['data'];
    for (var item in items) {
      values.add(SbValueModel.fromJson(item));
    }

    SbValuesModel model = SbValuesModel(
      values: values,
    );

    return model;
  }
}
