import 'package:flutter/material.dart';

import '../../../utils/colors.dart';

class DashboardItem extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subTitle;
  final String trailing;
  final IconData iconData;
  const DashboardItem({super.key, required this.onTap, required this.title, required this.subTitle, required this.trailing, required this.iconData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:  const EdgeInsets.only(left: 12),
        padding:  const EdgeInsets.all(32),
        height: 220,
        width: 220,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(26),
          color: colorPrimary,
        ),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
             Icon(
              (iconData),
              size: 30,
            ),
            const SizedBox(
              height: 8,
            ),
             Text(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            const SizedBox(
              height: 8,
            ),
             Text(
              subTitle,
              style: TextStyle(fontSize: 12),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                 Text(
                  trailing,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  width: 12,
                ),
                Icon(
                  Icons.arrow_back_outlined,
                  size: 24,
                  color: colorBlack,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
