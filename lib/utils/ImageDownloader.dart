import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:path/path.dart' as path;
import 'package:intl/intl.dart' show DateFormat;
import 'package:dio/dio.dart';

import 'package:searchimages/database/models/main.dart' as models;
import 'package:searchimages/database/models/Image.dart' show ImageUrlTypes;

class ImageDownloader {
  static const String _APPLICATION_DOWNLOADS_DIRECTORY = 'image-finder';
  final Dio _dio = Dio();
  final DateFormat _formatter = DateFormat('yyyyMMdd_HHmmss');
  final models.ImageModel _image;
  final ImageUrlTypes _imageUrlType;
  final Function(int, int) _onDownloadProgress;

  ImageDownloader(this._image, this._imageUrlType, this._onDownloadProgress);

  Future<io.Directory> _getApplicationDownloadsDirectory() async {
    final io.Directory deviceDownloadDir =
        await pathProvider.getExternalStorageDirectory();

    final String absoluteAppDownloadDir =
        path.join(deviceDownloadDir.path, _APPLICATION_DOWNLOADS_DIRECTORY);

    return io.Directory(absoluteAppDownloadDir).create(recursive: true);
  }

  String _constructTimeStamp() {
    final DateTime currentDateTime = DateTime.now();
    return _formatter.format(currentDateTime);
  }

  String _constructFileName() {
    return '${_image.id}_${_constructTimeStamp()}.jpg';
  }

  Future<String> _constructFileDownloadPath() async {
    final io.Directory _appDownloadsDir =
        await _getApplicationDownloadsDirectory();

    return path.join(_appDownloadsDir.path, _constructFileName());
  }

  Future<void> startDownload() async {
    final String url = _image.getUrl(_imageUrlType);
    await _dio.download(
      url,
      await _constructFileDownloadPath(),
      onReceiveProgress: _onDownloadProgress,
    );
  }
}
