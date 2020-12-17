import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/pages/direcciones_page.dart';
import 'package:qrreader/pages/mapas_page.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/providers/ui_provider.dart';
import 'package:qrreader/widgets/custom_navigatorbar.dart';
import 'package:qrreader/widgets/scan_button.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: (){
              final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
              scanListProvider.deleteAll();
            },
          ),
        ],
      ),
      body: _HomePageBody(), 
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Vamos a hacer el button navigation bar para mostrar tabs
    //Consumimos el provider
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    //Usando el scan list provider 
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);
    
    switch(currentIndex) {
      case 0:
        scanListProvider.loadScansByType('geo');
        return MapsPage();
      case 1:
        scanListProvider.loadScansByType('http');
        return DireccionesPage();
      default: 
        return MapsPage();
    }
  }
}