import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:searchimages/database/controllers/images.dart' as imagesDb;
import 'package:searchimages/database/models/Favorite.dart';
import 'package:searchimages/database/models/Image.dart';
import 'package:searchimages/widgets/generic/image_grid_view/ImageGridView.dart';

class FavoritesImageGridView extends StatefulWidget {
  final List<Favorite> favorites;
  final Widget loaderWidget;
  final Widget errorWidget;
  final VoidCallback onRefresh;

  const FavoritesImageGridView({
    @required this.favorites,
    @required this.loaderWidget,
    @required this.errorWidget,
    @required this.onRefresh,
  });

  @override
  _FavoritesImageGridViewState createState() => _FavoritesImageGridViewState();
}

class _FavoritesImageGridViewState extends State<FavoritesImageGridView> {
  Future<List<ImageModel>> _imageListFuture;

  @override
  void initState() {
    super.initState();
    _imageListFuture = _getImageList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _imageListFuture,
      builder: _favoritesBuilder,
    );
  }

  Widget _favoritesBuilder(
    BuildContext context,
    AsyncSnapshot<List<ImageModel>> snapshot,
  ) {
    // <space> I'm not liking the body so close to the function definition :p
    if (snapshot.connectionState == ConnectionState.done) {
      return _buildDataLoaded(snapshot.data);
    }

    if (snapshot.hasError) return this.widget.errorWidget;

    return this.widget.loaderWidget;
  }

  Widget _buildDataLoaded(List<ImageModel> imageList) {
    if (imageList == null || imageList.isEmpty) {
      return _buildEmptyData();
    }
    return _buildImageGrid(imageList);
  }

  Widget _buildEmptyData() {
    return Center(child: Text('Empty :('));
  }

  Widget _buildImageGrid(List<ImageModel> imageList) {
    return ImageGridView(imageList, onRefresh: widget.onRefresh);
  }

  Future<List<ImageModel>> _getImageList() async {
    List<ImageModel> _imageList = new List<ImageModel>();

    FutureOr<void> getImageFromFavorite(Favorite favorite) async {
      ImageModel imageModel = await imagesDb.getImage(favorite.imageId);
      _imageList.add(imageModel);
    }

    await Future.forEach<Favorite>(widget.favorites, getImageFromFavorite);

    return Future.value(_imageList);
  }
}
