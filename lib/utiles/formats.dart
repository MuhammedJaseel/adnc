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
