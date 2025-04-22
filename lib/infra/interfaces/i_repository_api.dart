import 'package:weather_station/domain/model/clima_model.dart';

abstract class IRepositoryApi {
  Future<List<ClimaModel?>> listarClimaNome(String nomeCidade);
  Future<List<ClimaModel?>> listarClimaLatLong(String latLon);
  Future<List<ClimaModel?>> listarClimaSalvos();
}