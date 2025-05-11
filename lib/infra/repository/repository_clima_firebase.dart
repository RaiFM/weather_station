import 'package:weather_station/infra/interfaces/i_repository_clima.dart';
import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/service/clima_service.dart';

class RepositoryClimaFirebase implements IRepositoryClima {
  static RepositoryClimaFirebase? _repositoryClimaFirebase;

  static  RepositoryClimaFirebase get getInstance {
    _repositoryClimaFirebase ??= RepositoryClimaFirebase(
        climaService: ClimaService.getInstance);
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
     final cidadeMap = <String, dynamic>{
    'nome': climaModel.nome ,
    'diaSemana': climaModel.diaSemana,
    'temperatura': climaModel.temperatura,
    'descriptionClima': climaModel.descriptionClima,
    'data': climaModel.data,
    'tempMin': climaModel.tempMin,
    'tempMax': climaModel.tempMax,
    'icone': climaModel.icone,
    'umidade': climaModel.umidade,
    'chanceChuva': climaModel.chanceChuva,
    'precipitacao': climaModel.precipitacao,
    'velocidadeVento': climaModel.velocidadeVento,
    'direcaoVento': climaModel.direcaoVento,
    'cardinalVento': climaModel.cardinalVento,
    'nascerSol': climaModel.nascerSol,
    'porSol': climaModel.porSol,
    'faseLua': climaModel.faseLua,
    'fusoHorario': climaModel.fusoHorario,
  };
    try {
      climaService.salvarCidade(cidadeMap, climaModel.nome);
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
