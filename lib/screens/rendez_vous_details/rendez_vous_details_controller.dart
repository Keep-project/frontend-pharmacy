// ignore_for_file: avoid_print

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RendezVousScreenControllerDetails extends GetxController {
  DateTime now = DateTime.now();
  String dateName = "";
  List<Map<String, dynamic>> dayList = [];
  int selectedDayIndex = 0;

  @override
  void onInit() {
    lastDayOfMonth();
    super.onInit();
  }

  void lastDayOfMonth() {
    // DateTime lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
    DateTime currentDate = DateTime.parse(
        "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} 00:00:00.0");

    dateName = DateFormat('EEEE, d MMM yyyy').format(currentDate);
    // print("date name $dateName");

    for (var i = now.day; i <= now.day + 30; i++) {
      var month = now.month;
      var year = now.year;
      var date = DateTime.parse("${now.year}-${now.month.toString().padLeft(2, '0')}-${i.toString().padLeft(2, '0')} 00:00:00.0");
      if (date.month > now.month){
        month = date.month;
      }
      if (date.year > now.year){
        year = date.year;
      }
      
      dayList.add({
        'dateName': DateFormat("E").format(DateTime.parse("${now.year}-${month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} 00:00:00.0")),
        'day': date.day,
        'month': DateFormat("MMMM").format(DateTime.parse("$date")),
        'year': year,
      });
    }

  }

  void changeSelectedDay(int index) {
    selectedDayIndex = index;
    print(dayList[index]);
    update();
  }
}
