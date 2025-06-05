import 'package:weather_station/infra/interfaces/i_repository_cidade_api.dart';
import 'package:weather_station/infra/repository/repository_cidade_api.dart';

class ListarNomeCidadesUc {
  static ListarNomeCidadesUc? _listarNomeCidadesUc;

  static ListarNomeCidadesUc get getInstance {
    _listarNomeCidadesUc ??= ListarNomeCidadesUc(repositoryCidadeApi: RepositoryCidadeApi.getInstance);
    return _listarNomeCidadesUc!;
  }

  Map<String,int> ufsNumber = {
    "RO": 11,
    "AC": 12,
    "AM": 13,
    "RR": 14,
    "PA": 15,
    "AP": 16,
    "TO": 17,
    "MA": 21,
    "PI": 22,
    "CE": 23,
    "RN": 24,
    "PB": 25,
    "PE": 26,
    "AL": 27,
    "SE": 28,
    "BA": 29,
    "MG": 31,
    "ES": 32,
    "RJ": 33,
    "SP": 35,
    "PR": 41,
    "SC": 42,
    "RS": 43,
    "MS": 50,
    "MT": 51,
    "GO": 52,
    "DF": 53
  };

  ListarNomeCidadesUc({required this.repositoryCidadeApi});
  final IRepositoryCidadeApi repositoryCidadeApi;

  Future<List<String>> listar(int uf) async {

    List<int> numerosUf = [
      11, 12, 13, 14, 15, 16, 17,
      21, 22, 23, 24, 25, 26, 27,
      28, 29, 31, 32, 33, 35, 41,
      42, 43, 50, 51, 52, 53
    ];

    if(!numerosUf.contains(uf)){
      return [];
    }
    final cidades = await repositoryCidadeApi.listarCidades(uf);

    return cidades;
  }
}
