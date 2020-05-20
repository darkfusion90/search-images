import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:searchimages/utils/widget-based.dart';
import 'package:searchimages/widgets/appbar/BaseAppBar.dart';

class AppBarSearchPage extends BaseAppBar {
  final ValueChanged<String> onSearchButtonPressed;
  final VoidCallback onSearchFieldFocused;
  final TextEditingController searchFieldTextController;

  AppBarSearchPage({
    @required this.onSearchButtonPressed,
    @required this.onSearchFieldFocused,
    @required this.searchFieldTextController,
  });

  @override
  State<StatefulWidget> createState() => _AppBarSearchPage();
}

class _AppBarSearchPage extends State<AppBarSearchPage> {
  final FocusNode _searchFieldFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _requestFocusOnSearchField(this.context);
  }

  @override
  void dispose() {
    _searchFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: _buildSearchField(),
      actions: <Widget>[_buildSearchButton()],
    );
  }

  Widget _buildSearchField() {
    final TextStyle textStyle = TextStyle(color: Colors.white);

    return FocusableActionDetector(
      onFocusChange: _handleSearchFieldFocusChange,
      child: Container(
        decoration: BoxDecoration(
          color: lightenColor(Theme.of(context).primaryColor, 0.05),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
        child: TextField(
          controller: widget.searchFieldTextController,
          focusNode: _searchFieldFocusNode,
          textInputAction: TextInputAction.search,
          onSubmitted: widget.onSearchButtonPressed,
          style: textStyle,
          decoration: InputDecoration(
            hintText: 'Search...',
            hintStyle: textStyle,
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: _handleOnSearchButtonPressed,
    );
  }

  void _handleOnSearchButtonPressed() {
    _removeFocusFromSearchField();
    return widget.onSearchButtonPressed(widget.searchFieldTextController.text);
  }

  void _handleSearchFieldFocusChange(bool hasFocus) {
    if (!hasFocus) return;

    widget.onSearchFieldFocused();
  }

  void _removeFocusFromSearchField() {
    _searchFieldFocusNode.unfocus();
  }

  void _requestFocusOnSearchField(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_searchFieldFocusNode);
    });
  }
}
