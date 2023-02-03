import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Components/generate_pdf.dart';
import '../Models/resume.dart';

Future<String?> getDownloadPath() async {
  Directory? directory;
  try {
    if (Platform.isIOS) {
      directory = await getApplicationDocumentsDirectory();
    } else {
      directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
    }
  } catch (err) {
    Exception(err);
  }
  return directory?.path;
}

Future<Uint8List> generatePdf(Resume resume, BuildContext context) async {
  final pdf = await buildPdf(resume, context);
  return pdf.save();
}

void savePdf(BuildContext context, Resume resume, String title) async {
  final pdf = await buildPdf(resume, context);
  final status = await Permission.storage.request();
  if (!status.isGranted) {
    if (kDebugMode) {
      print("Permission denied");
    }
    return;
  }
  final output = await getDownloadPath();
  try {
    final file = File("$output/${title}.pdf");
    await file.writeAsBytes(await pdf.save());
    showSnackBar(context, AppLocalizations.of(context).succes);
    Navigator.pop(context);
  } catch (err) {
    showSnackBar(context, AppLocalizations.of(context).error);
  }
}

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return _file;
  }
  print('No Image Selected');
}

String idGenerator() {
  final now = DateTime.now();
  return now.microsecondsSinceEpoch.toString();
}
