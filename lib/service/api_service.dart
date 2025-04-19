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
    String linkApi =
        "https://api.hgbrasil.com/weather?format=json-cors&key=ea69fe0d";
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
        print( previsao[0].tempMax);
        
        print( previsao[1].tempMax);
        print( previsao[2].tempMax);
        print( previsao[3].tempMax);
        print( previsao[4].tempMax);
        print( previsao[5].tempMax);
        
        print( previsao[6].tempMax);
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
