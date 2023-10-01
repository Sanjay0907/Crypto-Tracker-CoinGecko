import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static Future<bool> addToWishlist(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> wishlist = sharedPreferences.getStringList("wishlist") ?? [];
    wishlist.add(id);
    return await sharedPreferences.setStringList("wishlist", wishlist);
  }

  static Future<bool> removeFromWishlist(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> wishlist = sharedPreferences.getStringList("wishlist") ?? [];
    wishlist.remove(id);
    return await sharedPreferences.setStringList("wishlist", wishlist);
  }

  static Future<List<String>> fetchWishList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getStringList("wishlist") ?? [];
  }
}

