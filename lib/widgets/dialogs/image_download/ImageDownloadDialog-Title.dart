import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDownloadDialogTitle extends StatelessWidget {
  final Color _fontColor;
  
  ImageDownloadDialogTitle(this._fontColor);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8, bottom: 24),
      child: Column(
        children: <Widget>[
          Text(
            'Download Image',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
              color: _fontColor,
            ),
          ),
          Divider(color: _fontColor)
        ],
      ),
    );
  }
}
