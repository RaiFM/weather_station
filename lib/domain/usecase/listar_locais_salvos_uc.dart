import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/interfaces/i_repository_clima.dart';
import 'package:weather_station/infra/repository/repository_salvos_firebase.dart';


class ListarLocaisSalvosUc {
  static ListarLocaisSalvosUc? _listarLocaisSalvosUc;

  static ListarLocaisSalvosUc get getInstance {
    _listarLocaisSalvosUc ??= ListarLocaisSalvosUc(
      iRepositoryClima: RepositoryClimaFirebase.getInstance,
    );
    return _listarLocaisSalvosUc!;
  }

  ListarLocaisSalvosUc({required this.iRepositoryClima});
  final IRepositoryClima iRepositoryClima;

  Future<List<ClimaModel?>> buscar() async {
    return await iRepositoryClima.listarLugaresSalvos();
  }
}
