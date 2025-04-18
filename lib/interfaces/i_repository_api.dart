import 'package:weather_station/model/clima_model.dart';

abstract class IRepositoryApi {
  Future<List<ClimaModel>> listarClima();
  Future<List<ClimaModel>?> listarClimaSalvos(List<String?> nomeCidades);
}