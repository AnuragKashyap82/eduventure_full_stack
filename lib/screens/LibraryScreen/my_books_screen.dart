import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/colors.dart';
import 'MyTabPages/applied_book_screen.dart';
import 'MyTabPages/issued_book_screen.dart';
import 'MyTabPages/returened_book_screen.dart';

class MyBooksScreen extends StatefulWidget {
  const MyBooksScreen({Key? key}) : super(key: key);

  @override
  State<MyBooksScreen> createState() => _MyBooksScreenState();
}

class _MyBooksScreenState extends State<MyBooksScreen> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: colorPrimary,
            systemOverlayStyle:  SystemUiOverlayStyle(
              // Status bar color
              statusBarColor: colorPrimary,
              statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
              statusBarBrightness: Brightness.dark, // For iOS (dark icons)
            ),
            elevation: 0,
            iconTheme: IconThemeData(color: colorBlack),
            bottom:  TabBar(
              labelColor: colorBlack,
              indicatorColor: colorWhite,
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [
                Tab(text: "Applied"),
                Tab(text: "Issued"),
                Tab(text: "Returned"),
              ],
            ),
            title:  Text('My Books', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: colorBlack),),
          ),
          body: const TabBarView(
            children: [
              AppliedBookScreen(),
              IssuedBookScreen(),
              ReturnedBookScreen(),
            ],
          ),
        ),
      ),

    );
  }
}
