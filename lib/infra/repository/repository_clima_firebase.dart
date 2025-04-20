import 'package:weather_station/infra/interfaces/i_repository_clima.dart';
import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/infra/service/clima_service.dart';

class RepositoryClimaFirebase implements IRepositoryClima {
  final ClimaService climaService;

  RepositoryClimaFirebase({
    required this.climaService
  });
  
  @override
  void deleteLastDay(String id) {
  
  }

  @override
  void insertLastDay(ClimaModel climaModel) {

  }

  @override
  List<ClimaModel?> listarLugaresSalvos() {
   
    throw UnimplementedError();
  }

  @override
  void salvarLocalizacao(ClimaModel climaModel) {
  }


}