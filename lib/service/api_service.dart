import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_station/model/clima_model.dart';

class ApiService {
    static ApiService? _apiService;

   ApiService get getInstance {
    _apiService ??= ApiService();
    return _apiService!;
  }

 Future<List<ClimaModel>> pegarClimaSemanal() async {
  String linkApi = "https://api.hgbrasil.com/weather?format=json-cors&key=ea69fe0d";
  
  try {
    var resposta = await http.get(Uri.parse(linkApi));

    if (resposta.statusCode == 200) {
      var dados = json.decode(resposta.body);

      // Exemplo: pegando temperatura e cidade
      var cidade = dados["results"]["city"];
      var temp = dados["results"]["temp"];

      print("Cidade: $cidade");
      print("Temperatura: $temp°C");
    } else {
      print("Erro na requisição: ${resposta.statusCode}");
    }
  } catch (e) {
    print("Erro: $e");
  }
 }
  
}