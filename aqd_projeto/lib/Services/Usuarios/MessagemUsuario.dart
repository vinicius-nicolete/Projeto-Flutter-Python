

class MessageUsuario {
  bool? message;


  MessageUsuario({this.message});

  MessageUsuario.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}

