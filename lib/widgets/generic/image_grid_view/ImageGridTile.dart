import 'package:flutter/material.dart';

import 'package:searchimages/database/models/main.dart' as models;
import 'package:searchimages/widgets/generic/image_container/ImageContainer.dart';
import 'package:searchimages/widgets/image_details/ImageDetails.dart';
import 'package:searchimages/widgets/generic/image_container/ImageActions.dart'
    show ImageActions;

class ImageGridTile extends StatelessWidget {
  final models.ImageModel _image;

  ImageGridTile(this._image);

  Widget _buildImage(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ImageDetails(_image)),
      ),
      child: ImageContainer(_image),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 5, offset: Offset(0.5, 2))
        ],
      ),
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[_buildImage(context), ImageActions(this._image)],
      ),
    );
  }
}
