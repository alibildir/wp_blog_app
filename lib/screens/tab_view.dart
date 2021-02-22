import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wp_blog_app/const_values.dart';
import 'package:wp_blog_app/models/posts.dart';
import 'package:wp_blog_app/screens/bookmark.dart';
import 'package:wp_blog_app/screens/category.dart';
import 'package:wp_blog_app/screens/home_screen.dart';
import 'package:wp_blog_app/screens/settings.dart';

class TabView extends StatefulWidget {
  @override
  _TabViewState createState() => _TabViewState();
}

class _TabViewState extends State<TabView> {
  final List<Map<String, Object>> _pages = [
    {
      'page': HomeScreen(),
    },
    {
      'page': Bookmark(),
    },
    {
      'page': Category(),
    },
    {
      'page': Settings(),
    },
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Box storeData;

  @override
  void initState() {
    super.initState();
    storeData = Hive.box(appState);
  }

  @override
  Widget build(BuildContext context) {
    final Posts changeData = storeData.get(themeKey);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "NaijaTechGuy Blog",
          style: TextStyle(
            color: changeData.isDark == false ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
                changeData.isDark ? Icons.brightness_6 : Icons.brightness_3),
            onPressed: () {
              changeData.changeTheme();
              storeData.put(themeKey, changeData);
            },
          )
        ],
      ),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavyBar(
        backgroundColor:
            changeData.isDark == false ? defaultWhite : Colors.grey[850],
        selectedIndex: _selectedPageIndex,
        onItemSelected: _selectPage,
        items: [
          BottomNavyBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
            activeColor: changeData.isDark == false ? subColor : defaultWhite,
            inactiveColor:
                changeData.isDark == false ? defaultBlack : defaultWhite,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.bookmark),
            title: Text('Bookmarked'),
            activeColor: changeData.isDark == false ? subColor : defaultWhite,
            inactiveColor:
                changeData.isDark == false ? defaultBlack : defaultWhite,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.list),
            title: Text('Category'),
            activeColor: changeData.isDark == false ? subColor : defaultWhite,
            inactiveColor:
                changeData.isDark == false ? defaultBlack : defaultWhite,
          ),
          BottomNavyBarItem(
            icon: Icon(Icons.info),
            title: Text('About'),
            activeColor: changeData.isDark == false ? subColor : defaultWhite,
            inactiveColor:
                changeData.isDark == false ? defaultBlack : defaultWhite,
          )
        ],
      ),
    );
  }
}
