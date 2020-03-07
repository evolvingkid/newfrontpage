import 'package:exam/provider/cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/rest_api_calls.dart';
import './screens/home_page.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    bool _isLoading =true;

 

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: RestApiCalss(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
      ],
          child: MaterialApp(
        title: 'Exam Test',

         home: MainScreenPages()
      ),
    );
  }
   
}



