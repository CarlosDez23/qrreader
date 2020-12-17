import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrreader/providers/scan_list_provider.dart';
import 'package:qrreader/utils/utils.dart';

class ScanTile extends StatelessWidget {

  final String tipo;

  const ScanTile({@required this.tipo});

  @override
  Widget build(BuildContext context) {
    
    //Dentro de un build siempre listen a true, dentro de un método listen en false
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (DismissDirection direction){
              Provider.of<ScanListProvider>(context, listen: false)
                .deleteScan(scans[index].id);
            },
            child: ListTile(
              leading: Icon(
                this.tipo == 'http'
                  ? Icons.compass_calibration
                  : Icons.map,
                color: Theme.of(context).primaryColor
              ),
              title: Text(scans[index].valor),
              subtitle: Text(scans[index].id.toString()),
              trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
              onTap: () {
                launchURL(scans[index], context);
              },
            ),
          );
        });
  }
}
