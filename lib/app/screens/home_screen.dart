import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wp_blog_app/const_values.dart';
import 'package:wp_blog_app/providers/theme_provider.dart';
import 'package:wp_blog_app/widgets/horizonatl_view.dart';
import 'package:wp_blog_app/widgets/list_view_post.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var dateFormat = DateFormat.yMMMMEEEEd().format(DateTime.now());

  Box? storeData;

  @override
  void initState() {
    super.initState();
    HorizontalView();
    ListViewPost();
    storeData = Hive.box(appState);
  }

  // fucntion to refersh page.
  Future<Null> refreshPage() async {
    Future.delayed(Duration(seconds: 2));
    setState(() {});
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final isThemeChange = Provider.of<ThemeProvider>(context);
    return SafeArea(
      top: true,
      child: Scaffold(
        // backgroundColor: changeData.isDark == false ? mainColor : darkColor,
        body: RefreshIndicator(
          onRefresh: refreshPage,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    height: setContainerHeight(290),
                    decoration: BoxDecoration(
                      color: isThemeChange.mTheme == false
                          ? Colors.white
                          : Colors.grey[900],
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(33),
                        bottomRight: Radius.circular(33),
                      ),
                    ),
                    child: Container(
                      height: setContainerHeight(290),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: setContainerHeight(50),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Latest",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: setTextSize(25),
                                    ),
                                  ),
                                  Text(
                                    "$dateFormat",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                      fontSize: setTextSize(10),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          HorizontalView(),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 30, bottom: 10, top: 15),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "Smart Phones",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: setTextSize(20),
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                  ListViewPost(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
