import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'dart:io';

class excel_view_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String filePath =
        ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text('Excel Viewer'),
      ),
      body: FutureBuilder(
        future: loadExcel(filePath),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return ListView(
                children: snapshot.data as List<Widget>,
              );
            } else {
              return Center(child: Text('Failed to load Excel file'));
            }
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<List<Widget>> loadExcel(String filePath) async {
    var file = File(filePath);
    var bytes = file.readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    List<Widget> widgets = [];
    for (var table in excel.tables.keys) {
      widgets.add(Text('Sheet: $table'));
      for (var row in excel.tables[table]!.rows) {
        widgets.add(
            Text(row.map((cell) => cell?.value.toString() ?? '').join(' | ')));
      }
    }
    return widgets;
  }
}
