import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class _DefaultValues {
  static const int defaultItemsPerRow = 2;
  static const int defaultItemsCount = 0;

  // The amount of offset (in pixels) from the bottom of the screen where if the user scrolls to
  // will be considered as a "reached end of the screen" scenario
  // Defaults to 0 - i.e., the "reached end of the screen" scenario occurs only if the user reaches the
  // far end at the bottom of the screen (Hence, no offset = 0)
  static const int defaultScrollEndOffset = 0;
}

class InfiniteScrollGridView extends StatefulWidget {
  final int _itemsPerRow;
  final int _itemCount;
  final int _scrollEndOffset;
  final IndexedWidgetBuilder _widgetBuilder;
  final Widget _loaderWidget;
  final VoidCallback _onScreenEndReached;

  InfiniteScrollGridView({
    @required VoidCallback onScrollEndReached,
    @required IndexedWidgetBuilder itemBuilder,
    @required Widget loaderWidget,
    int scrollEndOffset = _DefaultValues.defaultScrollEndOffset,
    int itemCount = _DefaultValues.defaultItemsCount,
    int itemsPerRow = _DefaultValues.defaultItemsPerRow,
  })  : assert(itemCount != null && itemCount >= 0),
        assert(itemsPerRow != null && itemsPerRow >= 0),
        assert(onScrollEndReached != null),
        assert(itemBuilder != null),
        assert(loaderWidget != null),
        _itemCount = itemCount,
        _itemsPerRow = itemsPerRow,
        _scrollEndOffset = scrollEndOffset,
        _widgetBuilder = itemBuilder,
        _loaderWidget = loaderWidget,
        _onScreenEndReached = onScrollEndReached;

  @override
  State<StatefulWidget> createState() => _InfiniteScrollGridViewState();
}

class _InfiniteScrollGridViewState extends State<InfiniteScrollGridView> {
  final List<double> _visitedScrollEndPositions = new List<double>();

  @override
  Widget build(BuildContext context) {
    final int _itemCountWithExtraForLoader = widget._itemCount + 1;

    return NotificationListener<ScrollNotification>(
      onNotification: _scrollListener,
      child: StaggeredGridView.countBuilder(
        crossAxisCount: widget._itemsPerRow,
        itemCount: widget._itemCount == 0 ? 0 : _itemCountWithExtraForLoader,
        itemBuilder: _invokeWidgetBuilder,
        staggeredTileBuilder: _buildStaggeredTile,
      ),
    );
  }

  Widget _invokeWidgetBuilder(BuildContext context, int index) {
    if (_hasReachedEndOfItemCount(index)) {
      return widget._loaderWidget;
    }

    return widget._widgetBuilder(context, index);
  }

  StaggeredTile _buildStaggeredTile(index) {
    return StaggeredTile.fit(_getNumberOfCellsThatWillOccupyRow(index));
  }

  int _getNumberOfCellsThatWillOccupyRow(index) {
    final int occupyAllCellsInRow = widget._itemsPerRow;
    final int occupyOneCell = 1;

    return _hasReachedEndOfItemCount(index)
        ? occupyAllCellsInRow
        : occupyOneCell;
  }

  bool _hasPositionAlreadyVisited(double position) {
    return _visitedScrollEndPositions.contains(position);
  }

  bool _hasReachedEndOfItemCount(int index) {
    return index == widget._itemCount;
  }

  //ignore: missing_return
  bool _scrollListener(ScrollNotification scrollNotification) {
    final double scrollPosition = scrollNotification.metrics.pixels;
    final bool alreadyVisited = _hasPositionAlreadyVisited(scrollPosition);

    if (_hasReachedScreenEnd(scrollNotification) && !alreadyVisited) {
      _addNewScrollEndPosition(scrollPosition);
      widget._onScreenEndReached();
    }
  }

  void _addNewScrollEndPosition(double position) {
    setState(() {
      _visitedScrollEndPositions.add(position);
    });
  }

  bool _hasReachedScreenEnd(ScrollNotification scrollNotification) {
    final bool _isScrollPositionBeyondOrAtScreenEnd =
        scrollNotification.metrics.extentAfter <= widget._scrollEndOffset;

    return scrollNotification is ScrollEndNotification &&
        _isScrollPositionBeyondOrAtScreenEnd;
  }
}
