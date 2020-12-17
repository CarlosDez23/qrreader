

import 'package:flutter/material.dart';
import 'package:qrreader/models/scan_model.dart';
import 'package:qrreader/providers/db_provider.dart';
/*
Utilizamos este provider en vez de directamente el provider de la
bbdd porque el de la bbdd no va a actualizar la UI, mientras que 
este sí lo va a hacer
*/ 
class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> createScan(String valor) async {
    final scan = ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(scan);
    scan.id = id;
    if(this.tipoSeleccionado == scan.tipo){
      this.scans.add(scan);
      //Notificamos a los widgets que estén escuchando
      notifyListeners();
    }
    return scan;
  }

  void loadScans() async{
    final scansList = await DBProvider.db.findAllScans();
    print('Antes de spread');
    printList(this.scans);
    this.scans = [...scansList];
    print('Después de spread');
    printList(this.scans);
    notifyListeners();
  }

  void loadScansByType(String tipo) async{
    final scans = await DBProvider.db.findScansByType(tipo);
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  void deleteScan(int id) async{
    await DBProvider.db.deleteScan(id);
    //Filtramos la lista para que solo se quede con los que no han sido elimiandos
    // this.scans.where((scan) => scan.id != id);
    //Como con el dismiss desaparece de la interfaz no hace falta notificar
    //porque si no se duplica
    //notifyListeners();
  }

  void deleteByType(String tipo) async{
    await DBProvider.db.deleteScanByType(tipo);
    notifyListeners();
  }

  void deleteAll() async{
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  void printList (List<ScanModel> list){
    for(var scan in list){
      print(scan.valor);
    }
  }
}