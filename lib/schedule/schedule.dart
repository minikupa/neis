import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

List parseSchedules(http.Response response, DateTime lastDay) {
  List parsed = json.decode(response.body)['SchoolSchedule'][1]['row'];
  List schedule = List.generate(lastDay.day, (_) => []);

  for (var element in parsed) {
    int day = int.parse(element['AA_YMD'].substring(6)) - 1;
    schedule[day].add(element['EVENT_NM']);
  }

  return schedule;
}

Future<List> fetchSchedules(
    String regionCode, String school, String key, int year, int month) async {
  DateTime firstDay = DateTime(year, month),
      lastDay = DateTime(year, month + 1, 0);
  final response = await http.get(Uri.parse(
      "https://open.neis.go.kr/hub/SchoolSchedule?key=$key&type=json&ATPT_OFCDC_SC_CODE=$regionCode&SD_SCHUL_CODE=$school&AA_FROM_YMD=${DateFormat('yyyyMMdd').format(firstDay)}&AA_TO_YMD=${DateFormat('yyyyMMdd').format(lastDay)}"));

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    if (result['RESULT'] == null) {
      return parseSchedules(response, lastDay);
    } else {
      throw Exception();
    }
  } else {
    throw Exception();
  }
}
