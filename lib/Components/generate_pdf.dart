import 'package:flutter/material.dart' as mt;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:printing/printing.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Models/resume.dart';

Future<Document> buildPdf(Resume resume, mt.BuildContext buContext) async {
  final pdf = Document();
  Widget avatar = Container();

  if (resume.image != null) {
    MemoryImage memoryImage = pw.MemoryImage(resume.image!.readAsBytesSync());
    avatar = pw.ClipOval(
      child: pw.Container(
        //width: 60, height: 60,
        child:
            pw.Image(memoryImage, width: 60, height: 60, fit: BoxFit.fitWidth),
      ),
    );
  }

  pdf.addPage(
    Page(
      pageFormat: PdfPageFormat.a5,
      margin: const EdgeInsets.all(15),
      build: (context) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (resume.image != null)
                  Row(children: [avatar, SizedBox(width: 10)]),
                Expanded(
                  child: Column(
                    children: [
                      Text("${resume.name}",
                          style: TextStyle(
                              fontSize: 11, fontWeight: pw.FontWeight.bold)),
                      Text("${resume.title}",
                          style: const TextStyle(fontSize: 10)),
                      Text("${resume.bio}",
                          style: const TextStyle(fontSize: 8)),
                    ],
                    crossAxisAlignment: CrossAxisAlignment.start,
                  ),
                )
              ],
            ),
            SizedBox(height: 15),
            Divider(thickness: 2, color: PdfColors.grey100),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text("${resume.phone}", style: const TextStyle(fontSize: 8)),
              Text("${resume.email}", style: const TextStyle(fontSize: 8)),
              Text("${resume.location}", style: const TextStyle(fontSize: 8)),
            ]),
            Divider(thickness: 2, color: PdfColors.grey100),
            SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    //color: PdfColors.redAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (resume.works.isNotEmpty)
                          Text(AppLocalizations.of(buContext).workExperience,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                        SizedBox(height: 5),
                        for (Works i in resume.works)
                          Column(
                            children: [
                              Text("${i.title}",
                                  style: const TextStyle(fontSize: 10)),
                              Text("${i.enterpraise}",
                                  style: const TextStyle(fontSize: 9)),
                              Text("${i.description}",
                                  style: const TextStyle(fontSize: 7)),
                              SizedBox(height: 15)
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    //color: PdfColors.lightBlueAccent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (resume.education.isNotEmpty)
                          Text(AppLocalizations.of(buContext).education,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                        SizedBox(height: 5),
                        for (Education i in resume.education)
                          Column(
                            children: [
                              Text("${i.title}",
                                  style: const TextStyle(fontSize: 10)),
                              Text("${i.school}",
                                  style: const TextStyle(fontSize: 9)),
                              Text("${i.description}",
                                  style: const TextStyle(fontSize: 7)),
                              SizedBox(height: 15)
                            ],
                            crossAxisAlignment: CrossAxisAlignment.start,
                          ),
                        if (resume.skills.isNotEmpty)
                          Text(AppLocalizations.of(buContext).skills,
                              style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                        SizedBox(height: 5),
                        Wrap(
                          spacing: 3,
                          runSpacing: 3,
                          children: resume.skills
                              .map((item) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5, vertical: 3),
                                    decoration: BoxDecoration(
                                        color: PdfColors.black,
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Text("${item.title}",
                                        style: const TextStyle(
                                            fontSize: 8,
                                            color: PdfColors.white)),
                                  ))
                              .toList()
                              .cast<Widget>(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    ),
  );
  return pdf;
}
