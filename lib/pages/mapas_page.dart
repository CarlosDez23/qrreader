import 'package:flutter/material.dart';
import 'package:qrreader/widgets/scan_tile.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScanTile(tipo: 'geo');
  }
}