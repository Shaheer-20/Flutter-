import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../widgets/custom_drawer.dart';

class home_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('document_reader_app'),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => pickFile(context, 'pdf'),
              child: Text('Pick PDF File'),
            ),
            ElevatedButton(
              onPressed: () => pickFile(context, 'excel'),
              child: Text('Pick Excel File'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickFile(BuildContext context, String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      String filePath = result.files.single.path!;
      if (type == 'pdf') {
        Navigator.pushNamed(context, '/pdf', arguments: filePath);
      } else if (type == 'excel') {
        Navigator.pushNamed(context, '/excel', arguments: filePath);
      }
    }
  }
}
