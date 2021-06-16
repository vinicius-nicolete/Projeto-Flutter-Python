

class MessagePessoa {
  bool? message;


  MessagePessoa({this.message});

  MessagePessoa.fromJson(Map<dynamic, dynamic> json) {
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    return data;
  }
}

