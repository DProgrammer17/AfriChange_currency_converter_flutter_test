import 'dart:async';
import 'package:intl/intl.dart';
import 'package:africhange_flutter_test/network/API/conversion_API.dart';
import 'package:africhange_flutter_test/ui/currency_converter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  ///These Strings hold the initial currency codes and change to any future selected currency codes
  String? conversionCurrency = 'EUR';
  String? convertedCurrency = 'USD';

  ///DateTime variable used to select the current date to parse into the API
  DateTime now = DateTime.now();
  String? date;

  ///This is a function that initalizes the variable once the app is launched to get the conversion rates
  timeOut() async {
    ///sets the current date as a string in the API's required format
    date = DateFormat('yyyy-MM-dd').format(now);
    ///This provider allows the class to access the variable changes in the API conversion class
    final api = Provider.of<ConversionAPI>(context, listen: false);
    await api.convertValue(
        date: date,
        convertingFrom: conversionCurrency,
        convertingTo: convertedCurrency,
        amount: 0.toString(),
        context: context).then((value) => {
          ///This navigates to 'currency_converter' once a successful response is gotten
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => CurrencyConverter(),
        ),
      ),
    });
  }

  ///InitState is a system function that initiates functions or actions once a class is accessed
  @override
  void initState() {
    timeOut();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ///This displays a makeshift logo before it navigates to 'currency_converter'
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    text: 'Currency\nCalculator',
                    style: TextStyle(
                      fontFamily: 'Monsterrat',
                      fontSize: 45,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF185DFA),
                    ),
                    children: const <TextSpan>[
                      TextSpan(
                        text: '. ',
                        style: TextStyle(
                          fontFamily: 'Monsterrat',
                          fontSize: 33,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF01B252),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
