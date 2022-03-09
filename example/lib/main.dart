import 'package:kimlik_okuyucu/kimlik_okuyucu.dart';
import 'package:kimlik_okuyucu/kimlik_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'custom_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kimlik Okuyucu',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameTEController = TextEditingController(),
      kimlikTcController = TextEditingController(),
      dobTEController = TextEditingController(),
      dogumTarihiController = TextEditingController(),
      sonGecerlilikController = TextEditingController();
  TextEditingController seriNoController = TextEditingController();

  /// you're required to initialize this model class as method you used
  /// from this package will return a model of KimlikModel type
  KimlikModel _kimlikModel = KimlikModel();


  Future<void> scankimlik(ImageSource imageSource) async {
    /// you will need to pass one argument of "ImageSource" as shown here
    KimlikModel kimlikModel =
    await KimlikOkuyucu().scanImage(imageSource: imageSource);
    _kimlikModel = kimlikModel;


    setState(() {

      kimlikTcController.text = _kimlikModel.kimlikNumarasi;
      dogumTarihiController.text = _kimlikModel.kimlikIssueDate;
      sonGecerlilikController.text = _kimlikModel.kimlikExpiryDate;
      seriNoController.text = _kimlikModel.seriNo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 18,
            ),


            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(0),
                shrinkWrap: true,
                children: [

                  _kimlikField(textEditingController: kimlikTcController),
                  _dataField(
                      text: 'Doğum Tarihi',
                      textEditingController: dogumTarihiController),
                  _dataField(
                      text: 'Kart Son Geçerlilik Tarihi',
                      textEditingController: sonGecerlilikController),
                  _dataField(
                      text: 'Seri Numarası',
                      textEditingController: seriNoController),
                  SizedBox(
                    height: 20,
                  ),
                  _getScankimlikBtn(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget _kimlikField({TextEditingController textEditingController}) {
    return Card(
      elevation: 7,
      margin: const EdgeInsets.only(top: 2.0, bottom: 5.0),
      child: Container(
        margin:
        const EdgeInsets.only(top: 2.0, bottom: 1.0, left: 0.0, right: 0.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 3,
                height: 45,
                margin: const EdgeInsets.only(left: 3.0, right: 7.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [

                      ],
                      stops: [
                        0.0,
                        0.5,
                        1.0
                      ],
                      tileMode: TileMode.mirror,
                      end: Alignment.bottomCenter,
                      begin: Alignment.topRight),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Kimlik numarası',
                        style: TextStyle(

                            fontSize: 13.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: textEditingController,
                              decoration: InputDecoration(

                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left: 5.0),
                              ),
                              style: TextStyle(

                                  fontWeight: FontWeight.bold),
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.left,
                            ),
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dataField(
      { String text,
         TextEditingController textEditingController}) {
    return Card(

        elevation: 5,
        margin: const EdgeInsets.only(
          top: 10,
          bottom: 5,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 5),

            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 15.0, top: 5, bottom: 3),
                    child: Text(
                      text.toUpperCase(),
                      style: TextStyle(

                          fontSize: 12,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, bottom: 5),
                    child: TextField(
                      controller: textEditingController,
                      decoration: InputDecoration(
                        hintText: (text == "İsim") ? "" : textEditingController.text,
                        border: InputBorder.none,
                        isDense: true,
                        hintStyle: TextStyle(

                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.all(0),
                      ),
                      style: TextStyle(

                          fontWeight: FontWeight.bold),
                      textInputAction: TextInputAction.done,
                      keyboardType: (text == "İsim")
                          ? TextInputType.text
                          : TextInputType.number,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _getScankimlikBtn() {
    return RaisedButton(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomDialogBox(onCameraBTNPressed: () {
                scankimlik(ImageSource.camera);
              }, onGalleryBTNPressed: () {
                scankimlik(ImageSource.gallery);
              });
            });
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          color: Colors.black,
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('Kimliği Tarat', style: TextStyle(fontSize: 18)),
      ),
    );
  }
}