import 'package:cryoptogen/View/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'Controller/provider/crypto_provider.dart';
import 'Controller/provider/graph_provider.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, _, __) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<CryptoDataProvider>(
            create: (context) => CryptoDataProvider(),
          ),
          ChangeNotifierProvider<GraphProvider>(
            create: (context) => GraphProvider(),
          )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(),
          home: const HomeScreen(),
        ),
      );
    });
  }
}
