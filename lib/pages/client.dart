// import 'dart:html';

class Client {
  // ignore: non_constant_identifier_names
  String id;
  // ignore: non_constant_identifier_names
  String Nome;
  // ignore: non_constant_identifier_names
  String Cpf;

  String telefone;
  String email;

  // ignore: non_constant_identifier_names
  Client({
    this.id,
    this.Nome,
    this.Cpf,
    this.telefone,
    this.email,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    print(json['id']);

    return Client(
      id: json['id'],
      Nome: json['nome'],
      Cpf: json['cpf'],
      telefone: json['telefone'],
      email: json['email'],
    );
  }
}
