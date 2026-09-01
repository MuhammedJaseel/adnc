String formattedDate(DateTime _now) {
  final List<String> _monthNames = [
    '',
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];
  return '${_now.day} ${_monthNames[_now.month]} ${_now.year}';
}

String getDay(DateTime date) {
  String day = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ][date.weekday - 1];
  return day;
}

String convert24HT12H(String time24) {
  final parts = time24.split(':');
  if (parts.length != 2) return time24;

  int hour = int.tryParse(parts[0]) ?? 0;
  int minute = int.tryParse(parts[1]) ?? 0;

  if (hour < 0 || hour > 23 || minute < 0 || minute > 59) return time24;

  final now = DateTime.now();
  final utcTime = DateTime.utc(
    now.year,
    now.month,
    now.day,
    hour,
    minute,
  );
  final localTime = utcTime.toLocal();

  final period = localTime.hour >= 12 ? 'PM' : 'AM';
  final hour12 = localTime.hour % 12 == 0 ? 12 : localTime.hour % 12;
  final minuteString = localTime.minute.toString().padLeft(2, '0');

  return '$hour12:$minuteString $period';
}
