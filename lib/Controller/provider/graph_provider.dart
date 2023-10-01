import 'package:flutter/cupertino.dart';

import '../../Model/crypto_graph_data_model.dart';
import '../services/get_market_data.dart';

class GraphProvider with ChangeNotifier {
  List<CryptoGraphData> graphPoints = [];

  Future<void> fetchCryptoGraph(String id, int days) async {
    graphPoints = [];
    notifyListeners();
    List<dynamic> priceData = await API.fetchGraphData(id, days);

    List<CryptoGraphData> temp = [];
    for (var pricePoint in priceData) {
      CryptoGraphData graphPoint = CryptoGraphData.fromList(pricePoint);
      temp.add(graphPoint);
    }

    graphPoints = temp;
    notifyListeners();
  }
}
