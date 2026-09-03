import 'package:adnc/services/attendance.dart';
import 'package:adnc/statics/colors.dart';
import 'package:adnc/utiles/formats.dart';
import 'package:flutter/material.dart';

class HomeHistory extends StatefulWidget {
  const HomeHistory({super.key});

  @override
  State<HomeHistory> createState() => _HomeHistoryState();
}

class _HomeHistoryState extends State<HomeHistory> {
  String _selectedCal = "day";
  List<Map<String, dynamic>> _data = [];

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final response = await AttendanceService().getAllAttendance();
      final rawData = response['data'] ?? response['result'] ?? [];

      if (!mounted) return;

      setState(() {
        _data = (rawData is List)
            ? rawData
                  .whereType<Map>()
                  .map((entry) => Map<String, dynamic>.from(entry))
                  .toList()
            : [];
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _data = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCal = "day";
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedCal == "day" ? primaryColor : borderColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                width: size.width * .28,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  'Day',
                  style: TextStyle(
                    fontSize: 14,
                    color: _selectedCal == "day"
                        ? primaryColor
                        : secondaryTextColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: size.width * .02),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCal = "week";
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedCal == "week" ? primaryColor : borderColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                width: size.width * .28,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  'Week',
                  style: TextStyle(
                    fontSize: 14,
                    color: _selectedCal == "week"
                        ? primaryColor
                        : secondaryTextColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: size.width * .02),
            GestureDetector(
              onTap: () {
                setState(() {
                  _selectedCal = "month";
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _selectedCal == "month" ? primaryColor : borderColor,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                ),
                width: size.width * .28,
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  'Month',
                  style: TextStyle(
                    fontSize: 14,
                    color: _selectedCal == "month"
                        ? primaryColor
                        : secondaryTextColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.arrow_back_ios, color: textColor, size: 20),
              SizedBox(width: 8),
              Text(
                'June 2026',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_ios, color: textColor, size: 20),
            ],
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: _data.isEmpty
                ? [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Center(
                        child: Text(
                          'No history found',
                          style: TextStyle(
                            fontSize: 14,
                            color: secondaryTextColor,
                          ),
                        ),
                      ),
                    ),
                  ]
                : [
                    for (final item in _data)
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: borderColor),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: size.width * .5 - 26,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formattedDate(
                                      DateTime.parse(item["date"] ?? ""),
                                    ),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    convert24HT12H(item["checkInTime"]),
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: textColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              convert24HT12H(item["checkOutTime"]),
                              style: TextStyle(
                                fontSize: 14,
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
          ),
        ),
      ],
    );
  }
}
