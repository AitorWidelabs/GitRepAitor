import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Product{
 Product({
   this.slug,
  this.name,
   this.price,
});

 String slug;
 String name;
 String price;

 
}
Future<List> getCurrencies() async {
  List<Product> prodList = [];
  String apiUrl = 'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?start=1&limit=50&convert=USD&CMC_PRO_API_KEY=d5f38340-9a22-4cf1-a245-595a547a8b48';
  // Make a HTTP GET request to the CoinMarketCap API.
  // Await basically pauses execution until the get() function returns a Response
  http.Response response = await http.get(apiUrl);
  // Using the JSON class to decode the JSON String
  if (response.statusCode == 200){
    var jsonList = jsonDecode(response.body);
    for(var coin in jsonList){
      prodList.add(Product.fromJson(coin));
    }
  }
  return json.decode(json.encode(response.body));
}
void main() async {
  List? currencies = await getCurrencies();
  // Before printing it to the Console
  print(currencies);

  // Runs the MaterialApp widget
  runApp(new MaterialApp(
    // This is the widget that is displayed first when the application is started normally
    home: new Center(
      // The Text widget is wrapped in a center widget to center it on the screen
      child: new Text('Hello World!'),
    ),
  ));
}

