import 'package:qrreader/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

void launchURL(ScanModel scan, BuildContext context) async {
  final url = scan.valor;
  if(scan.tipo == 'http'){
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se ha podido acceder a la URL: $url';
    }
  }else{
    Navigator.pushNamed(context, 'map', arguments: scan);
  }
}