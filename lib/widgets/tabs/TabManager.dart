import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:searchimages/utils/widget-based.dart';
import 'package:searchimages/widgets/appbar/AppBar-Home.dart';
import 'views/favorites/Favorites.dart';
import 'views/downloads/Downloads.dart';

class TabManager extends StatelessWidget {
  final List<TabData> tabDataList = [
    TabData(title: 'Favorites', view: FavoritesTab()),
    TabData(title: 'Downloads', view: DownloadsTab()),
  ];

  final VoidCallback onSearchButtonPressed;

  TabManager({@required this.onSearchButtonPressed});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabDataList.length,
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Scaffold(
      appBar: AppBarHome(
        onSearchButtonPressed: onSearchButtonPressed,
        bottom: TabBar(tabs: _buildAppBarTabs()),
      ),
      body: GestureDetector(
        child: TabBarView(children: _buildBodyTabViews()),
        onTap: () => requestFocus(context),
      ),
    );
  }

  List<Widget> _buildAppBarTabs() {
    return tabDataList.map((tabData) => Tab(text: tabData.title)).toList();
  }

  List<Widget> _buildBodyTabViews() {
    return tabDataList.map((tabData) => tabData.view).toList();
  }
}

class TabData {
  final String title;
  final Widget view;

  const TabData({@required this.title, @required this.view});
}
