import 'package:adnc/pages/home/history.dart';
import 'package:adnc/pages/home/home.dart';
import 'package:adnc/pages/home/more.dart';
import 'package:adnc/pages/home/profile.dart';
import 'package:adnc/statics/colors.dart';
import 'package:flutter/material.dart';

class NavigationItem {
  final String title;
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final Widget body;

  // Use const constructor for better performance
  const NavigationItem({
    required this.title,
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.body,
  });
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<NavigationItem> navBarItems = [
    const NavigationItem(
      title: "Dashboard",
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
      body: Home(),
    ),
    const NavigationItem(
      title: "Attendance History",
      icon: Icons.history_outlined,
      activeIcon: Icons.history,
      label: 'History',
      body: HomeHistory(),
    ),
    const NavigationItem(
      title: "Profile",
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Profile',
      body: HomeProfile(),
    ),
    const NavigationItem(
      title: "More",
      icon: Icons.more_horiz,
      activeIcon: Icons.more_horiz,
      label: 'More',
      body: HomeMore(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(navBarItems[_selectedIndex].title, style: TextStyle(color: Colors.white)),
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: bgColor,
      body: Column(
        children: [
          Expanded(child: navBarItems[_selectedIndex].body),
          Container(
            height: 80,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade300, width: 1),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < navBarItems.length; i++)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = i;
                      });
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (_selectedIndex == i)
                          Icon(navBarItems[i].activeIcon, color: primaryColor)
                        else
                          Icon(navBarItems[i].icon, color: secondaryTextColor),
                        Text(
                          navBarItems[i].label,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: _selectedIndex == i
                                ? primaryColor
                                : secondaryTextColor,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
