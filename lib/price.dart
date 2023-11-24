import 'package:http/http.dart' as http;
import 'dart:convert';

class Price {
  String? coin;
  String? currency;

  Price({this.coin, this.currency});

  Future<dynamic> getPrice() async {
    try {
      http.Response response = await http.get(
        Uri.parse(
            'https://rest.coinapi.io/v1/exchangerate/$coin/$currency?apikey=6C664862-AD22-44B7-85B1-849440FA351E'),
      );
      if (response.statusCode == 200) {
        String result = response.body;
        return jsonDecode(result);
      }
    } catch (e) {
      return null;
    }
  }
}
