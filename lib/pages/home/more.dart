import 'package:adnc/statics/colors.dart';
import 'package:flutter/material.dart';

class HomeMore extends StatelessWidget {
  const HomeMore({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24),
      children: [
        SizedBox(height: 30),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.lock_outline, color: textColor, size: 22),
                  SizedBox(width: 16),
                  Text(
                    'Change PIN',
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: secondaryTextColor, size: 18),
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.help_outline, color: textColor, size: 22),
                  SizedBox(width: 16),
                  Text(
                    'Help & Support',
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: secondaryTextColor, size: 18),
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.privacy_tip_outlined, color: textColor, size: 22),
                  SizedBox(width: 16),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: secondaryTextColor, size: 18),
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.file_copy_outlined, color: textColor, size: 22),
                  SizedBox(width: 16),
                  Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: secondaryTextColor, size: 18),
            ],
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.info_outline, color: textColor, size: 22),
                  SizedBox(width: 16),
                  Text(
                    'About App',
                    style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: secondaryTextColor, size: 18),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 18),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.logout, color: warningRed, size: 22),
                  SizedBox(width: 16),
                  Text(
                    'Logout',
                    style: TextStyle(
                      fontSize: 16,
                      color: warningRed,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward_ios, color: secondaryTextColor, size: 18),
            ],
          ),
        ),
      ],
    );
  }
}
