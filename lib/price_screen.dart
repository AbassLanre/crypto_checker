
import 'package:crypto_checker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String value= '?';
  String value1='?';
  String value2 ='?';
  // var myCoinData= Map();

  DropdownButton<String> androidGetDropDownItem() {
    var currencyList = List<DropdownMenuItem<String>>(currenciesList.length);
    for (int i = 0; i < currenciesList.length; i++) {
      currencyList[i] = DropdownMenuItem(
          child: Text(currenciesList[i]), value: (currenciesList[i]));
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currencyList,
      onChanged: (value) {
        setState(
          () {
            selectedCurrency = value;
          },
        );
      },
    );
  }

  CupertinoPicker IOSGetCupertinoPicker() {
    var currencyList = List<Text>(currenciesList.length);

    for (int i = 0; i < currenciesList.length; i++) {
      currencyList[i] = Text(
        currenciesList[i],
        style: TextStyle(color: Colors.white),
      );
    }

    return CupertinoPicker(
        itemExtent: 30.0,
        onSelectedItemChanged: (valueIndex) {
          selectedCurrency= currenciesList[valueIndex];
        },
        children: currencyList);
  }

  Widget CryptoCad(String selectedCurrency, String value, String cryptocurrency){
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptocurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );

  }

  void getData() async {
    try {
      CoinData coinData= CoinData();
      var data = await coinData.getCoinData(selectedCurrency);
      setState(() {
            value1 =data['ETH'].toStringAsFixed(2);
            value=data['BTC'].toStringAsFixed(2);
            value2= data['LTC'].toStringAsFixed(2);
      });
    } catch (e) {
      print(e);
    }
  }


// my created dropDownButtonList for the android dropDownListButton

  // List<DropdownMenuItem<String>> loopCurrencies() {
  //   var currencyList = List<DropdownMenuItem<String>>(currenciesList.length);
  //   for (int i = 0; i < currenciesList.length; i++) {
  //     currencyList[i] = DropdownMenuItem(
  //         child: Text(currenciesList[i]), value: (currenciesList[i]));
  //   }
  //   return currencyList;
  // }

  // my created dropDownButtonList for the IOS CupertinoPicker

  // List<Text> loopIOSDropCurrencies() {
  //   var currencyList = List<Text>(currenciesList.length);
  //
  //   for (int i = 0; i < currenciesList.length; i++) {
  //     currencyList[i] = Text(
  //       currenciesList[i],
  //       style: TextStyle(color: Colors.white),
  //     );
  //   }
  //   return currencyList;
  // }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Crypto Checker'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: [
              CryptoCad(selectedCurrency, value, 'BTC'),
              CryptoCad(selectedCurrency, value1, 'ETH'),
              CryptoCad(selectedCurrency, value2, 'LTC'),

            ],
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid ? androidGetDropDownItem() :IOSGetCupertinoPicker(),
          ),
        ],
      ),
    );
  }
}
