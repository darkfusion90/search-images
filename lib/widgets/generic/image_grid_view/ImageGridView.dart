import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:searchimages/widgets/generic/infinite_scroll_grid_view/InfiniteScrollGridView.dart';

import 'ImageGridTile.dart' show ImageGridTile;
import 'package:searchimages/database/models/main.dart' as models;

class ImageGridView extends StatefulWidget {
  final List<models.ImageModel> _imageList;
  final bool isInfiniteScroll;
  final VoidCallback fetchMoreData;
  final VoidCallback onRefresh;

  ImageGridView(
    this._imageList, {
    this.isInfiniteScroll = false,
    this.fetchMoreData,
    this.onRefresh,
  });

  @override
  State<StatefulWidget> createState() => _ImageGridViewState();
}

class _ImageGridViewState extends State<ImageGridView> {
  static const int ITEMS_PER_ROW = 2;
  static const int FIT_ONE_ITEM_PER_CELL_IN_ROW = 1;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: _buildBody(),
      onRefresh: widget.onRefresh,
    );
  }

  Widget _buildBody() {
    if (widget.isInfiniteScroll) {
      return InfiniteScrollGridView(
        itemCount: widget._imageList.length,
        itemsPerRow: ITEMS_PER_ROW,
        itemBuilder: _buildGridTile,
        loaderWidget: _buildLoaderFooter(),
        onScrollEndReached: widget.fetchMoreData,
      );
    }

    return StaggeredGridView.countBuilder(
      crossAxisCount: ITEMS_PER_ROW,
      itemCount: widget._imageList.length,
      itemBuilder: _buildGridTile,
      staggeredTileBuilder: _buildStaggeredTile,
    );
  }

  StaggeredTile _buildStaggeredTile(index) =>
      StaggeredTile.fit(FIT_ONE_ITEM_PER_CELL_IN_ROW);

  Widget _buildGridTile(BuildContext context, int index) {
    return ImageGridTile(widget._imageList[index]);
  }

  Widget _buildLoaderFooter() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
      padding: EdgeInsets.all(16.0),
    );
  }
}
