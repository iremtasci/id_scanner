import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomDialogBox extends StatefulWidget {
  Function onCameraBTNPressed, onGalleryBTNPressed;

  CustomDialogBox(
      { this.onCameraBTNPressed,  this.onGalleryBTNPressed});

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 20, top: 65, right: 20, bottom: 20),
          margin: EdgeInsets.only(top: 45),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Kimlik Tarayıcı',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                'Kimlik bilgilerinizin otomatik doldurulması için lütfen titretmeden kimliğin ön yüzünün fotoğrafını çekiniz.',
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 22,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                        widget.onCameraBTNPressed();
                      },
                      child: Text(
                        'KAMERAYI AÇ',
                        style: TextStyle(
                            fontSize: 18, color:Colors.red),
                      )),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          right: 20,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 45,
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(45))),
          ),
        ),
      ],
    );
  }
}
