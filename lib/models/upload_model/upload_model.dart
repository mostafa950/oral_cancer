class ResultModel {
  String? name;
  String? dateTime;
  String? text;
  String? resultImage;
  String? uId;
  String? idOfPost;

  ResultModel({
    this.name,
    this.dateTime,
    this.text,
    this.resultImage,
    this.uId,
  });

  ResultModel.fromJson(Map<String , dynamic >? json , id) {
    this.name = json!['name'];
    this.dateTime = json['dateTime'];
    this.text = json['text'];
    this.resultImage = json['resultImage'];
    this.uId = json['uId'];
    this.idOfPost = id;
  }

  Map<String , dynamic> toMap(){
    return {
      'name' : name,
      'dateTime' : dateTime,
      'text' : text,
      'resultImage' : resultImage,
      'uId' : uId,
    };
  }
}
