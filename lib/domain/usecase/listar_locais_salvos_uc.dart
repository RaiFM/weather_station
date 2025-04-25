import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/interfaces/i_repository_api.dart';
import 'package:weather_station/infra/interfaces/i_repository_clima.dart';
import 'package:weather_station/infra/repository/repository_api.dart';
import 'package:weather_station/infra/repository/repository_clima_firebase.dart';
import 'package:weather_station/infra/service/api_service.dart';
import 'package:weather_station/infra/service/clima_service.dart';

class ListarLocaisSalvosUc {
  static ListarLocaisSalvosUc? _listarLocaisSalvosUc;

  ListarLocaisSalvosUc get getInstance {
    _listarLocaisSalvosUc ??= ListarLocaisSalvosUc(
      iRepositoryClima: RepositoryClimaFirebase(climaService: ClimaService(iRepositoryApi: RepositoryApi(apiService: ApiService().getInstance).getInstance).getInstance).getInstance,
    );
    return _listarLocaisSalvosUc!;
  }

  ListarLocaisSalvosUc({required this.iRepositoryClima});
  final IRepositoryClima iRepositoryClima;

  Future<List<ClimaModel?>> buscar() async {
    return await iRepositoryClima.listarLugaresSalvos();
  }
}
