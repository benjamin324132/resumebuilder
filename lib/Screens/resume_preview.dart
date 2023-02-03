import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:resumebuilder/Utils/constants.dart';
import 'package:resumebuilder/Utils/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Models/resume.dart';

class ResumePrevie extends StatefulWidget {
  const ResumePrevie({Key? key, required this.resume}) : super(key: key);
  final Resume resume;

  @override
  State<ResumePrevie> createState() => _ResumePrevieState();
}

class _ResumePrevieState extends State<ResumePrevie> {
  TextEditingController _textFieldController = TextEditingController();

  Future<String?> saveResumeDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(AppLocalizations.of(context).saveResume),
            content: TextField(
              controller: _textFieldController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).resumeName),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: Text(AppLocalizations.of(context).cancel),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () => {
                  if (_textFieldController.text.isNotEmpty)
                    {
                      savePdf(
                          context, widget.resume, _textFieldController.text),
                    }
                  else
                    {
                      showSnackBar(
                          context, AppLocalizations.of(context).addName)
                    }
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext buContext) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          saveResumeDialog(context);
        },
        child: const Icon(Icons.save),
      ),
      body: PdfPreview(
        build: (context) => generatePdf(widget.resume, buContext),
        useActions: false,
      ),
    );
  }
}
