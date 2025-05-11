import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/interfaces/i_repository_api.dart';

class ListarLocaisPorNomeUc {
  static ListarLocaisPorNomeUc? _listarLocaisPorNomeUc;

  static ListarLocaisPorNomeUc get getInstance {
    _listarLocaisPorNomeUc ??= ListarLocaisPorNomeUc.getInstance;
    return _listarLocaisPorNomeUc!;
  }

  ListarLocaisPorNomeUc({required this.iRepositoryApi});
  final IRepositoryApi iRepositoryApi;

  Future<List<ClimaModel?>> buscarPorNome(String nome) async {
    if (nome.isEmpty) {
      throw Exception("Nome da cidade não pode estar vazio.");
    }
    return await iRepositoryApi.listarClimaNome(nome);
  }
}
