import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/interfaces/i_repository_api.dart';
import 'package:weather_station/infra/repository/repository_api.dart';
import 'package:weather_station/infra/service/api_service.dart';

class ListarLocaisPorLatLonUc {
  static ListarLocaisPorLatLonUc? _listarLocaisPorLatLonUc;

  ListarLocaisPorLatLonUc get getInstance {
    _listarLocaisPorLatLonUc ??= ListarLocaisPorLatLonUc(
      iRepositoryApi: RepositoryApi(
        apiService: ApiService().getInstance,
      ).getInstance,
    );
    return _listarLocaisPorLatLonUc!;
  }

  ListarLocaisPorLatLonUc({required this.iRepositoryApi});
  final IRepositoryApi iRepositoryApi;

  Future<List<ClimaModel?>> buscarPorLatLon(double lat, double lon) async {
    if (lat == 0.0 || lon == 0.0) {
      throw Exception("Latitude ou longitude inválidas.");
    }
    String latLon = lat.toString() + lon.toString();
    return await iRepositoryApi.listarClimaLatLong(latLon);
  }
}
