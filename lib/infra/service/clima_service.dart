import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:weather_station/domain/model/clima_model.dart';
import 'package:weather_station/external/firestore_db.dart';
import 'package:weather_station/infra/interfaces/i_repository_api.dart';
import 'package:weather_station/infra/repository/repository_api.dart';

class ClimaService {
  static ClimaService? _climaService;
  final IRepositoryApi iRepositoryApi;

  static ClimaService get getInstance {
    _climaService ??= ClimaService(iRepositoryApi: RepositoryApi.getInstance);
    return _climaService!;
  }

  ClimaService({required this.iRepositoryApi});
  final db = FirestoreDB.getInstance;

  void salvarCidade(Map<String, dynamic> climaAtual, String name) async {
    try {
      await db.collection("climaAPP").doc(name).set(
            climaAtual,
            SetOptions(merge: true),
          );
    } catch (e) {
      Exception("Erro ao adicionar cidade: $e");
    }
  }

  void excluirCidade(String nomeCidade) async {
    try {
      await db.collection("climaAPP").doc(nomeCidade).delete();
    } catch (e) {
      Exception("Erro ao excluir cidade: $e");
    }
  }

  Future<List<ClimaModel?>> listarCidades() async {
    final querySnapshot = await db.collection("climaAPP").get();

    // Cria uma lista com os IDs dos documentos (que são os nomes das cidades)
    List<String?> listaCidades =
        querySnapshot.docs.map((doc) => doc.id).toList();

    // Chama o repositório para obter os dados com base nos nomes das cidades
    Future<List<ClimaModel?>> listaClima =
        iRepositoryApi.listarClimaSalvos(listaCidades);

    return listaClima;
  }

  
}
