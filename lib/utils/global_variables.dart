
import 'package:eduventure_nodejs/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const webScreenSize = 600;

showSnackBar(String content, BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4).copyWith(bottom: 16),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.startToEnd,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: colorPrimary,
      content: Row(
        children: [
          Flexible(
            child: Text(
              content,
              style: TextStyle(
                color: colorBlack,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.fade,
            ),
          )
        ],
      )));
}
