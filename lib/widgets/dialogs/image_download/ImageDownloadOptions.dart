import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:searchimages/database/models/main.dart' as models;
import 'package:searchimages/database/models/Image.dart' show ImageUrlTypes;

class ImageDownloadOptions extends StatelessWidget {
  final List<ImageUrlTypes> _imageDownloadOptions = [
    ImageUrlTypes.FULL,
    ImageUrlTypes.REGULAR,
    ImageUrlTypes.THUMB,
    ImageUrlTypes.SMALL,
  ];

  final models.ImageModel _image;
  final Color fontColor;
  final ImageUrlTypes _selectedRadio;
  final ValueChanged<ImageUrlTypes> _onSelectedDownloadOptionChanged;

  ImageDownloadOptions(
      this._image, this._selectedRadio, this._onSelectedDownloadOptionChanged,
      {this.fontColor = Colors.black});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(unselectedWidgetColor: fontColor),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: _imageDownloadOptions.length,
        itemBuilder: (BuildContext context, int index) => _buildRadio(index),
      ),
    );
  }

  Widget _buildRadio(int index) {
    ImageUrlTypes _imageUrlType = _imageDownloadOptions[index];

    return ListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(
        _getTitle(_imageUrlType),
        style: TextStyle(color: fontColor),
      ),
      leading: Radio<ImageUrlTypes>(
        value: _imageUrlType,
        groupValue: _selectedRadio,
        onChanged: _handleOnRadioChange,
      ),
      onTap: () => _setSelectedRadioOption(_imageUrlType),
    );
  }

  String _getTitle(ImageUrlTypes _imageUrlType) {
    String _createTitle({String other}) {
      final int _width = _image.getWidth(urlType: _imageUrlType);
      final int _height = _image.getHeight(urlType: _imageUrlType);
      final String _additional = other == null ? '' : '($other)';

      return '$_width X $_height $_additional';
    }

    switch (_imageUrlType) {
      case ImageUrlTypes.FULL:
        return _createTitle(other: 'Original');
      default:
        return _createTitle();
    }
  }

  void _handleOnRadioChange(ImageUrlTypes _imageUrlType) {
    _setSelectedRadioOption(_imageUrlType);
  }

  void _setSelectedRadioOption(ImageUrlTypes _imageUrlType) {
    _onSelectedDownloadOptionChanged(_imageUrlType);
  }
}
