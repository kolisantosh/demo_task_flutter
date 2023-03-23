class Notifier {
  String? to;
  Notifications? notification;
  Datas? data;
  Notifier({required this.to, required this.notification, required this.data});

  Notifier.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    notification = (json['notification'] != null ? new Notifications.fromJson(json['notification'])
        : null)!;
    data = (json['data'] != null ? new Datas.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to'] = this.to;
    if (this.notification != null) {
      data['notification'] = this.notification!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Notifications {
  String? title;
  String? body;
  String? tag;
  String? color;
  String? sound;

  Notifications({required this.title, required this.body,required this.tag,required this.color,required this.sound});

  Notifications.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    tag=json['tag'];
    color=json['color'];
    sound=json['sound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['tag']=this.tag;
    data['color']=this.color;
    data['sound']=this.sound;
    return data;
  }
}

class Datas {
  String? room_id;
  String? name;
  String? token;
  String? tag;

  Datas({required this.room_id,required this.name,required this.token,required this.tag});

  Datas.fromJson(Map<String, dynamic> json) {
    room_id = json['room_id'];
    name=json['name'];
    token=json['token'];
    tag=json['tag'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['room_id'] = this.name;
    data['name']=this.name;
    data['token']=this.token;
    data['tag']=this.tag;
    return data;
  }
}