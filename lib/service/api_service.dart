import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_station/model/clima_model.dart';

class ApiService {
  static ApiService? _apiService;

  ApiService get getInstance {
    _apiService ??= ApiService();
    return _apiService!;
  }

  final String _linkApi = "https://api.hgbrasil.com/weather?format=json-cors";
  final String _apiKey = "&key=ea69fe0d";

  Future<List<ClimaModel?>> _requisicaoApi(String url, int dias) async {
    List<ClimaModel?> previsao = [];

    try {
      var resposta = await http.get(Uri.parse(url));

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

          if (previsao.length == dias) break;

          previsao.add(clima);
        }
        return previsao;
      } else {
        Exception("Erro ao fazer requisição de clima ");
        return [];
      }
    } catch (e) {
      Exception("Erro ao fazer requisição de clima ");
      print("Erro: $e");
      return [];
    }
  }

  Future<List<ClimaModel?>> pegarClimaDiarioSalvo(List<String?> cidadesSalvas) async {
    String? nomeCidade = "";
    String url = "$_linkApi$_apiKey&city_name=";
    List<ClimaModel?> previsao = [];

    try {
      for (int i = 0; i < cidadesSalvas.length; i++) {
        nomeCidade = cidadesSalvas[i];
        String urlCidade = url + nomeCidade!;
        List<ClimaModel?> previsaoReq = await _requisicaoApi(urlCidade, 1);
        previsao.add(previsaoReq[0]);
        urlCidade = url;
      }
    } catch (e) {
      Exception("erro ao tentar acessar requsição");
    }
    return previsao;
  }

  Future<List<ClimaModel?>> pegarClimaSemanalNome(String nomeCidade) async {
    String url = "$_linkApi$_apiKey&city_name=$nomeCidade";
    List<ClimaModel?> previsao = [];

    List<ClimaModel?> previsaoReq = await _requisicaoApi(url, 7);
    for (int i = 0; i < previsaoReq.length; i++) {
      previsao.add(previsaoReq[i]);
    }
    return previsao;
  }

  Future<List<ClimaModel?>> pegarClimaSemanalLatLon(String latLon) async {
    String url = "$_linkApi$_apiKey&city_name=$latLon";
    List<ClimaModel?> previsao = [];

    List<ClimaModel?> previsaoReq = await _requisicaoApi(url, 7);
    for (int i = 0; i < previsaoReq.length; i++) {
      previsao.add(previsaoReq[i]);
    }

    return previsao;
  }
}
