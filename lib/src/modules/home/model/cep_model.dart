class CEPModel {
  String cep = "";
  String logradouro = "";
  String complemento = "";
  String bairro = "";
  String localidade = "";
  String uf = "";
  bool erro = false;

  CEPModel({
    this.cep = "",
    this.logradouro = "",
    this.complemento = "",
    this.bairro = "",
    this.localidade = "",
    this.uf = "", 
    required bool erro
  });

  CEPModel.fromJson(Map<String, dynamic> json) {
    if (json['erro'] != null) {
      erro = true;
      return;
    }
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'];
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cep'] = cep;
    data['logradouro'] = logradouro;
    data['complemento'] = complemento;
    data['bairro'] = bairro;
    data['localidade'] = localidade;
    data['uf'] = uf;
    return data;
  }
}