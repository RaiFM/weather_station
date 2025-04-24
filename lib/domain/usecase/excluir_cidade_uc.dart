import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/interfaces/i_repository_clima.dart';
import 'package:weather_station/infra/repository/repository_api.dart';
import 'package:weather_station/infra/repository/repository_clima_firebase.dart';
import 'package:weather_station/infra/service/api_service.dart';
import 'package:weather_station/infra/service/clima_service.dart';

class ExcluirCidadeUc {
  static ExcluirCidadeUc? _excluirCidadeUc;

  ExcluirCidadeUc get getInstance{
    _excluirCidadeUc ??= ExcluirCidadeUc(repositoryClima: RepositoryClimaFirebase(climaService: ClimaService(iRepositoryApi: RepositoryApi(apiService: ApiService().getInstance).getInstance).getInstance).getInstance);
    return _excluirCidadeUc!;
  }

  ExcluirCidadeUc({required this.repositoryClima});
  final IRepositoryClima repositoryClima;

  
  void excluir(ClimaModel climaModel) {
    if(climaModel.nome.isEmpty){
      throw Exception("Não foi possível excluir a cidade pois ela não existe");
    }
    repositoryClima.excluirCidade(climaModel);
  }
}