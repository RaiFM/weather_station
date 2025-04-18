import 'package:weather_station/interfaces/i_repository_api.dart';
import 'package:weather_station/model/clima_model.dart';
import 'package:weather_station/service/api_service.dart';

class RepositoryApi implements IRepositoryApi{

  final ApiService apiService;
  RepositoryApi({required this.apiService});

  @override
  Future<List<ClimaModel>> listarClima() {
    // TODO: implement listarClima
    throw UnimplementedError();
  }

  @override
  Future<List<ClimaModel>?> listarClimaSalvos(List<String?> nomeCidades) {
    // TODO: implement listarClimaSalvos
    throw UnimplementedError();
  }
  
 }