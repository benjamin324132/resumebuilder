import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:resumebuilder/Utils/constants.dart';
import 'package:resumebuilder/Utils/utils.dart';
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
            title: const Text('Save your resume'),
            content: TextField(
              controller: _textFieldController,
              textCapitalization: TextCapitalization.sentences,
              decoration: const InputDecoration(hintText: "Resume name"),
            ),
            actions: <Widget>[
              ElevatedButton(
                child: const Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
              ElevatedButton(
                child: const Text('OK'),
                onPressed: () => {
                  if (_textFieldController.text.isNotEmpty)
                    {savePdf(context, widget.resume, _textFieldController.text),
                    
                    }
                  else
                    {showSnackBar(context, "Add a valid name")}
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          saveResumeDialog(context);
        },
        child: const Icon(Icons.save),
      ),
      body: PdfPreview(
        build: (context) => generatePdf(widget.resume),
        useActions: false,
      ),
    );
  }
}
