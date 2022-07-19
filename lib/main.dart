import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io' as io;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_selector_windows/file_selector_windows.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

void main()

//Initializing Database when starting the application.
async {
  //Initializing Database when starting the application.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDdXjNbjW8RtALhJybesKPGzY45wTWs4LU",
    authDomain: "safeapp-c1905.firebaseapp.com",
    projectId: "safeapp-c1905",
    storageBucket: "safeapp-c1905.appspot.com",
    messagingSenderId: "467484146231",
    appId: "1:467484146231:web:da919d53f6296015be9db2",
    measurementId: "G-3SG35Q9KLL",
  ));

  runApp(MaterialApp(
    home: cloudPortal(),
  ));
}

dynamic uri = '';

class cloudPortal extends StatefulWidget {
  @override
  _cloudPortalState createState() => _cloudPortalState();
}

class _cloudPortalState extends State<cloudPortal> {
  @override
  Widget build(BuildContext context) {
    getData() {
      FirebaseFirestore.instance
          .collection('users')
          .doc("1JH1u4DfW1Oy19x9kDILOdVV99g1")
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          print('Document data: ${documentSnapshot.data()}');
        } else {
          print('Document does not exist on the database');
        }
      });
    }

    _launchURL(uri) async {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }

    downloadFile() async {
      final gsReference = await FirebaseStorage.instance
          .refFromURL(
              "gs://safeapp-c1905.appspot.com/0tc1RmP4GDOLayX6tQymbjDWKV03/1651817592330")
          .getDownloadURL();

      final Uri _url = Uri.parse(gsReference);
      setState(() {
        uri = (_url);
      });
      _launchURL(uri);

      //final io.Directory systemTempDir = io.Directory.systemTemp;
      // final io.File tempFile =
      // io.File('${systemTempDir.path}/temp-${gsReference.name}');
      //if (tempFile.existsSync()) await tempFile.delete();
      //await gsReference.writeToFile(tempFile);
      //print(systemTempDir);
    }

    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: <Widget>[
        Center(child: Image.asset('assets/images/safe_gauge.JPG')),
        SizedBox(height: 100.0),
        Text(
          'Welcome to Safe Gauge',
          style: TextStyle(
              color: Colors.red[700],
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        SizedBox(height: 100.0),
        Text(
          "Full Name: ",
          style: TextStyle(
              color: Colors.red[700],
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        SizedBox(height: 30.0),
        uri == ''
            ? ElevatedButton(onPressed: downloadFile, child: Text('View Pdf'))
            : SizedBox(
                height: 500,
                width: 500,
                child: SfPdfViewer.network(uri.toString())),
        SizedBox(height: 50.0),
        ElevatedButton(onPressed: getData, child: Text('get')),
      ],
    )));

    /**/
  }
}
