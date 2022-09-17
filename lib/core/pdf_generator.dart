import 'dart:io';

import 'package:flutter/services.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart';
import 'package:pharmacy_app/core/app_sizes.dart';
import 'package:pharmacy_app/core/constants.dart';

import 'package:path_provider/path_provider.dart' as p;
import 'package:permission_handler/permission_handler.dart';
import 'package:pharmacy_app/models/response_data_models/facture_model.dart';

class PdfApi {
  static Future<File> generatePdf(String text, Facture facture) async {
    final pdf = Document();
    final customFont = Font.ttf(await rootBundle.load("assets/fonts/Poppins-Regular.ttf"));
    
    final logoImage =
        (await rootBundle.load("assets/images/logo.png")).buffer.asUint8List();

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
                    Image(MemoryImage(logoImage),
                        width: 50, height: 50, fit: BoxFit.fill),
                    SizedBox(width: 0.5 * PdfPageFormat.cm),
                    Text("Pocket Pharma",
                        style: TextStyle(
                          //font: customFont,
                          color: PdfColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                    Spacer(),
                    PdfLogo(fit: BoxFit.fill),
                  ],
                ),
              ),
              SizedBox(height: kDefaultPadding*1.5),
              buildCustomHeader(text, customFont),
              SizedBox(height: kDefaultPadding),
              buildLink(facture, customFont),
              SizedBox(height: kDefaultPadding*1.5),
              buildTableHeader(),
              ...List.generate(
                facture.produits!.length,
                (index) => buildTableRow(facture, index, customFont),
              ),
              buildTableFooter(facture, customFont),
              SizedBox(height: kDefaultPadding * 2),
              Paragraph(
                text: "NB: ${facture.note!.toString()}",
                style: TextStyle(font: customFont, fontSize: 16),
              ),
              SizedBox(height: kDefaultPadding / 2),
              Row(children: <Widget>[
                Spacer(),
                Paragraph(
                  text:
                      "Etablie par: ${facture.username!.toString().toUpperCase()}",
                  style: TextStyle(font: customFont, fontSize: 16),
                ),
              ]),
            ],
        footer: (context) {
          String text = "Page ${context.pageNumber} sur ${context.pagesCount}";
          return buildFooter(text);
        }));

    return saveDocument(
        filename:
            'Facture-PP-${facture.id!.toString().padLeft(2, '0')}-du-${facture.createdToString()}-${facture.hourToString()}.pdf',
        pdf: pdf);
  }

  static Container buildTableFooter(Facture facture, Font font) {
    return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PdfColors.black,
                        width: 0.9,
                      ),
                    ),
                    child: Text("Total",
                        style: TextStyle(
                          // font: font,
                          color: PdfColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PdfColors.black,
                        width: 0.9,
                      ),
                    ),
                    child: Text(facture.quantiteTotal.toString(),
                        style: TextStyle(
                          color: PdfColors.black,
                          fontSize: 18,
                          // font: font,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PdfColors.black,
                        width: 0.9,
                      ),
                    ),
                    child: Text("${facture.montantTotal!} F",
                        style: TextStyle(
                          color: PdfColors.black,
                          fontSize: 18,
                          // font: font,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ]),
            );
  }

  static Container buildTableRow(Facture facture, int index, Font font) {
    return Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Row(children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: PdfColors.black,
                          width: 0.9,
                        ),
                      ),
                      child: Text(facture.produits![index].productName!,
                          style: TextStyle(
                            color: PdfColors.black,
                            fontSize: 16,
                            font: font,
                          )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: PdfColors.black,
                          width: 0.9,
                        ),
                      ),
                      child:
                          Text(facture.produits![index].quantite!.toString(),
                              style: TextStyle(
                                color: PdfColors.black,
                                fontSize: 16,
                                font: font,
                              )),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: PdfColors.black,
                          width: 0.9,
                        ),
                      ),
                      child: Text(
                          "${facture.produits![index].montant! * facture.produits![index].quantite!} F",
                          style: TextStyle(
                            color: PdfColors.black,
                            fontSize: 16,
                            font: font,
                          )),
                    ),
                  ),
                ]),
              );
  }

  static Container buildTableHeader() {
    return Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(children: <Widget>[
                Expanded(
                  flex: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PdfColors.black,
                        width: 0.9,
                      ),
                    ),
                    child: Text("Nom du produit",
                        style: TextStyle(
                          color: PdfColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PdfColors.black,
                        width: 0.9,
                      ),
                    ),
                    child: Text("Quantité",
                        style: TextStyle(
                          color: PdfColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 3),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: PdfColors.black,
                        width: 0.9,
                      ),
                    ),
                    child: Text("Prix",
                        style: TextStyle(
                          color: PdfColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ),
              ]),
            );
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
              fontSize: 14,
              color: PdfColors.black,
              fontWeight: FontWeight.bold,
            )));
  }

  static Future<File> saveDocument(
      {required String filename, required Document pdf}) async {
    final bytes = await pdf.save();
    File? file;

    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = await p.getExternalStorageDirectory();
          String newPath = "";

          List<String> folders = directory!.path.split("/");

          for (int x = 1; x < folders.length; x++) {
            String folder = folders[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/Download";
          directory = Directory(newPath);

          if (!await directory.exists()) {
            await directory.create(recursive: true);
          }
          if (await directory.exists()) {
            file = File("${directory.path}/$filename");
            await file.writeAsBytes(bytes);
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return file!;
  }

  static Future openFile(File file) async {
    final url = file.path;
    await OpenFile.open(url);
  }

  static Widget buildLink(
    Facture facture,
    Font font,
  ) =>
      UrlLink(
        destination: '${Constants.API_URL}/utilisateurs/pdf/',
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
              'Facture code:${facture.id!.toString().padLeft(2, '0')}',
              style: TextStyle(
                color: PdfColors.blue,
                fontSize: 16,
                font: font,
                decoration: TextDecoration.underline,
              )),
          Text('Le: ${facture.createdToString()} à ${facture.hourToString()}',
              style: TextStyle(
                color: PdfColors.blue,
                fontSize: 16,
                font: font,
                decoration: TextDecoration.underline,
              ))
        ]),
      );

  static Widget buildCustomHeader(String title, Font font) => Header(
          child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Text(title,
        textAlign: TextAlign.center,
            style: TextStyle(
              color: PdfColors.white,
              fontSize: 20,
              font: font,
              fontWeight: FontWeight.bold,
            )),
        decoration: const BoxDecoration(
          color: PdfColors.black,
        ),
      ));

  static Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
