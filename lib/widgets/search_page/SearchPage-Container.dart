import 'package:flutter/cupertino.dart';

import 'package:searchimages/database/controllers/searchQueries.dart'
    as dbSearchQueries;
import 'package:searchimages/database/models/main.dart' as models;
import 'package:searchimages/utils/api.dart' as api;
import 'package:searchimages/utils/widget-based.dart';
import 'package:searchimages/widgets/search_page/SearchPage-View.dart';
import 'package:searchimages/widgets/search_page/utils/SearchPageMode.dart';
import 'package:searchimages/widgets/search_page/utils/WillPopResult.dart';

class SearchPageContainer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPageContainerState();
}

class _SearchPageContainerState extends State<SearchPageContainer> {
  SearchPageMode _searchPageMode = SearchPageMode.editingSearchQuery;
  WillPopResult _willPopResult = WillPopResult.pop;
  final _searchQueryFieldController = TextEditingController();
  bool _isLoadingData = false;
  int _pageNumber = 1;
  List<models.ImageModel> _imageList = new List<models.ImageModel>();

  @override
  void dispose() {
    _searchQueryFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SearchPageView(
      imageList: _imageList,
      searchPageMode: _searchPageMode,
      onWillPop: () => _handleWillPop(context),
      isLoadingData: _isLoadingData,
      searchQueryFieldController: _searchQueryFieldController,
      onSearchButtonPressed: _handleOnSearchButtonPressed,
      onSearchHistoryItemTapped: _handleOnSearchHistoryItemTapped,
      onSearchFieldFocused: _handleOnSearchFieldFocused,
      onFetchMoreDataRequested: _fetchData,
      onRefresh: () => _fetchData(shouldFetchFreshData: true),
    );
  }

  void _handleOnSearchButtonPressed(String newSearchQuery) {
    _performSearch(newSearchQuery);
  }

  void _handleOnSearchHistoryItemTapped(String searchQueryItem) {
    _searchQueryFieldController.text = searchQueryItem;
    _performSearch(searchQueryItem);
  }

  void _handleOnSearchFieldFocused() {
    if (_searchPageMode == SearchPageMode.searching) {
      this._setWillPopResult(WillPopResult.switchSearchPageMode);
    } else {
      this._setWillPopResult(WillPopResult.pop);
    }

    this._setSearchPageMode(SearchPageMode.editingSearchQuery);
  }

  Future<bool> _handleWillPop(BuildContext context) {
    final Future<bool> shouldPop = Future.value(true);
    final Future<bool> shouldNotPop = Future.value(false);

    switch (_willPopResult) {
      case WillPopResult.switchSearchPageMode:
        requestFocus(context);
        setState(() {
          _searchPageMode = SearchPageMode.searching;
          _willPopResult = WillPopResult.pop;
        });
        return shouldNotPop;
      case WillPopResult.pop:
      default:
        return shouldPop;
    }
  }

  void _performSearch(String newSearchQuery) {
    setState(() {
      _searchPageMode = SearchPageMode.searching;
    });

    if (!_isSearchQueryEmpty()) {
      dbSearchQueries.createSearchQuery(newSearchQuery);
      _fetchData(shouldFetchFreshData: true);
    }
  }

  Future<void> _fetchData({bool shouldFetchFreshData = false}) async {
    _setStateBeforeLoading(shouldFetchFreshData);

    List newData =
        await api.fetchImages(_searchQueryFieldController.text, _pageNumber);

    _setStateAfterLoading(newData);
  }

  void _setStateBeforeLoading(bool shouldClearPrevResults) {
    if (!this.mounted) return;

    setState(() {
      if (shouldClearPrevResults) {
        _imageList.clear();
      }
      _isLoadingData = true;
      _pageNumber += 1;
    });
  }

  void _setStateAfterLoading(List<models.ImageModel> data) {
    if (!this.mounted) return;

    setState(() {
      _imageList.addAll(data);
      _isLoadingData = false;
    });
  }

  void _setSearchPageMode(SearchPageMode searchPageMode) {
    setState(() {
      _searchPageMode = searchPageMode;
    });
  }

  void _setWillPopResult(WillPopResult willPopResult) {
    setState(() {
      _willPopResult = willPopResult;
    });
  }

  bool _isSearchQueryEmpty() {
    return (_searchQueryFieldController.text ?? '').isEmpty;
  }
}
