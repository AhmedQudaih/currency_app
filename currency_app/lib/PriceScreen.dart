import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'coin_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'style.dart';

const spinkit = SpinKitDualRing(
  color: spinColor,
  size: spinSize,
);

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String fromSelectedCurrency = 'USD';
  String toSelectedCurrency = 'BTC';
  String price;
  List<DropdownMenuItem<String>> dropdownItems = [];

  void dropDown() {
    if (dropdownItems.isNotEmpty) {
      dropdownItems.clear();
    }
    for (var x in currenciesList) {
      var newitem = DropdownMenuItem(
        child: Text(
          x,
        ),
        value: x,
      );
      dropdownItems.add(newitem);
    }
  }

  void swap() {
    setState(() {
      var x = fromSelectedCurrency;
      fromSelectedCurrency = toSelectedCurrency;
      toSelectedCurrency = x;
    });
    getPrice();
  }

  void getPrice() async {
    price = null;
    price =
        await CoinData().getCoinData(fromSelectedCurrency, toSelectedCurrency);
    if (price != null) {
      setState(
        () {
          price;
        },
      );
    }
    ;
  }

  @override
  void initState() {
    dropDown();
    getPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Welcome'),
        shape: appBarShape,
      ),
      body: Center(
        child: price == null
            ? spinkit
            : Text(
                price,
                textAlign: TextAlign.center,
                style: centerTextStyle,
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        shape: bottomBarShape,
        child: Container(
          height: 70,
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buildDropdownButton(Value: fromSelectedCurrency),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(
                  Icons.swap_horiz,
                  size: iconButtonSize,
                  color: iconButtonColor,
                ),
                onPressed: () => swap(),
              ),
              SizedBox(width: 10),
              buildDropdownButton(Value: toSelectedCurrency),
            ],
          ),
        ),
      ),
    );
  }

  DropdownButton<String> buildDropdownButton({@required Value}) {
    return DropdownButton<String>(
      style: dropdownButtonStyle,
      value: Value,
      items: dropdownItems,
      onChanged: (value) {
        setState(
          () {
            if (Value == fromSelectedCurrency) {
              fromSelectedCurrency = value;
            } else if (Value == toSelectedCurrency) {
              toSelectedCurrency = value;
            }
            getPrice();
          },
        );
      },
    );
  }
}
