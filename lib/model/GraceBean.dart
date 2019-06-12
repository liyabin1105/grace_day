import 'package:data_plugin/bmob/table/bmob_user.dart';
import 'package:data_plugin/bmob/type/bmob_date.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:data_plugin/bmob/table/bmob_object.dart';
part 'GraceBean.g.dart';


@JsonSerializable()
class GraceBean extends BmobObject {

  String content; //计划内容

  String remark; //备注

  String time; //时间

  int bgType; //背景类型，0：颜色背景，1：图片背景

  int color; //背景颜色

  String imgUrl; //背景图片

  BmobUser author;
  BmobDate time1;
  GraceBean();

  //此处与类名一致，由指令自动生成代码
  factory GraceBean.fromJson(Map<String, dynamic> json) =>
      _$GraceBeanFromJson(json);


  //此处与类名一致，由指令自动生成代码
  Map<String, dynamic> toJson() => _$GraceBeanToJson(this);

  @override
  Map getParams() {
    return toJson();
  }

}