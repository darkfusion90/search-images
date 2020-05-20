import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchimages/database/models/Favorite.dart';
import 'package:searchimages/database/controllers/favorites.dart'
    as favoritesDb;
import 'package:searchimages/widgets/tabs/views/favorites/FavoritesImageGridView.dart';

class FavoritesTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  Future<List<Favorite>> _favoriteListFuture;

  @override
  void initState() {
    super.initState();
    _favoriteListFuture = favoritesDb.getAllFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _favoriteListFuture,
      builder: _futureFavoritesBuilder,
    );
  }

  Widget _futureFavoritesBuilder(
    BuildContext context,
    AsyncSnapshot<List<Favorite>> snapshot,
  ) {
    if (snapshot.connectionState == ConnectionState.done) {
      print('snapshot: ${snapshot.data}');
      return FavoritesImageGridView(
        favorites: snapshot.data,
        loaderWidget: _buildLoader(),
        errorWidget: _buildError(),
        onRefresh: _getFavoriteList,
      );
    } else if (snapshot.hasError) {
      return _buildError();
    }

    return _buildLoader();
  }

  Widget _buildLoader() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError() {
    return Text('Oops :(');
  }

  Future<void> _getFavoriteList() async {
    setState(() {
      _favoriteListFuture = favoritesDb.getAllFavorites();
    });
  }
}
