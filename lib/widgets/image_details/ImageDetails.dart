import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:searchimages/database/models/main.dart' as models;
import 'package:searchimages/database/models/Image.dart' show ImageUrlTypes;
import 'package:searchimages/widgets/generic/image_container/ImageContainer.dart';
import 'package:searchimages/widgets/dialogs/image_download/ImageDownloadDialog.dart';
import 'package:searchimages/widgets/appbar/AppBar-ImageDetails.dart';

class ImageDetails extends StatelessWidget {
  final models.ImageModel _image;

  ImageDetails(this._image);

  void _onDownloadButtonPressed(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => ImageDownloadDialog(_image),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarImageDetails(
        onActionDownloadPressed: (BuildContext context) {
          _onDownloadButtonPressed(context);
        },
      ),
      body: _buildContent(context),
    );
  }
  
  Widget _buildContent(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: ImageContainer(
          _image,
          imageDisplaySize: ImageUrlTypes.SMALL,
        ),
      ),
    );
  }
}
