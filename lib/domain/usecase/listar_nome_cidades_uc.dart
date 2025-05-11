import 'package:weather_station/infra/interfaces/i_repository_cidade_api.dart';
import 'package:weather_station/infra/repository/repository_cidade_api.dart';

class ListarNomeCidadesUc {
  static ListarNomeCidadesUc? _listarNomeCidadesUc;

  static ListarNomeCidadesUc get getInstance {
    _listarNomeCidadesUc ??= ListarNomeCidadesUc(repositoryCidadeApi: RepositoryCidadeApi.getInstance);
    return _listarNomeCidadesUc!;
  }

  ListarNomeCidadesUc({required this.repositoryCidadeApi});
  final IRepositoryCidadeApi repositoryCidadeApi;

  Future<List<String>> listar(int uf) async {
    
    List<int> numerosUf = [
      11, 12, 13, 14, 15, 16, 
      21, 22, 23, 24, 25, 26, 27,
      28, 29, 31, 32, 33, 35, 41,
      42, 43, 50, 51, 52, 53
];

    if(!numerosUf.contains(uf)){
      throw Exception("Esse estado não existe");
    }
    final cidades = await repositoryCidadeApi.listarCidades(uf);

    return cidades;
  }
}
