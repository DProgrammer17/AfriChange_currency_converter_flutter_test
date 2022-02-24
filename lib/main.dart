import 'package:africhange_flutter_test/network/API/conversion_API.dart';
import 'package:africhange_flutter_test/ui/currency_converter.dart';
import 'package:africhange_flutter_test/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConversionAPI()),
      ],
      child: MaterialApp(
        title: 'Africhange Currency Converter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFF185DFA),
        ),
        home: SplashPage(),
      ),
    );
  }
}

