import 'dart:ffi';

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
  Map<String, dynamic> toMap() {
    return {
      DatabaseHelper.columnId: id,
      DatabaseHelper.columnName: name,
      DatabaseHelper.columnPrice: price,
    };
  }
}