class CryptoGraphData {
  DateTime? date;
  double? price;

  CryptoGraphData({this.date, this.price});

  CryptoGraphData.fromList(List<dynamic> list) {
    date = DateTime.fromMillisecondsSinceEpoch(list[0]);
    price = list[1].toDouble();
  }
}