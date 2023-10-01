import 'dart:async';
import 'package:cryoptogen/Model/crypto_data_model.dart';
import 'package:flutter/cupertino.dart';
import '../services/LocalStorage/local_storage.dart';
import '../services/get_market_data.dart';

class CryptoDataProvider with ChangeNotifier {
  bool isLoading = true;
  List<CryptoDataModel> cryptoData = [];
  CryptoDataModel currentCrypto = CryptoDataModel();
  bool fetchingCurrentCrypto = true;
  List<String> wishlist = [];
  bool status = false;
  CryptoDataProvider() {
    fetchData();
    fetchLatestData();
  }
  fetchWishlist() async {
    wishlist = await LocalStorage.fetchWishList();
    notifyListeners();
  }

  updateWishlist(String id, CryptoDataModel crypto) async {
    if (wishlist.contains(id)) {
      wishlist.remove(id);
      int indexOfCrypto = cryptoData.indexOf(crypto);
      cryptoData[indexOfCrypto].addedToWishlist = false;
      await LocalStorage.removeFromWishlist(id);
      notifyListeners();
    } else {
      wishlist.add(id);
      int indexOfCrypto = cryptoData.indexOf(crypto);
      cryptoData[indexOfCrypto].addedToWishlist = true;
      await LocalStorage.addToWishlist(id);
      notifyListeners();
    }
  }

  Future<void> fetchData() async {
    List<dynamic> markets = await API.getCryptoMarketData();
    wishlist = await LocalStorage.fetchWishList();
    notifyListeners();
    List<CryptoDataModel> temp = [];
    for (var market in markets) {
      CryptoDataModel newCrypto = CryptoDataModel.fromJSON(market);
      if (wishlist.contains(newCrypto.id)) {
        newCrypto.addedToWishlist = true;
      }
      temp.add(newCrypto);
    }

    cryptoData = temp;
    isLoading = false;
    notifyListeners();
  }

  updateFetchingCurrentCryptoStatus(bool data) {
    fetchingCurrentCrypto = data;
    notifyListeners();
  }

  fetchCryptoById(String id) {
    updateFetchingCurrentCryptoStatus(true);
    CryptoDataModel crypto =
        cryptoData.where((element) => element.id == id).toList()[0];
    currentCrypto = crypto;
    notifyListeners();
    updateFetchingCurrentCryptoStatus(false);
  }

  fetchLatestData() {
    fetchData();
    Future.delayed(const Duration(seconds: 6), () {
      fetchLatestData();
    });
  }
}
