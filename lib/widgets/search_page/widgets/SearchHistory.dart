import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:searchimages/database/controllers/searchQueries.dart'
    as searchQueries;
import 'package:searchimages/database/models/SearchQuery.dart';
import 'package:searchimages/utils/widget-based.dart';

typedef CompareToFunction = int Function(SearchQuery, SearchQuery);

class SearchHistory extends StatefulWidget {
  final String filterUsingSearchQuery;
  final ValueChanged<String> onSearchHistoryItemTapped;

  SearchHistory({
    this.filterUsingSearchQuery,
    @required this.onSearchHistoryItemTapped,
  });

  @override
  State<StatefulWidget> createState() => _SearchHistoryState();
}

class _SearchHistoryState extends State<SearchHistory> {
  final CompareToFunction historySortAlgorithm =
      (a, b) => SearchQuery.compareToUsingDateTime(
            a,
            b,
            sortTechnique: SortTechnique.desc,
          );

  List<SearchQuery> _searchHistory = new List<SearchQuery>();

  @override
  void initState() {
    super.initState();
    _fetchSearchHistory();
  }

  @override
  void didUpdateWidget(SearchHistory oldWidget) {
    super.didUpdateWidget(oldWidget);
    _fetchSearchHistory();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: _searchHistory.length, itemBuilder: _buildSearchHistoryRow);
  }

  Widget _buildSearchHistoryRow(BuildContext builderContext, int index) {
    final SearchQuery searchQuery = _searchHistory[index];
    return ListTile(
      contentPadding: EdgeInsets.only(left: 24.0, right: 12.0),
      title: Text(searchQuery.query),
      onTap: () => _handleOnSearchHistoryItemTap(context, searchQuery),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline),
        onPressed: () => this._deleteSearchQuery(searchQuery),
      ),
    );
  }

  void _handleOnSearchHistoryItemTap(
    BuildContext context,
    SearchQuery searchQuery,
  ) {
    // Requesting focus here to remove the focus
    // from the TextField in the AppBar which further removes the keyboard from the screen
    requestFocus(context);
    widget.onSearchHistoryItemTapped(searchQuery.query);
  }

  void _deleteSearchQuery(SearchQuery searchQuery) {
    searchQueries.deleteSearchQuery(searchQuery.query);
    _fetchSearchHistory();
  }

  void _fetchSearchHistory() async {
    List<SearchQuery> searchQueryList =
        await searchQueries.getAllSearchQueries();

    searchQueryList.sort(historySortAlgorithm);

    if (this.mounted) {
      setState(() {
        _searchHistory = List<SearchQuery>.from(searchQueryList);
      });
    }
  }
}
