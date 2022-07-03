import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

List parseMeals(http.Response response, DateTime lastDay) {
  List parsed = json.decode(response.body)['mealServiceDietInfo'][1]['row'];
  List meals = List.generate(lastDay.day, (_) => List.generate(3, (_) => []));

  for (var element in parsed) {
    int day = int.parse(element['MLSV_YMD'].substring(6)) - 1;
    int mealType = int.parse(element['MMEAL_SC_CODE']) - 1;

    meals[day][mealType] = removeAllergy(element['DDISH_NM']);
  }

  return meals;
}

Future<List> fetchMeals(
    String regionCode, String school, String key, int year, int month) async {
  DateTime firstDay = DateTime(year, month),
      lastDay = DateTime(year, month + 1, 0);
  final response = await http.get(Uri.parse(
      "https://open.neis.go.kr/hub/mealServiceDietInfo?key=$key&type=json&ATPT_OFCDC_SC_CODE=$regionCode&SD_SCHUL_CODE=$school&MLSV_FROM_YMD=${DateFormat('yyyyMMdd').format(firstDay)}&MLSV_TO_YMD=${DateFormat('yyyyMMdd').format(lastDay)}"));

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    if (result['RESULT'] == null) {
      return parseMeals(response, lastDay);
    } else {
      throw Exception();
    }
  } else {
    throw Exception();
  }
}

String removeAllergy(String meal) {
  return meal
      .replaceAll(new RegExp(r"[0-9.]"), "")
      .replaceAll('()', "")
      .replaceAll('<br/>', "\n");
}
