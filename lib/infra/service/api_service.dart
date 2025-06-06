import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_station/domain/model/clima_model.dart';

class ApiService {
  static ApiService? _apiService;

  static ApiService get getInstance {
    _apiService ??= ApiService();
    return _apiService!;
  }

  final String _linkApi = "https://api.hgbrasil.com/weather?format=json-cors";
  final String _apiKey = "&key=c42a033a";

  Future<List<ClimaModel?>> _requisicaoApi(String url, int dias) async {
    List<ClimaModel?> previsao = [];

    try {
      var resposta = await http.get(Uri.parse(url));

      if (resposta.statusCode == 200) {
        var dados = json.decode(resposta.body);
        var cidade = dados["results"]["city"];
        var temperaturaAtual = dados["results"]["temp"];
        var timeZone = dados["results"]["timezone"];
        var direcaoVento = dados["results"]["wind_direction"];
        var direcaoCardinal = dados["results"]["wind_cardinal"];

        var lista = dados["results"]["forecast"];
        for (var dia in lista) {
          ClimaModel clima = ClimaModel(
            nome: cidade,
            temperatura: temperaturaAtual,
            fusoHorario: timeZone,
            direcaoVento: direcaoVento,
            cardinalVento: direcaoCardinal,
            data: dia["date"] ?? '',
            diaSemana: dia["weekday"] ?? '',
            descriptionClima: dia["description"] ?? '',
            tempMin: dia["min"] ?? 0,
            tempMax: dia["max"] ?? 0,
            icone: dia["condition"] ?? '',
            precipitacao: dia['rain'] ?? 0,
            chanceChuva: dia['rain_probability'] ?? 0,
            umidade: dia['humidity'],
            velocidadeVento: dia['wind_speedy'] ?? 0,
            nascerSol: dia['sunrise'] ?? '',
            porSol: dia['sunset'] ?? '',
            faseLua: dia['moon_phase'] ?? '',
          );

          if (previsao.length == dias) break;

          previsao.add(clima);
        }

        return previsao;
      } else {
        throw Exception("Erro ao fazer requisição de clima ");
      }
    } catch (e) {
      throw Exception("Erro ao fazer requisição de clima ");
    }
  }

  Future<List<ClimaModel?>> pegarClimaDiarioSalvo(
      List<String?> cidadesSalvas) async {
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
    String url = "$_linkApi$_apiKey&$latLon";
    List<ClimaModel?> previsao = [];

    List<ClimaModel?> previsaoReq = await _requisicaoApi(url, 8);
    for (int i = 0; i < previsaoReq.length; i++) {
      previsao.add(previsaoReq[i]);
    }

    return previsao;
  }
}
