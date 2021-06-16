class ListarUsuario {
  String? email;
  String? lastname;
  String? name;
  int? userid;

  ListarUsuario({this.email, this.lastname, this.name, this.userid});

  ListarUsuario.fromJson(Map<dynamic, dynamic> json) {
    email = json['email'];
    lastname = json['lastname'];
    name = json['name'];
    userid = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['lastname'] = this.lastname;
    data['name'] = this.name;
    data['userid'] = this.userid;
    return data;
  }
}
