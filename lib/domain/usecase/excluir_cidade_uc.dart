import 'package:weather_station/infra/interfaces/i_repository_clima.dart';
import 'package:weather_station/infra/repository/repository_salvos_firebase.dart';

class ExcluirCidadeUc {
  static ExcluirCidadeUc? _excluirCidadeUc;

  static ExcluirCidadeUc get getInstance{
    _excluirCidadeUc ??= ExcluirCidadeUc(repositoryClima: RepositoryClimaFirebase.getInstance);
    return _excluirCidadeUc!;
  }

  ExcluirCidadeUc({required this.repositoryClima});
  final IRepositoryClima repositoryClima;

  
  void excluir(String nome) {
    if(nome.isEmpty){
      throw Exception("Não foi possível excluir a cidade pois ela não existe");
    }
    repositoryClima.excluirCidade(nome);
  }
}