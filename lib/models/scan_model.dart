import 'dart:convert';
//Para el @required
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));

String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  
  int id;
  String tipo;
  String valor;

  ScanModel({
    this.id,
    this.tipo,
    @required this.valor,
  }){
    if(this.valor.contains('http')){
      this.tipo = 'http';
    }else{
      this.tipo = 'geo';
    }
  }

  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
    id: json["id"],
    tipo: json["tipo"],
    valor: json["valor"],
  );

  //Pasa a Json una instancia de mi clase
  Map<String, dynamic> toJson() => {
    "id": id,
    "tipo": tipo,
    "valor": valor,
  };

  LatLng getLatLong(){
    final latlng = this.valor.substring(4).split(',');
    final lat = double.parse(latlng[0]);
    final lng = double.parse(latlng[1]);
    return LatLng(lat,lng);
  }
}
