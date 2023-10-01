import 'package:cryoptogen/Controller/provider/crypto_provider.dart';
import 'package:cryoptogen/Model/crypto_data_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'crypto_listing_screen.dart';

class CryptoWishlistScreen extends StatefulWidget {
  const CryptoWishlistScreen({Key? key}) : super(key: key);

  @override
  State<CryptoWishlistScreen> createState() => _CryptoWishlistScreenState();
}

class _CryptoWishlistScreenState extends State<CryptoWishlistScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CryptoDataProvider>(
      builder: (context, marketProvider, child) {
        List<CryptoDataModel> wishlist = marketProvider.cryptoData
            .where((element) => element.addedToWishlist == true)
            .toList();

        if (wishlist.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              await marketProvider.fetchData();
            },
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
              ),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: wishlist.length,
              itemBuilder: (context, index) {
                CryptoDataModel currentCrypto = wishlist[index];
                return CryptoTile(currentCryptoData: currentCrypto);
              },
            ),
          );
        } else {
          return const Center(
            child: Text(
              "No CryptoCurrency added to Wishlist",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
          );
        }
      },
    );
  }
}
