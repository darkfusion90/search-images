import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:searchimages/database/config.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DeleteDatabaseDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(child: _buildDialogContent(context));
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(bottom: 16.0),
            child: Text('Delete all database data?'),
          ),
          _buildDialogActions(context),
        ],
      ),
    );
  }

  Widget _buildDialogActions(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        _buildCancelAction(context),
        _buildDeleteAction(context),
      ],
    );
  }

  Widget _buildCancelAction(BuildContext context) {
    return RaisedButton(
      child: Text('Cancel'),
      onPressed: () => _handleGeneralButtonPressed(context),
    );
  }

  Widget _buildDeleteAction(BuildContext context) {
    return RaisedButton(
      child: Text('Delete'),
      onPressed: () {
        _deleteDatabase();
        _handleGeneralButtonPressed(context);
      },
      color: Colors.red,
    );
  }

  void _deleteDatabase() async {
    final String appDatabasePath = path.join(
      await getDatabasesPath(),
      dbConfig['db_name'],
    );

    deleteDatabase(appDatabasePath);
  }

  void _handleGeneralButtonPressed(BuildContext context) {
    Navigator.of(context).pop();
  }
}
