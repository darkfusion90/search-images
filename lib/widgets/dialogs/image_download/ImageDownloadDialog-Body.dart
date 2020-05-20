import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:searchimages/database/models/Image.dart' show ImageUrlTypes;
import 'package:searchimages/database/models/main.dart' as models;
import 'ImageDownloadOptions.dart';

class ImageDownloadDialogBody extends StatelessWidget {
  final models.ImageModel _image;
  final ImageUrlTypes _selectedDownloadOption;
  final ValueChanged<ImageUrlTypes> _onSelectedDownloadOptionChanged;
  final Color _fontColor;

  ImageDownloadDialogBody(
    this._image,
    this._selectedDownloadOption,
    this._onSelectedDownloadOptionChanged,
    this._fontColor,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildOptionsLabel(),
          _buildOptions(),
        ],
      ),
    );
  }

  Widget _buildOptionsLabel() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Text(
        'Select Resolution:',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  Widget _buildOptions() {
    return ImageDownloadOptions(
      _image,
      _selectedDownloadOption,
      _onSelectedDownloadOptionChanged,
      fontColor: _fontColor,
    );
  }
}
