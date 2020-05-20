import 'package:flutter/material.dart';
import 'package:searchimages/database/models/main.dart' as models;
import 'package:searchimages/database/controllers/favorites.dart' as favorites;

class ImageActions extends StatefulWidget {
  final models.ImageModel _image;

  ImageActions(this._image);

  @override
  State<StatefulWidget> createState() => _ImageActionsState();
}

class _ImageActionsState extends State<ImageActions> {
  bool _isAlreadyFavorite = false;

  @override
  void initState() {
    super.initState();
    _updateAlreadyFavorite();
  }

  @override
  void didUpdateWidget(ImageActions oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateAlreadyFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: _buildActions(),
      ),
    );
  }

  List<Widget> _buildActions() {
    return [
      Tooltip(
        child: IconButton(
          padding: EdgeInsets.all(0),
          icon: _buildFavoriteIcon(),
          onPressed: _handleOnFavoriteIconButtonPressed,
        ),
        message: 'Add To Favorites',
      )
    ];
  }

  Icon _buildFavoriteIcon() {
    return Icon(
      this._isAlreadyFavorite ? Icons.favorite : Icons.favorite_border,
    );
  }

  void _handleOnFavoriteIconButtonPressed() {
    if (this._isAlreadyFavorite) {
      _removeFromFavorites(widget._image);
    } else {
      _addToFavorites(widget._image);
    }
  }

  void _addToFavorites(models.ImageModel image) async {
    await favorites.createFavorite(image);
    _updateAlreadyFavorite();
  }

  void _removeFromFavorites(models.ImageModel image) async {
    await favorites.deleteFavorite(image);
    _updateAlreadyFavorite();
  }

  void _updateAlreadyFavorite() async {
    bool isFav = await favorites.isImageFavorite(widget._image);
    _safeSetState(() {
      _isAlreadyFavorite = isFav;
    });
  }

  void _safeSetState(Function fn) {
    if (!this.mounted) return;

    setState(fn);
  }
}
