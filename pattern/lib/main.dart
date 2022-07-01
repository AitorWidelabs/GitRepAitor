import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( MyApp());
}

class Counter extends  ChangeNotifier{

  var _count = 0;
  int get getCounter{
    return _count;
  }
  void incrementCounter(){
    _count+=1;
    notifyListeners();
  }
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
        ChangeNotifierProvider.value(
        value: Counter(),
    ),
    ],child: MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
              primarySwatch: Colors.blue,
               visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:  MyHomePage(title: 'Flutter Demo Home Page'),
    )
    );
  }
}

class MyHomePage extends StatelessWidget {
   final String title ;
  MyHomePage({required this.title});
  void _incrementCounter(BuildContext context) {
    Provider.of<Counter>(context, listen: false).incrementCounter();
  }
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<Counter>(context).getCounter;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:() => _incrementCounter(context),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}


