
import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';
class MetaMaskProvider with ChangeNotifier {
  String currentAddress = '';
  bool isConnected = false;
  int chainId = -1;

  Future<void> connectWallet() async {
    if (ethereum != null) {
      final accounts = await ethereum!.requestAccount();
      if (accounts.isNotEmpty) {
        currentAddress = accounts.first;
        isConnected = true;
        chainId = await ethereum!.getChainId();
        notifyListeners();
      }
    } else {
      print('MetaMask is not available.');
    }
  }

  void disconnect() {
    isConnected = false;
    currentAddress = '';
    notifyListeners();
  }
}