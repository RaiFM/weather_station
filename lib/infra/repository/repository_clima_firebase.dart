import 'package:weather_station/infra/interfaces/i_repository_api.dart';
import 'package:weather_station/infra/interfaces/i_repository_clima.dart';
import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/service/clima_service.dart';

class RepositoryClimaFirebase implements IRepositoryClima {
  static RepositoryClimaFirebase? _repositoryClimaFirebase;

  RepositoryClimaFirebase get getInstance {
    _repositoryClimaFirebase ??= RepositoryClimaFirebase(
        climaService: climaService.getInstance);
    return _repositoryClimaFirebase!;
  }

  final ClimaService climaService;
  

  RepositoryClimaFirebase(
      {required this.climaService});

  @override
  Future<List<ClimaModel?>> listarLugaresSalvos() async {
    try {
     
       List<ClimaModel?> listaLugares = await climaService.listarCidades();
      return listaLugares;
    } catch (e) {
      Exception("Erro ao listar cidades salvas");
      return [];
    }
  }

  @override
  void salvarCidade(ClimaModel climaModel) {
    try {
      String nome = climaModel.nome;
      climaService.salvarCidade(nome);
    } catch (e) {
      Exception("Erro ao excluir cidade");
    }
  }

  @override
  void excluirCidade(ClimaModel climaModel) {
    try {
      String nome = climaModel.nome;
      climaService.excluirCidade(nome);
    } catch (e) {
      Exception("Erro ao excluir cidade");
    }
  }
}
