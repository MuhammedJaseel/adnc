import 'package:adnc/pages/home/punch_in_out.dart';
import 'package:adnc/statics/colors.dart';
import 'package:flutter/material.dart';

class PunchSuccessPage extends StatelessWidget {
  const PunchSuccessPage({
    super.key,
    this.location = '',
    this.battery = '',
    this.network = '',
    this.device = '',
    this.type = PunchType.punchIn,
    this.punchTime = '',
    this.punchDate = '',
    this.punchDay = '',
  });

  final String location;
  final String battery;
  final String network;
  final String device;
  final PunchType type;
  final String punchTime;
  final String punchDate;
  final String punchDay;

  @override
  Widget build(BuildContext context) {
    const primaryGreen = Color(0xFF00C896);

    void onBack() {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }

    return PopScope(
      canPop: false, // Prevents default pop back to PunchIn screen
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        onBack();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F9FB),
        body: Stack(
          children: [
            // Top Green Background Header
            Container(
              height: 300,
              width: double.infinity,
              color: primaryGreen,
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    // Checkmark Circle Icon
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 4),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '${type == PunchType.punchIn ? 'Punch In' : 'Punch Out'} Successful',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      punchTime,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$punchDate, $punchDay',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Main Card & Button Layout
            SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 220,
                  ), // Offset to overlap top green header
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        children: [
                          // Details Card
                          Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 16,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Attendance Details',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                _buildDetailRow(
                                  icon: Icons.location_on_outlined,
                                  title: 'Location',
                                  subtitle: location,
                                  trailing: Icon(
                                    Icons.chevron_right,
                                    color: textColor,
                                  ),
                                ),
                                _buildDetailRow(
                                  icon: Icons.map_outlined,
                                  title: 'Google Maps',
                                  subtitle: 'View on Maps',
                                  isSubtitleAction: true,
                                  trailing: Icon(
                                    Icons.open_in_new,
                                    color: textColor,
                                    size: 20,
                                  ),
                                ),
                                const Divider(
                                  height: 18,
                                  color: Color(0xFFF1F5F9),
                                ),
                                _buildDetailRow(
                                  icon: Icons.battery_charging_full,
                                  title: 'Battery',
                                  trailingText: battery,
                                ),
                                _buildDetailRow(
                                  icon: Icons.wifi,
                                  title: 'Internet',
                                  trailingText: network,
                                ),
                                _buildDetailRow(
                                  icon: Icons.smartphone,
                                  title: 'Device',
                                  subtitle: device,
                                  trailing: Icon(
                                    Icons.chevron_right,
                                    color: textColor,
                                  ),
                                ),
                                _buildDetailRow(
                                  icon: Icons.badge_outlined,
                                  title: 'Type',
                                  subtitle: type == PunchType.punchIn
                                      ? 'Punch In'
                                      : 'Punch Out',
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          // OK Button
                          SizedBox(
                            width: double.infinity,
                            height: 54,
                            child: ElevatedButton(
                              onPressed: onBack,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryGreen,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String title,
    String? subtitle,
    bool isSubtitleAction = false,
    Widget? trailing,
    String? trailingText,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      height: 56,
      child: Row(
        children: [
          Icon(icon, size: 24, color: textColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: isSubtitleAction
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: isSubtitleAction
                          ? const Color(0xFF2563EB)
                          : const Color(0xFF64748B),
                    ),
                  ),
              ],
            ),
          ),
          if (trailingText != null)
            Text(
              trailingText,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
