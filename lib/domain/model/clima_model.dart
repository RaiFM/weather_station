
class ClimaModel {
  String nome;
  String diaSemana;
  int temperatura;
  String descriptionClima;
  String data;
  int tempMin;
  int tempMax;
  String icone;
  int umidade;
  int chanceChuva;
  double precipitacao;
  String velocidadeVento;
  int direcaoVento;
  String cardinalVento;
  String nascerSol;
  String  porSol;
  String  faseLua;
  String  fusoHorario;


  ClimaModel({
    required this.nome,
    required this.diaSemana,
    required this.temperatura,
    required this.descriptionClima,
    required this.data,
    required this.tempMin,
    required this.tempMax,
    required this.icone,
    required this.precipitacao,
    required this.chanceChuva,
    required this.umidade,
    required this.velocidadeVento, 
    required this.direcaoVento, 
    required this.cardinalVento, 
    required this.nascerSol, 
    required this.porSol, 
    required this.faseLua, 
    required this.fusoHorario,
  } 
  );
  }
