import 'package:ecommerce_dapp/provider/metamask_provider.dart';
import 'package:ecommerce_dapp/ui/connection_test_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // You can add your providers here, for example:
        ChangeNotifierProvider(create: (_) => MetaMaskProvider()),
        // Add more providers as needed
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const ConnectionTestPage(),
      ),
    );
  }
}


