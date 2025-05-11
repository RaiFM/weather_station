import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/interfaces/i_repository_clima.dart';
import 'package:weather_station/infra/repository/repository_clima_firebase.dart';

class SalvarCidadeUc {
  static SalvarCidadeUc? _salvarCidadeUc;

  static SalvarCidadeUc get getInstance {
    _salvarCidadeUc ??= SalvarCidadeUc(
      repositoryClima: RepositoryClimaFirebase.getInstance,
    );
    return _salvarCidadeUc!;
  }

  SalvarCidadeUc({required this.repositoryClima});
  final IRepositoryClima repositoryClima;

  void salvar(ClimaModel climaModel) {
    if (climaModel.nome.isEmpty) {
      throw Exception("Não é possível salvar uma cidade sem nome dela.");
    }
    repositoryClima.salvarCidade(climaModel);
  }
}
