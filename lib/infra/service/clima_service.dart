import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/external/firestore_db.dart';
import 'package:weather_station/infra/service/api_service.dart';

class ClimaService {
  static ClimaService? _climaService;
  final ApiService apiService;
  ClimaService get getInstance {
    _climaService ??= ClimaService(apiService: ApiService().getInstance);
    return _climaService!;
  }

  ClimaService({required this.apiService});
  final db = FirestoreDB.getInstance;

  void salvarCidade(String nomeCidade) async {
    final cidadeMap = <String, String>{
      nomeCidade: nomeCidade,
    };

    try {
      await db.collection("climaAPP").doc("cidades").set(
            cidadeMap,
            SetOptions(merge: true),
          );

    } catch (e) {
      Exception("Erro ao adicionar cidade: $e");
    }
  }

  void excluirCidade(String nomeCidade) async {
    try {
      final updates = <String, dynamic>{
        nomeCidade: FieldValue.delete(),
      };
      await db.collection("climaAPP").doc("cidades").update(updates);
    } catch (e) {
      Exception("Erro ao excluir cidade: $e");
    }
  }

  Future<List<ClimaModel?>> listarCidades() async {
    final docSnapshot = await db.collection("climaAPP").doc("cidades").get();

    if (docSnapshot.exists) {
      final data = docSnapshot.data() as Map<String, dynamic>;

      Map<String, String> mapFirebase = data
          .map((String key, dynamic value) => MapEntry(key, value.toString()));
      List<String?> listaCidades = [];
      for (String cidade in mapFirebase.keys) {
        listaCidades.add(cidade);
      }

      Future<List<ClimaModel?>> listaClima =
          apiService.pegarClimaDiarioSalvo(listaCidades);

      return listaClima;
    } else {
      return [];
    }
  }
}
