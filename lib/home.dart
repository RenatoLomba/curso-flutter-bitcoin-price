import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String url = 'https://blockchain.info/ticker';
  String _bitcoinPrice = '';

  Future<void> _getBitcoin() async {
    var response = await http.get(Uri.parse(url));
    String responseData = response.body;
    Map<String, dynamic> jsonData = json.decode(responseData);
    Map<String, dynamic> bitcoinPriceBRL = jsonData['BRL'];
    double bitcoinPrice = bitcoinPriceBRL['last'];

    setState(() {
      _bitcoinPrice = bitcoinPrice.toString().replaceAll('.', ',');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: const EdgeInsets.all(32),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('images/bitcoin.png'),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 32),
                child: Text(
                    'R\$ $_bitcoinPrice',
                    style: const TextStyle(
                      fontSize: 32,
                    )
                ),
              ),
              MaterialButton(
                color: Colors.orange,
                textColor: Colors.white,
                onPressed: _getBitcoin,
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                child: Text(
                  _bitcoinPrice.isNotEmpty ? 'Atualizar' : 'Mostrar',
                  style: const TextStyle(fontSize: 18),
                ),
              )
            ],
          )
      ),
    );
  }
}
