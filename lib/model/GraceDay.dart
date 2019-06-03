///日程
class GraceDay extends Object {

  int id; //id

  String content; //计划内容

  String remark; //备注

  String time; //时间

  int bgType; //背景类型，0：颜色背景，1：图片背景

  int color; //背景颜色

  String imgUrl; //背景图片


  GraceDay(this.id,this.content,this.remark,this.time, this.bgType, this.color, this.imgUrl);

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map['id'] = id;
    map['content'] = content;
    map['remark'] = remark;
    map['time'] = time;
    map['bgType'] = bgType;
    map['color'] = color;
    map['imgUrl'] = imgUrl;
    return map;
  }

  GraceDay.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.content = map['content'];
    this.remark = map['remark'];
    this.time = map['time'];
    this.bgType = map['bgType'];
    this.color = map['color'];
    this.imgUrl = map['imgUrl'];
  }

}