class CryptoDataModel {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentPrice;
  double? marketCap;
  int? marketCapRank;
  double? high24;
  double? low24;
  double? priceChange24;
  double? priceChangePercentage24;
  double? circulatingSupply;
  double? ath;
  double? atl;
  bool addedToWishlist = false;

  CryptoDataModel(
      {this.id,
      this.symbol,
      this.name,
      this.image,
      this.currentPrice,
      this.marketCap,
      this.marketCapRank,
      this.high24,
      this.low24,
      this.priceChange24,
      this.priceChangePercentage24,
      this.circulatingSupply,
      this.ath,
      this.atl});

  factory CryptoDataModel.fromJSON(Map<String, dynamic> map) {
    return CryptoDataModel(
        id: map["id"],
        symbol: map["symbol"],
        name: map["name"],
        image: map["image"],
        currentPrice: double.parse(map["current_price"].toString()),
        marketCap: double.parse(map["market_cap"].toString()),
        marketCapRank: map["market_cap_rank"],
        high24: double.parse(map["high_24h"].toString()),
        low24: double.parse(map["low_24h"].toString()),
        priceChange24: double.parse(map["price_change_24h"].toString()),
        priceChangePercentage24:
            double.parse(map["price_change_percentage_24h"].toString()),
        circulatingSupply: double.parse(map["circulating_supply"].toString()),
        ath: double.parse(map["ath"].toString()),
        atl: double.parse(map["atl"].toString()));
  }
}
