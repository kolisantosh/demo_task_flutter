class NotificationModel {
  NotificationModel({
    this.notiId,
    this.userId,
    this.userName,
    this.doctorId,
    this.tokenId,
    this.addedOn,
  });

  String? notiId;
  String? userId;
  String? userName;
  String? doctorId;
  String? tokenId;
  String? addedOn;

  factory NotificationModel.fromMap(Map<String, dynamic> json) => NotificationModel(
    notiId: json["noti_id"],
    userId: json["user_id"],
    userName: json["user_name"],
    doctorId: json["doctor_id"],
    tokenId: json["token_id"],
    addedOn: json["added_on"],
  );

  static List<NotificationModel> getJsonData(List<dynamic> list){
    List<NotificationModel> notiData=[];
    list.forEach((element)=> notiData.add(NotificationModel.fromMap(element)));
    return notiData;
  }
}