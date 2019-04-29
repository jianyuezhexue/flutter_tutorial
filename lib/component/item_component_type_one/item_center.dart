import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';
import 'package:flutter_sample/utils/screen_util.dart';
import '../../style/style.dart' as styles;

class ItemCenterView extends StatefulWidget {
  final String articleTitle; //大标题
  final String imgUrl; //图片地址
  final Function onImageClick;
  ItemCenterView(this.articleTitle, this.imgUrl, {this.onImageClick});

  @override
  State<StatefulWidget> createState() {
    return new ItemCenterViewImp();
  }
}

class ItemCenterViewImp extends State<ItemCenterView> {
  var isDown = false;
  var centerImgSize;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334)..init(context);
    var screenInstance = ScreenUtil.getInstance();
    centerImgSize = (ScreenUtil.screenWidthDp - 50); //根据屏幕宽度适配

    return Container(
      width: ScreenUtil.screenWidth,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.fromLTRB(0.0, screenInstance.setHeight(29),
                  0.0, screenInstance.setHeight(26)),
              child: new Text(
                widget.articleTitle,
                textAlign: TextAlign.left,
                style: new TextStyle(
                    color: styles.ComponentStyle.TITLE_TEXT_COLOR,
                    fontSize: screenInstance.setSp(32)),
              ),
            ),
            _renderViewGroup(screenInstance, context),
          ]),
    );
  }

  _click(BuildContext context, String url) {
    if (null != widget.onImageClick) {
      widget.onImageClick(url);
    }
    FlutterBoost.singleton.openPage("nio://nativePage", {"query": {"key": "value"}});
  }

  Widget _renderViewGroup(ScreenUtil screenInstance, BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        foregroundDecoration: BoxDecoration(
          color: isDown ? Colors.white.withOpacity(0.5) : Colors.transparent,
        ),
        child: new Container(
          width: centerImgSize,
          height: centerImgSize,
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new NetworkImage(widget.imgUrl),
              fit: BoxFit.cover,
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(6.0)),
          ),
        ),
      ),
      onTap: () => _click(context, widget.imgUrl),
      onTapDown: (d) => setState(() => this.isDown = true),
      onTapUp: (d) => setState(() => this.isDown = false),
      onTapCancel: () => setState(() => this.isDown = false),
    );
  }
}
