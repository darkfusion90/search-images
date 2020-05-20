import 'package:flutter/material.dart';
import 'package:searchimages/widgets/appbar/BaseAppBar.dart';

class AppBarImageDetails extends BaseAppBar {
  final void Function(BuildContext context) onActionDownloadPressed;

  AppBarImageDetails({@required this.onActionDownloadPressed});

  @override
  State<StatefulWidget> createState() => _AppBarDownloadsState();
}

class _AppBarDownloadsState extends State<AppBarImageDetails> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black,
      actions: _buildAppBarActions(context),
    );
  }

  List<Widget> _buildAppBarActions(BuildContext context) {
    return [_buildActionDownload(context)];
  }

  Widget _buildActionDownload(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.save_alt),
      onPressed: () => widget.onActionDownloadPressed(context),
    );
  }
}
