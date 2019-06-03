import 'package:flutter/material.dart';

///自定义Dialog
class CustomDialog extends StatefulWidget {

  final String title; //弹窗标题
  final String content; //弹窗内容
  final String confirmContent; //按钮文本
  final Color confirmTextColor; //确定按钮文本颜色
  final bool isCancel; //是否有取消按钮，默认为true true：有 false：没有
  final Color confirmColor; //确定按钮颜色
  final Color cancelColor; //取消按钮颜色
  final bool outsideDismiss; //点击弹窗外部，关闭弹窗，默认为true true：可以关闭 false：不可以关闭
  final Function confirmCallback; //点击确定按钮回调
  final Function dismissCallback; //弹窗关闭回调

  const CustomDialog({Key key, this.title, this.content, this.confirmContent, this.confirmTextColor, this.isCancel = true, this.confirmColor, this.cancelColor, this.outsideDismiss = true, this.confirmCallback, this.dismissCallback}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CustomDialogState();
  }
}

class _CustomDialogState extends State<CustomDialog> {

  _confirmDialog() {
    _dismissDialog();
    if (widget.confirmCallback != null) {
      widget.confirmCallback();
    }
  }

  _dismissDialog() {
    if (widget.dismissCallback != null) {
      widget.dismissCallback();
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return WillPopScope(
      child: GestureDetector(
        onTap: () => {
        widget.outsideDismiss ? _dismissDialog() : null
        },
        child: Material(
          type: MaterialType.transparency,
          child: Center(
            child: Container(
              width: width - 100.0,
              height: 150.0,
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  SizedBox(
                      height: widget.title == null ? 0 : 16.0
                  ),
                  Text(
                      widget.title == null ? '' : widget.title,
                      style: TextStyle(fontSize: 16.0)
                  ),
                  Expanded(
                      child: Center(
                        child: Text(
                            widget.content == null ? '' : widget.content,
                            style: TextStyle(fontSize: 14.0)
                        ),
                      ),
                      flex: 1
                  ),
                  SizedBox(
                      height: 1.0,
                      child: Container(color: Color(0xDBDBDBDB))
                  ),
                  Container(
                      height: 45,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: widget.isCancel ? Container(
                                decoration: BoxDecoration(
                                    color: widget.cancelColor == null ? Color(0xFFFFFFFF) : widget.cancelColor,
                                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.0))
                                ),
                                child: FlatButton(
                                  child: Text(
                                      '取消',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: widget.cancelColor == null ? Colors.black87 : Color(0xFFFFFFFF),
                                      )
                                  ),
                                  onPressed: _dismissDialog,
                                  splashColor: widget.cancelColor == null ? Color(0xFFFFFFFF) : widget.cancelColor,
                                  highlightColor: widget.cancelColor == null ? Color(0xFFFFFFFF) : widget.cancelColor,
                                ),
                              ) : Text(''),
                              flex: widget.isCancel ? 1 : 0
                          ),
                          SizedBox(width: widget.isCancel ? 1.0 : 0,child: Container(color: Color(0xDBDBDBDB))),
                          Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: widget.confirmColor == null ? Color(0xFFFFFFFF) : widget.confirmColor,
                                    borderRadius: widget.isCancel ? BorderRadius.only(bottomRight: Radius.circular(12.0)) : BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight: Radius.circular(12.0))
                                ),
                                child: FlatButton(
                                  onPressed: _confirmDialog,
                                  child: Text(
                                      widget.confirmContent == null ? '确定' : widget.confirmContent,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: widget.confirmColor == null ? (widget.confirmTextColor == null ? Colors.black87 : widget.confirmTextColor) : Color(0xFFFFFFFF),
                                      )
                                  ),
                                  splashColor: widget.confirmColor == null ? Color(0xFFFFFFFF) : widget.confirmColor,
                                  highlightColor: widget.confirmColor == null ? Color(0xFFFFFFFF) : widget.confirmColor,
                                ),
                              ),
                              flex: 1
                          ),
                        ],
                      )
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(12.0)
              ),
            ),
          ),
        ),
      ),
      onWillPop: () async {
        return widget.outsideDismiss;
      }
    );
  }
}