import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Consumimos el provider
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;
    return BottomNavigationBar(
      onTap: (index){
        uiProvider.selectedMenuOpt = index;
      },
      //El elemento seleccionado
      currentIndex: currentIndex,
      items: <BottomNavigationBarItem> [
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Direcciones'
        ),
      ],
      
    );
  }
}