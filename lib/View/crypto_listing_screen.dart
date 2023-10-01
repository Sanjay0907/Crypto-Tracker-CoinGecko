import 'package:cryoptogen/Model/crypto_data_model.dart';
import 'package:cryoptogen/View/specific_crypto_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../Controller/provider/crypto_provider.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptogenState();
}

class _CryptogenState extends State<CryptoListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: Consumer<CryptoDataProvider>(
            builder: (context, cryptoDataProvider, child) {
          if (cryptoDataProvider.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                  itemCount: cryptoDataProvider.cryptoData.length,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    CryptoDataModel currentCryptoData =
                        cryptoDataProvider.cryptoData[index];
                    return CryptoTile(currentCryptoData: currentCryptoData);
                  }),
            );
          }
        }),
      )),
    );
  }
}

class CryptoTile extends StatelessWidget {
  const CryptoTile({
    super.key,
    required this.currentCryptoData,
  });

  final CryptoDataModel currentCryptoData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SpecificCryptoDataScreen(
              cryptoID: currentCryptoData.id!,
            ),
          ),
        );
      },
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 5.w,
          backgroundColor: Colors.white12,
          child: Image.network(currentCryptoData.image!),
        ),
        title: Text(
          currentCryptoData.name!,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: Text(
          currentCryptoData.currentPrice!.toStringAsFixed(2),
          style: TextStyle(
            color: currentCryptoData.priceChange24! > 0
                ? Colors.green
                : Colors.red,
          ),
        ),
      ),
    );
  }
}
