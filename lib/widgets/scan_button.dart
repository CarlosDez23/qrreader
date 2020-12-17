import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/utils/utils.dart';

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.filter_center_focus),
      onPressed: () async{
        //Para hacerlo en un dispositivo real
        // String barcodeScanRes = await 
        //   FlutterBarcodeScanner.scanBarcode(
        //     '#3D8BEF', 
        //     'Cancelar', 
        //     false, 
        //     ScanMode.QR
        //   );
        //Como estamos en una función le ponemos el listen a false porque daría un error
        final barcodeScanRes = 'geo:38.6851836469048,-4.102577106265576';
        if(barcodeScanRes == '-1'){
          return;
        }
        final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
        final scan = await scanListProvider.createScan(barcodeScanRes);
        launchURL(scan, context);
      },
    );
  }
}