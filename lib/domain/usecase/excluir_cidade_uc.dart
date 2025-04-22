import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/repository/repository_clima_firebase.dart';

class ExcluirCidadeUc {
  static ExcluirCidadeUc? _excluirCidadeUc;

  ExcluirCidadeUc get getInstance{
    _excluirCidadeUc ??= ExcluirCidadeUc(repositoryClimaFirebase: repositoryClimaFirebase.getInstance);
    return _excluirCidadeUc!;
  }

  ExcluirCidadeUc({required this.repositoryClimaFirebase});
  final RepositoryClimaFirebase repositoryClimaFirebase;

  
  void excluir(ClimaModel climaModel) {
    if(climaModel.nome.isEmpty){
      throw Exception("Não foi possível excluir a cidade pois ela não existe");
    }
    repositoryClimaFirebase.excluirCidade(climaModel);
  }
}