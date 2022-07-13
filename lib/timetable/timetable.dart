import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:neis/neis.dart';

List parseSchedules(http.Response response, int firstDay) {
  List parsed = json.decode(response.body)['hisTimetable'][1]['row'];
  List timetables = List.generate(5, (_) => List.generate(8, (_) => ""));

  for (var element in parsed) {
    int day = int.parse(element['ALL_TI_YMD'].substring(6)) - firstDay;
    int perio = int.parse(element['PERIO']) - 1;
    timetables[day][perio] = element['ITRT_CNTNT'];
  }

  return timetables;
}

Future<List> fetchTimetables(
    String regionCode,
    String school,
    SchoolType schoolType,
    String key,
    int grade,
    int classNumber,
    DateTime dateTime) async {
  final DateTime first =
      dateTime.add(Duration(days: DateTime.monday - dateTime.weekday));
  final DateTime last = first.add(const Duration(days: 4));
  final response = await http.get(Uri.parse(
      "https://open.neis.go.kr/hub/${describeEnum(schoolType)}Timetable?key=$key&type=json&ATPT_OFCDC_SC_CODE=$regionCode&SD_SCHUL_CODE=$school&AY=${first.year}&GRADE=$grade&CLASS_NM=$classNumber&TI_FROM_YMD=${DateFormat('yyyyMMdd').format(first)}&TI_TO_YMD=${DateFormat('yyyyMMdd').format(last)}"));

  if (response.statusCode == 200) {
    var result = json.decode(response.body);
    if (result['RESULT'] == null) {
      return parseSchedules(response, first.day);
    } else {
      throw Exception();
    }
  } else {
    throw Exception();
  }
}
