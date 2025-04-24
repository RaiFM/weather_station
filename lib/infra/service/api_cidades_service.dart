import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiCidadesService {
  static ApiCidadesService? _apiCidadesService;

  ApiCidadesService get getInstance {
    _apiCidadesService ??= ApiCidadesService();
    return _apiCidadesService!;
  }

  final String _linkApi =
      "https://servicodados.ibge.gov.br/api/v1/localidades/estados/";
  String _uf = "";
  final String _linkContinuos = "/municipios";

  Future<List<String>> getMunicipios(int ufUser) async {
    List<String> listaNomes = [];

    _uf = ufUser.toString();
    String finalLink = _linkApi + _uf + _linkContinuos;
    var response = await http.get(Uri.parse(finalLink));

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      for (int i = 0; i < data.length; i++) {
        String municipioNome = data[i]["nome"];
        listaNomes.add(municipioNome);
      }
      return listaNomes;
    } else {
      throw Exception("Falha ao requisitar Cidade");
    }
  }
}
