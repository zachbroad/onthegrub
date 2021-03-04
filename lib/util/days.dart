class Days {
  static String getNameFromNum(int num) {
    var days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[num-1];
  }

  static int getNumFromName(String name) {
    Map<String, dynamic> days = {
      'monday': 0,
      'tuesday': 1,
      'wednesday': 2,
      'thursday': 3,
      'friday': 4,
      'saturday': 5,
      'sunday': 6,
    };
    return days[name.toLowerCase()] + 1;
  }

  // Takes a timestamp in the format of hh:mm:ss
  static String getStdTime(String militaryTime) {
    var time = militaryTime.split(":");
    int.parse(time[0]) < 12
        ? () {
            time[0] = "${int.parse(time[0]).toString()}";
            time[1] = "${time[1]} AM";
          }()
        : () {
            time[0] = "${(int.parse(time[0]) - 12).toString()}";
            time[1] = "${time[1]} PM";
          }();
    return "${time[0]}:${time[1]}";
  }
}
