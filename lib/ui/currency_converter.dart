import 'package:africhange_flutter_test/custom/grap_asset_30days.dart';
import 'package:africhange_flutter_test/custom/graph_asset_90days.dart';
import 'package:africhange_flutter_test/network/API/conversion_API.dart';
import 'package:africhange_flutter_test/network/model/conversion_rates_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:country_currency_pickers/country.dart';
import 'package:country_currency_pickers/currency_picker_dropdown.dart';
import 'package:country_currency_pickers/country_pickers.dart';
import 'package:provider/provider.dart';

class CurrencyConverter extends StatefulWidget {
  CurrencyConverter({Key? key}) : super(key: key);
  @override
  State<CurrencyConverter> createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  ///These Strings hold the initial currency codes and change to any future selected currency codes
  String? conversionCurrency = 'EUR';
  String? convertedCurrency = 'USD';

  ///These boolean variables are used to change the tabs at the bottom sheet
  bool past30Click = true;
  bool past90Click = false;

  ///DateTime variable used to select the current date to parse into the API
  DateTime now = DateTime.now();
  String? date;

  ///'value' holds the converted value after conversion has occured
  String value = 'Conversion Value';

  ///serves as the controller of the textfield to retrieve the text
  TextEditingController inputController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    ///This provider allows the class to access the variable changes in the API conversion class
    final api = Provider.of<ConversionAPI>(context, listen: false);

    ///sets the current date as a string in the API's required format
    date = DateFormat('yyyy-MM-dd').format(now);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 30, 18, 40),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sort,
                              size: 28,
                              color: Color(0xFF01B252),
                            ),
                            Text(
                              'Sign Up',
                              style: TextStyle(
                                fontFamily: 'Monsterrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF01B252),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 80),
                        RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            text: 'Currency\nCalculator',
                            style: TextStyle(
                              fontFamily: 'Monsterrat',
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF185DFA),
                            ),
                            children: const <TextSpan>[
                              TextSpan(
                                text: '. ',
                                style: TextStyle(
                                  fontFamily: 'Monsterrat',
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF01B252),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 3, 15, 3),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.6,
                                    child: TextField(
                                      controller: inputController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        enabledBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        disabledBorder: InputBorder.none,
                                        hintText: '1',
                                        hintStyle: TextStyle(
                                          fontFamily: 'Monsterrat',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    conversionCurrency!,
                                    style: TextStyle(
                                      fontFamily: 'Monsterrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(9)),
                            color: Colors.grey.withOpacity(0.1),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 17, 15, 17),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ///This Consumer allows the converted value to be persistently updated with every change
                                  Consumer<ConversionAPI>(
                                      builder: (context, ref, child) {
                                    return Text(
                                      ref.convertedAmount.toString() == '0.0'
                                          ? value
                                          : ref.convertedAmount.toString(),
                                      style: TextStyle(
                                        fontFamily: 'Monsterrat',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey,
                                      ),
                                    );
                                  }),
                                  Text(
                                    convertedCurrency!,
                                    style: TextStyle(
                                      fontFamily: 'Monsterrat',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.withOpacity(0.7),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                  width: 0.7,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14, 12, 4, 12),
                                ///Allows user set the currency they want to convert from
                                child: CurrencyPickerDropdown(
                                  initialValue: conversionCurrency,
                                  itemBuilder: _buildCurrencyDropdownItem,
                                  onValuePicked: (Country? country) {
                                    setState(() {
                                      conversionCurrency =
                                          country?.currencyCode;
                                    });
                                    print("${country?.name}");
                                  },
                                ),
                              ),
                            ),
                            SizedBox(width: 20),
                            Icon(
                              Icons.swap_horiz_outlined,
                              size: 40,
                              color: Colors.grey,
                            ),
                            SizedBox(width: 20),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4)),
                                border: Border.all(
                                  width: 0.7,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(14, 12, 4, 12),
                                ///Allows user set the currency they want to convert to
                                child: CurrencyPickerDropdown(
                                  initialValue: convertedCurrency,
                                  itemBuilder: _buildCurrencyDropdownItem,
                                  onValuePicked: (Country? country) {
                                    setState(() {
                                      convertedCurrency = country?.currencyCode;
                                    });
                                    print("${country?.name}");
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 42),
                        GestureDetector(
                          ///Initiates API call to Fixer.io when clicked
                          onTap: () async {
                            print(inputController.text.toString());
                            await api.convertValue(
                                date: date,
                                convertingFrom: conversionCurrency,
                                convertingTo: convertedCurrency,
                                amount: inputController.text.toString(),
                                context: context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(7)),
                              color: Color(0xFF01B252),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 15),
                              child: Center(
                                child: Text(
                                  'Convert',
                                  style: TextStyle(
                                    fontFamily: 'Monsterrat',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 35),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Mid-market exchange rate at 13:38 UTC',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  fontFamily: 'Monsterrat',
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF185DFA),
                                ),
                              ),
                              SizedBox(width: 10),
                              Container(
                                height: 23,
                                width: 23,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40)),
                                  color: Colors.grey.withOpacity(0.5),
                                ),
                                child: Center(
                                  child: Icon(
                                    Icons.info_outline,
                                    size: 23,
                                    color: Color(0xFF185DFA),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 9),
                Container(
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)),
                    color: Color(0xFF012CEA),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 15, 45),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 60, right: 50),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ///On click changes to the past 30 days tab
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    past30Click = true;
                                    past90Click = false;
                                  });
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          'Past 30 days',
                                          style: TextStyle(
                                            fontFamily: 'Monsterrat',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: past30Click == true
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.3),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.fiber_manual_record,
                                        size: 14,
                                        color: past30Click == true
                                            ? Color(0xFF01B252)
                                            : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ///On click changes to the past 90 days tab
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    past30Click = false;
                                    past90Click = true;
                                  });
                                },
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 6),
                                        child: Text(
                                          'Past 90 days',
                                          style: TextStyle(
                                            fontFamily: 'Monsterrat',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: past90Click == true
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.3),
                                          ),
                                        ),
                                      ),
                                      Icon(
                                        Icons.fiber_manual_record,
                                        size: 14,
                                        color: past90Click == true
                                            ? Color(0xFF01B252)
                                            : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40),
                        ///Loads the Past30Days graph when the Past30Dyas tab is active & vice versa regarding the 90days tab and graph
                        Container(
                          child: past30Click == true ? GraphAsset30(
                            base: convertedCurrency,
                            rate: api.conversion.rates![convertedCurrency]
                                .toString(),
                          ): GraphAsset90(
                            base: convertedCurrency,
                            rate: api.conversion.rates![convertedCurrency]
                                .toString(),
                          ),
                        ),
                        SizedBox(height: 40),
                        Center(
                          child: Text(
                            'Get rate alerts straight to your email inbox',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontFamily: 'Monsterrat',
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  ///This is the widget design for the countryPickerDropdown. It allows you customize the look of the dropdown
  Widget _buildCurrencyDropdownItem(Country country) => Container(
        child: Row(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 10.0,
              child: ClipRRect(
                child: CountryPickerUtils.getDefaultFlagImage(country),
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              "${country.currencyCode}",
              style: TextStyle(
                fontFamily: 'Monsterrat',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey.withOpacity(0.7),
              ),
            ),
          ],
        ),
      );
}
