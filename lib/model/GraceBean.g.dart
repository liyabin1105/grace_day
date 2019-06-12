// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GraceBean.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GraceBean _$GraceBeanFromJson(Map<String, dynamic> json) {
  return GraceBean()
    ..createdAt = json['createdAt'] as String
    ..updatedAt = json['updatedAt'] as String
    ..objectId = json['objectId'] as String
    ..ACL = json['ACL'] as Map<String, dynamic>
    ..content = json['content'] as String
    ..remark = json['remark'] as String
    ..time = json['time'] as String
    ..bgType = json['bgType'] as int
    ..color = json['color'] as int
    ..imgUrl = json['imgUrl'] as String
    ..author = json['author'] == null
        ? null
        : BmobUser.fromJson(json['author'] as Map<String, dynamic>)
    ..time1 = json['time1'] == null
        ? null
        : BmobDate.fromJson(json['time1'] as Map<String, dynamic>);
}

Map<String, dynamic> _$GraceBeanToJson(GraceBean instance) => <String, dynamic>{
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'objectId': instance.objectId,
      'ACL': instance.ACL,
      'content': instance.content,
      'remark': instance.remark,
      'time': instance.time,
      'bgType': instance.bgType,
      'color': instance.color,
      'imgUrl': instance.imgUrl,
      'author': instance.author,
      'time1': instance.time1
    };
