import 'dart:ffi';
import 'dart:convert';
import 'package:sql_pricelist/database_helper.dart';
class Product {
  int id = 0;
  String name = "name";
  double price = 0.00;
  Product(this.id, this.name, this.price);
  Product.fromMap(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    if(map['price'] == null) price = 0.00;
    else price = map['price'].toDouble();

  }
  Product.fromJson(Map<String, dynamic> map){
    id = int.parse(map['product_id']);
    name = map['product_name'];
    if(map['product_price'] == null) price = 0.00;
    else price = double.parse(map['product_price']);
  }
  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnPrice: price,
    };
  }
}