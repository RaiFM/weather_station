import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_station/model/clima_model.dart';

class ApiService {
  static ApiService? _apiService;

  ApiService get getInstance {
    _apiService ??= ApiService();
    return _apiService!;
  }

  Future<List<ClimaModel?>> pegarClimaDiarioSalvo(){
    
  }

  Future<List<ClimaModel>> pegarClimaSemanalCidade(String cidade) async {
    String linkApi =
        "https://api.hgbrasil.com/weather?format=json-cors&key=ea69fe0d&city_name=" + cidade;
    List<ClimaModel> previsao = [];

    try {
      var resposta = await http.get(Uri.parse(linkApi));

      if (resposta.statusCode == 200) {
        var dados = json.decode(resposta.body);
        var cidade = dados["results"]["city"];
        var temperaturaAtual = dados["results"]["temp"];

        var lista = dados["results"]["forecast"];
        for (var dia in lista) {
          ClimaModel clima = ClimaModel(
              nome: cidade,
              temperatura: temperaturaAtual,
              data: dia["date"] ?? '',
              diaSemana: dia["weekday"] ?? '',
              descriptionClima: dia["description"] ?? '',
              tempMin: dia["min"] ?? 0,
              tempMax: dia["max"] ?? 0,
              icone: dia["condition"] ?? '');

          if (previsao.length == 7) break;

          previsao.add(clima);
        }
        return previsao;
      } else {
        print("Erro na requisição: ${resposta.statusCode}");
        return [];
      }
    } catch (e) {
      print("Erro: $e");
      return [];
    }
  }
}
