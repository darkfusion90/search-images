import 'package:flutter/material.dart';
import 'package:searchimages/widgets/search_page/main.dart';
import 'package:searchimages/widgets/tabs/TabManager.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TabManager(
      onSearchButtonPressed: () => _handleOnSearchButtonPressed(context),
    );
  }

  void _handleOnSearchButtonPressed(BuildContext context) {
    print('oh yeah!');
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => SearchPageContainer()));
  }
}
