import 'package:Complex_ui/utils/universal_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final bool mini;
  final EdgeInsets margin;
  final Widget trailing;
  final Widget icon;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongTap;

  CustomTile(
      {@required this.leading,
      @required this.title,
      @required this.subtitle,
      this.mini = false,
      this.margin = const EdgeInsets.all(0),
      this.trailing,
      this.icon,
      this.onTap,
      this.onLongTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: mini ? 10 : 0),
        margin: margin,
        child: Row(children: <Widget>[
          leading,
          Expanded(child: Container(
            margin: EdgeInsets.only(left: mini ? 10 : 15 ),
            padding: EdgeInsets.symmetric(vertical: mini ? 3 : 20),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(
                color: UniversalVariables.separatorColor,
                width: 1
              ))
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    title,
                    SizedBox( height: 5,),
                    Row(
                      children: <Widget>[
                        icon ?? Container() ,
                        subtitle
                      ],
                    ),
                    trailing ?? Container(),
                  ],

                )
              ],
            ),
          ))
        ],),
      ),

    );
  }
}
