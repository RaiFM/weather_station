import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/interfaces/i_repository_api.dart';
import 'package:weather_station/infra/repository/repository_api.dart';
import 'package:weather_station/infra/service/api_service.dart';

class ListarLocaisSalvosUc {
  static ListarLocaisSalvosUc? _listarLocaisSalvosUc;

  ListarLocaisSalvosUc get getInstance {
    _listarLocaisSalvosUc ??= ListarLocaisSalvosUc(
      iRepositoryApi: RepositoryApi(
        apiService: ApiService().getInstance,
      ).getInstance,
    );
    return _listarLocaisSalvosUc!;
  }

  ListarLocaisSalvosUc({required this.iRepositoryApi});
  final IRepositoryApi iRepositoryApi;

  Future<List<ClimaModel?>> buscar(List<String?> nomeCidade) async {
    if (nomeCidade.isEmpty) {
      throw Exception("Não há cidades.");
    }
    return await iRepositoryApi.listarClimaSalvos(nomeCidade);
  }
}
