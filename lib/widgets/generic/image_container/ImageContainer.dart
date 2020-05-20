import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:searchimages/database/models/Image.dart' show ImageUrlTypes;
import 'package:searchimages/database/models/main.dart' as models;

class ImageContainer extends StatelessWidget {
  final models.ImageModel _image;
  final ImageUrlTypes imageDisplaySize;

  ImageContainer(this._image, {this.imageDisplaySize = ImageUrlTypes.THUMB});

  Widget _buildImageLoadingPlaceholder(BuildContext context, String url) {
    return Container(
      child: Text(_image.altDesc ?? ''),
      color: Colors.deepOrange,
      width: _image.getWidth(urlType: imageDisplaySize).toDouble(),
      height: _image.getHeight(urlType: imageDisplaySize).toDouble(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: _image.id,
      child: CachedNetworkImage(
        imageUrl: _image.getUrl(imageDisplaySize),
        placeholder: _buildImageLoadingPlaceholder,
      ),
    );
  }
}
