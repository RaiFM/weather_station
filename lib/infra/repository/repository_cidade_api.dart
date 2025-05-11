import 'package:weather_station/infra/interfaces/i_repository_cidade_api.dart';
import 'package:weather_station/infra/service/api_cidades_service.dart';

class RepositoryCidadeApi implements IRepositoryCidadeApi{
  static RepositoryCidadeApi? _repositoryCidadeApi;
  
  static RepositoryCidadeApi get getInstance{
    _repositoryCidadeApi ??= RepositoryCidadeApi(apiCidadesService: ApiCidadesService.getInstance);
    return _repositoryCidadeApi!;
  }
  RepositoryCidadeApi({
    required this.apiCidadesService,
  });

  ApiCidadesService apiCidadesService;



  @override
  Future<List<String>> listarCidades(int ufUser) async {
    List<String> lista = await apiCidadesService.getMunicipios(ufUser);
    return lista;
  }
  
}