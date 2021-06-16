class LoginUsuario {
  String? email;
  String? lastname;
  bool? message;
  String? name;

  LoginUsuario({this.email, this.lastname, this.message, this.name});

  LoginUsuario.fromJson(Map<dynamic, dynamic> json) {
    email = json['email'];
    lastname = json['lastname'];
    message = json['message'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['lastname'] = this.lastname;
    data['message'] = this.message;
    data['name'] = this.name;
    return data;
  }
}
