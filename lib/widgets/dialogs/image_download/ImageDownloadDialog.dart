import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:searchimages/database/models/main.dart' as models;
import 'package:searchimages/database/models/Image.dart' show ImageUrlTypes;
import 'package:searchimages/utils/ImageDownloader.dart';
import 'package:searchimages/widgets/dialogs/image_download/ImageDownloadDialog-Body.dart';
import 'package:searchimages/widgets/dialogs/image_download/ImageDownloadDialog-Footer.dart';
import 'package:searchimages/widgets/dialogs/image_download/ImageDownloadDialog-Title.dart';

class ImageDownloadDialog extends StatefulWidget {
  final models.ImageModel _image;

  ImageDownloadDialog(this._image);

  @override
  State<StatefulWidget> createState() => _ImageDownloadDialogState();
}

class _ImageDownloadDialogState extends State<ImageDownloadDialog> {
  static const double OUTER_CONTAINER_PADDING = 16.0;
  static const Color DEFAULT_FONT_COLOR = Colors.white;

  ImageUrlTypes _selectedDownloadOption = ImageUrlTypes.FULL;
  bool _isDownloading = false;
  bool _hasDownloadFinished = false;
  double _downloadProgress = 0;

  @override
  Widget build(BuildContext context) {
    print(
        '_isDownloading: $_isDownloading\tdownloadProgress: $_downloadProgress');
    return Dialog(
      child: _buildDialogContent(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return DefaultTextStyle(
      child: Container(
        margin: EdgeInsets.all(OUTER_CONTAINER_PADDING),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildDialogTitle(),
            _buildDialogBody(context),
            _buildDialogFooter(context)
          ],
        ),
      ),
      style: TextStyle(color: DEFAULT_FONT_COLOR),
    );
  }

  Widget _buildDialogTitle() {
    return ImageDownloadDialogTitle(DEFAULT_FONT_COLOR);
  }

  Widget _buildDialogBody(BuildContext context) {
    return ImageDownloadDialogBody(
      widget._image,
      _selectedDownloadOption,
      _handleOnSelectedRadioOptionChange,
      DEFAULT_FONT_COLOR,
    );
  }

  Widget _buildDialogFooter(BuildContext context) {
    return ImageDownloadDialogFooter(
      _isDownloading,
      _hasDownloadFinished,
      _downloadProgress,
      _handleOnDownloadButtonPressed,
    );
  }

  void _handleOnSelectedRadioOptionChange(ImageUrlTypes selected) {
    setState(() {
      _selectedDownloadOption = selected;
      //allow users to download again (if some resolution was downloaded before) when the selected radio changes
      _hasDownloadFinished = false;
    });
  }

  Future<void> _handleOnDownloadButtonPressed() async {
    setState(() {
      _isDownloading = true;
    });

    await _downloadImage();

    setState(() {
      _isDownloading = false;
      _hasDownloadFinished = true;
    });
  }

  void _handleOnDownloadProgressUpdate(int downloaded, int toDownload) {
    final double downloadProgress = (downloaded / toDownload) * 100;
    setState(() {
      _downloadProgress = downloadProgress;
    });
  }

  Future<void> _downloadImage() async {
    try {
      await ImageDownloader(
        widget._image,
        _selectedDownloadOption,
        _handleOnDownloadProgressUpdate,
      ).startDownload();
    } catch (on, stackTrace) {
      print('Download error: $on\nStackTrace: $stackTrace');
    }
  }
}
