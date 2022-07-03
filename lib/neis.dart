import 'meal.dart';
import 'neis_platform_interface.dart';
import 'schedule/schedule.dart';

const regionCodes = [
  'B10',
  'C10',
  'D10',
  'E10',
  'F10',
  'G10',
  'H10',
  'I10',
  'J10',
  'K10',
  'M10',
  'N10',
  'P10',
  'Q10',
  'R10',
  'S10',
  'T10'
];

enum Region {
  seoul,
  busan,
  daegu,
  incheon,
  gwanju,
  daejeon,
  ulsan,
  sejong,
  gyeonggi,
  gangwon,
  chungbuk,
  chungnam,
  jeonbuk,
  jeonnam,
  gyeongbuk,
  gyeongnam,
  jeju
}

class Neis {
  final Region region;
  final String key, school;
  late String regionCode;

  Future<String?> getPlatformVersion() {
    return NeisPlatform.instance.getPlatformVersion();
  }

  Neis(this.region, this.school, this.key) {
    regionCode = regionCodes[region.index];
  }

  Future<List> getMeals(int year, int month) {
   return fetchMeals(regionCode, school, key, year, month);
  }

  Future<List> getSchedules(int year, int month) {
    return fetchSchedules(regionCode, school, key, year, month);
  }

}
