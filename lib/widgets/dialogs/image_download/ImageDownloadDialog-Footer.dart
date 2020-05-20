import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageDownloadDialogFooter extends StatelessWidget {
  final VoidCallback _onDownloadButtonPressed;
  final bool _isDownloading;
  final bool _hasDownloadFinished;
  final double _downloadProgress;

  ImageDownloadDialogFooter(
    this._isDownloading,
    this._hasDownloadFinished,
    this._downloadProgress,
    this._onDownloadButtonPressed,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 16),
          child: _buildDownloadButton(context),
        )
      ],
    );
  }

  Widget _buildDownloadButton(BuildContext context) {
    return RaisedButton(
      child: _buildDownloadButtonText(),
      color: Theme.of(context).primaryColor,
      disabledColor: ThemeData.dark().disabledColor,
      disabledTextColor: Colors.white,
      onPressed: _hasDownloadFinished ? null : this._onDownloadButtonPressed,
    );
  }

  Widget _buildDownloadButtonText() {
    String _getTextWhenDownloadNotFinished() {
      return _isDownloading
          ? 'Downloading (${_downloadProgress.toStringAsFixed(2)}%)'
          : 'Download';
    }

    String downloadText =
        _hasDownloadFinished ? 'Downloaded' : _getTextWhenDownloadNotFinished();

    return Text(downloadText);
  }
}
