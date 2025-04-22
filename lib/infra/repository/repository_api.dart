import 'package:weather_station/infra/interfaces/i_repository_api.dart';
import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/service/api_service.dart';

class RepositoryApi implements IRepositoryApi{

    static RepositoryApi? _repositoryApi;

    RepositoryApi get getInstance{
      _repositoryApi ??= RepositoryApi(apiService: apiService.getInstance);
      return _repositoryApi!;
    }

  final ApiService apiService;
  RepositoryApi({required this.apiService});

  @override
  Future<List<ClimaModel?>> listarClimaLatLong(String latLon) async {
   return await apiService.getInstance.pegarClimaSemanalLatLon(latLon);
  }
  
  @override
  Future<List<ClimaModel?>> listarClimaNome(String nomeCidade) async{
   return await apiService.getInstance.pegarClimaSemanalNome(nomeCidade);
  }

  @override
  Future<List<ClimaModel?>> listarClimaSalvos(List<String?> nomeCidade) async {
     return await apiService.getInstance.pegarClimaDiarioSalvo(nomeCidade);
  }
  
 }