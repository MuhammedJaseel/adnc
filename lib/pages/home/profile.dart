import 'package:adnc/statics/colors.dart';
import 'package:adnc/utiles/user.dart';
import 'package:flutter/material.dart';

class HomeProfile extends StatelessWidget {
  const HomeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 24),
      children: [
        SizedBox(height: 40),
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: secondaryColor,
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.person_outline, color: Colors.white, size: 42),
        ),
        SizedBox(height: 30),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Employee Id',
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Name',
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                User.employee["fullName"] ?? "",
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Department',
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '',
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Designation',
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                User.employee["position"] ?? "",
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Mobile',
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                User.employee["phoneNumber"] ?? "",
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: borderColor)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 14,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                User.employee["email"] ?? "",
                style: TextStyle(
                  fontSize: 16,
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
