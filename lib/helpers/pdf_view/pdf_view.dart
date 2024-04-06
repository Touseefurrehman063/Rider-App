import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_riderapp/Utilities.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';

class PdfViewerPage extends StatefulWidget {
  final String? testName;
  final String? url;

  const PdfViewerPage({Key? key, this.url, this.testName}) : super(key: key);

  @override
  _PdfViewerPageState createState() => _PdfViewerPageState();
}

class _PdfViewerPageState extends State<PdfViewerPage> {
  String urlPDFPath = "";
  bool exists = true;
  int _totalPages = 0;
  int _currentPage = 0;
  bool pdfReady = false;
  bool loaded = false;
  void sharePdfFile(String filePath) {
    Share.shareFiles([filePath], text: 'Sharing PDF file');
  }

  Future<File> getFileFromUrl(String url, {name}) async {
    var fileName = '${widget.testName}';
    if (name != null) {
      fileName = name;
    }
    try {
      await requestPermission();
      await requestManagement();
      var data = await http.get(Uri.parse(url));
      var bytes = data.bodyBytes;
      var dir = await getApplicationDocumentsDirectory();
      log(dir.path);
      File file = File("${dir.path}/${fileName.trim()}.pdf");
      log(file.path.toString());
      File urlFile = await file.writeAsBytes(bytes);
      return urlFile;
    } catch (e) {
      log(e.toString());
      setState(() {
        loaded = false;
        exists = false;
      });
      Fluttertoast.showToast(msg: e.toString());
      throw Exception("Error opening url file");
    }
  }

  requestPermission() async {
    Permission permission = Permission.storage;
    if (await permission.isGranted) {
      log('test1');
    } else if (await permission.isDenied) {
      log('test2');
      await permission.request();
    } else if (await permission.isPermanentlyDenied) {
      log('test3');
      openAppSettings();
    }
    log(permission.status.toString());
  }

  requestManagement() async {
    Permission permission = Permission.storage;
    Permission management = Permission.manageExternalStorage;
    if (await management.isGranted) {
      log('test1');
    } else if (await management.isDenied) {
      log('test2');
      await management.request();
    } else if (await management.isPermanentlyDenied) {
      log('test3');
      openAppSettings();
    }
    log(permission.status.toString());
  }

  @override
  void initState() {
    log(widget.url.toString());
    getFileFromUrl("$ip2/${widget.url}").then((value) => {
          log('$ip2/${widget.url}'),
          setState(() {
            if (value != null) {
              urlPDFPath = value.path;
              loaded = true;
              exists = true;
            } else {
              exists = false;
            }
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (loaded) {
      return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.blue,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              color: Colors.blue,
              onPressed: () {
                // Implement your sharing functionality here
                // For example:
                if (urlPDFPath != "") {
                  sharePdfFile(urlPDFPath);
                } else {
                  const ScaffoldMessenger(child: Text("URL is not available"));
                }
              },
            ),
          ],
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          elevation: 0.0,
        ),
        body: Center(
          child: PDFView(
            filePath: urlPDFPath,
            autoSpacing: true,
            enableSwipe: true,
            pageSnap: true,
            swipeHorizontal: true,
            nightMode: false,
            onError: (e) {},
            onRender: (pages) {
              setState(() {
                _totalPages = pages!;
                pdfReady = true;
              });
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                _currentPage = page!;
              });
            },
            onPageError: (page, e) {
              Fluttertoast.showToast(msg: '$e');
            },
          ),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.chevron_left),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage > 0) {
                    _currentPage--;
                  }
                });
              },
            ),
            Text(
              "${_currentPage + 1}/$_totalPages",
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
            IconButton(
              icon: const Icon(Icons.chevron_right),
              iconSize: 50,
              color: Colors.black,
              onPressed: () {
                setState(() {
                  if (_currentPage < _totalPages - 1) {
                    _currentPage++;
                  }
                });
              },
            ),
          ],
        ),
      );
    } else {
      if (exists) {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return const Scaffold(
          body: Center(
            child: Text(
              "PDF Not Available",
              style: TextStyle(fontSize: 20),
            ),
          ),
        );
      }
    }
  }
}
