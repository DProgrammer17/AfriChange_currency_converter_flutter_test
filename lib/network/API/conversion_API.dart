import 'dart:convert';
import 'package:africhange_flutter_test/network/model/conversion_rates_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class ConversionAPI extends ChangeNotifier {
  ///This string hold the fixer.io base url
  String url = 'data.fixer.io';
  ///Holds my personal API_KEY
  String API_KEY = '40e72a552bc04c2e972163939ca5b8df';

  ///Holds the converted value
  double? convertedAmount;

  ///Holds an object of the conversionRateModel to be accessed by the 'Currency-Converter.dart'
  late ConversionRateModel conversion;

  ///This Holds the Post Request and the Query Parameters to the Fixer.io API
  Future<ConversionRateModel> convertValue({
    required String? date,
    required String? convertingFrom,
    required String? convertingTo,
    required String amount,
    required BuildContext context,
  }) async {
    ///These are the parameters required by the API endpoint
    final conversionQueryParameters = {
      'access_key': API_KEY,
      'base': convertingFrom,
      'symbols': convertingTo
    };
    try {
    //  print('Whats going on:\n$date\n$convertingFrom\n$convertingTo\n$amount');
      http.Response response = await http
          .post(Uri.http(url, '/api/$date', conversionQueryParameters));
      print(response.body);
      ///Action to take if call is successful
      if (response.statusCode == 200) {
        ///Maps the response to the ConversionRateModel and to conversion as well
        conversion = ConversionRateModel.fromMap(conversion: jsonDecode(response.body));

        ///Initiates the function to convert the currency from one value to another - Requires amount and the currency converted to
        convertResult(value: double.parse(amount), currency: convertingTo);

        ///Notifies the app of changes to the function
        notifyListeners();
        print(conversion.base);
        print(conversion.rates);
      }
    } on Exception {
    } catch (e) {
      print(e);
    }
    return conversion;
  }

  ///Function to convert one currency value amount to another
  Future<double> convertResult({required double value,required String? currency}) async{
    var rate = await conversion.rates![currency];
    //value = value*rate!;
    convertedAmount = value*rate!;
    print('This is the converted amount $convertedAmount');
    notifyListeners();
    return value;
  }
}
