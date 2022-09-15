import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/constants.dart';

import 'package:path_provider/path_provider.dart' as p;
import 'package:permission_handler/permission_handler.dart';

class PdfApi {
  static Future<File> generatePdf(String text) async {
    final pdf = Document();
    final customFont = Font.ttf(await rootBundle.load("assets/fonts/Poppins-Regular.ttf"));
    // final logoImage = (await rootBundle.load("assets/images/logo.png")).buffer.asUnit8List();

    pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: kDefaultPadding / 3),
                decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 2, color: PdfColors.blue)),
                ),
                child: Row(
                  children: <Widget>[
                    //AssetImage("assets/images/logo.png"),
                    PdfLogo(),
                    SizedBox(width: 0.5 * PdfPageFormat.cm),
                    Text("Créer ton pdf ",
                        style: const TextStyle(
                          color: PdfColors.black,
                          fontSize: 16,
                        )),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding),
              buildCustomHeader(text),
              buildLink(),
              SizedBox(height: kDefaultPadding / 2),
              Paragraph(text: LoremText().paragraph(60)),
              Paragraph(text: LoremText().paragraph(800)),
              Paragraph(text: LoremText().paragraph(20)),
              Paragraph(text: LoremText().paragraph(6000),
                style: TextStyle(font: customFont),
              ),
              Paragraph(text: LoremText().paragraph(230)),
            ],
        footer: (context) {
          String text = "Page ${context.pageNumber} sur ${context.pagesCount}";
          return buildFooter(text);
        }));

    return saveDocument(filename: 'Exemple.pdf', pdf: pdf);
  }

  static Container buildFooter(String text) {
    return Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(top: kDefaultPadding / 2),
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(width: 2, color: PdfColors.blue)),
        ),
        child: Text(text,
            style: TextStyle(
              fontSize: 16,
              color: PdfColors.black,
              fontWeight: FontWeight.bold,
            )));
  }

  static Future<File> saveDocument({required String filename, required Document pdf}) async {
    final bytes = await pdf.save();
    File? file;

    Directory? directory; 
    try {
      if (Platform.isAndroid) {
        if ( await _requestPermission(Permission.storage)) {
          directory = await p.getExternalStorageDirectory();
          String newPath = "";

          List<String> folders = directory!.path.split("/");

          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/$folder";
            }
            else {
              break;
            }
          }
          newPath = "$newPath/Download";
          directory = Directory(newPath);

          if ( !await directory.exists() ) {
            await directory.create( recursive: true );
          }
          if ( await directory.exists() ) {
            file = File("${directory.path}/$filename");
            await file.writeAsBytes(bytes);
          }
        }

      }
    }
    catch (e) {
      print(e);
    }
    return file!;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static Widget buildLink() => UrlLink(
        destination: '${Constants.API_URL}/utilisateurs/pdf/',
        child: Text('Obtenir le pdf',
            style: const TextStyle(
              color: PdfColors.blue,
              fontSize: 16,
              decoration: TextDecoration.underline,
            )),
      );

  static Widget buildCustomHeader(String title) => Header(
        child: Text(title,
            style: TextStyle(
              color: PdfColors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              // decoration: TextDecoration.underline,
            )),
        padding: const EdgeInsets.all(4),
        decoration: const BoxDecoration(
          color: PdfColors.black,
        ),
      );


  static Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    }
    else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
      else {
        return false;
      }
    }
  }
}
