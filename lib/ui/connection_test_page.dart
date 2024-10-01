import 'package:ecommerce_dapp/provider/metamask_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectionTestPage extends StatefulWidget {
  const ConnectionTestPage({super.key});

  @override
  State<ConnectionTestPage> createState() => _ConnectionTestPageState();
}

class _ConnectionTestPageState extends State<ConnectionTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () async {
                final provider =
                    Provider.of<MetaMaskProvider>(context, listen: false);
                await provider.connectWallet();
                if (provider.isConnected) {
                  print(
                      'Connected to MetaMask with address: ${provider.currentAddress}');
                }
              },
              child: Text('Connect to MetaMask'),
            )
          ],
        ),
      ),
    );
  }
}
