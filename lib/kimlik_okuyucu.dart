

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'kimlik_model.dart';


class KimlikOkuyucu {
  /// it will pick your image either form Gallery or from Camera
  final ImagePicker _picker = ImagePicker();

  /// it will check the image source
  late ImageSource source;

  /// a model class to store kimlik data
  KimlikModel _kimlikDetay = KimlikModel();




  /// this method will be called when user uses this package
  Future<KimlikModel> scanImage({required ImageSource imageSource}) async {
    source = imageSource;
    XFile? image = await _picker.pickImage(source: imageSource);
    if (image == null) {
      return Future.value(_kimlikDetay);
    }
    if(_kimlikDetay.seriNo != "") {
      print("tamamdır");
    }
    else {
      return await scankimlik(imageToScan: InputImage.fromFilePath(image.path));
    }
    return await scankimlik(imageToScan: InputImage.fromFilePath(image.path));
  }

  /// this method will process the images and extract information from the card
  Future<KimlikModel> scankimlik({required InputImage imageToScan}) async {
    List<String> kimlikTarihleri = [];
    GoogleMlKit.vision.languageModelManager();
    TextDetector textDetector = GoogleMlKit.vision.textDetector();
    final RecognisedText recognisedText =
    await textDetector.processImage(imageToScan);

    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {

        for (TextElement element in line.elements) {
          String selectedText = element.text;
          if (selectedText != null &&
              selectedText.length == 11 && !selectedText.contains("N") && !selectedText.contains("a") && !selectedText.contains(RegExp(r'[A-Z]'))) {
            _kimlikDetay.kimlikNumarasi = selectedText;
          } else if (selectedText != null &&
              selectedText.length == 10 &&
              ((selectedText.contains("/", 2) &&
                  selectedText.contains("/", 5)) ||
                  (selectedText.contains(".", 2) &&
                      selectedText.contains(".", 5)))) {
            kimlikTarihleri.add(selectedText.replaceAll(".", "/"));
          }
        }
        for (TextElement element in line.elements) {
          String seriNo = element.text;
          if (seriNo != null &&
              seriNo.length == 9 && seriNo.contains(RegExp(r'[A-Z]')) && seriNo.contains(RegExp(r'[0-9]'))) {
            _kimlikDetay.seriNo = seriNo;
          }
        }
      }
    }
    if (kimlikTarihleri.length > 0 &&
        _kimlikDetay.kimlikExpiryDate.length == 10 &&
        !kimlikTarihleri.contains(_kimlikDetay.kimlikExpiryDate)) {
      kimlikTarihleri.add(_kimlikDetay.kimlikExpiryDate);
    }
    if (kimlikTarihleri.length > 0 &&
        _kimlikDetay.kimlikIssueDate.length == 10 &&
        !kimlikTarihleri.contains(_kimlikDetay.kimlikIssueDate)) {
      kimlikTarihleri.add(_kimlikDetay.kimlikIssueDate);
    }
    if (kimlikTarihleri.length > 0 &&
        _kimlikDetay.kimlikExpiryDate.length == 10 &&
        !kimlikTarihleri.contains(_kimlikDetay.kimlikExpiryDate)) {
      kimlikTarihleri.add(_kimlikDetay.kimlikExpiryDate);
    }
    if (kimlikTarihleri.length > 1) {
      kimlikTarihleri = sortDateList(dates: kimlikTarihleri);
    }
    if (kimlikTarihleri.length == 1 &&
        _kimlikDetay.kimlikHolderDateOfBirth.length != 10) {
      _kimlikDetay.kimlikHolderDateOfBirth = kimlikTarihleri[0];


    } else if (kimlikTarihleri.length == 2) {
      _kimlikDetay.kimlikIssueDate = kimlikTarihleri[0];
      _kimlikDetay.kimlikExpiryDate = kimlikTarihleri[1];

    } else if (kimlikTarihleri.length == 3) {
      _kimlikDetay.kimlikHolderDateOfBirth = kimlikTarihleri[0].replaceAll(".", "/");
      _kimlikDetay.kimlikIssueDate = kimlikTarihleri[1].replaceAll(".", "/");
      _kimlikDetay.kimlikExpiryDate = kimlikTarihleri[2].replaceAll(".", "/");
    }
    textDetector.close();
    if (_kimlikDetay.kimlikNumarasi.length > 0 ||
        _kimlikDetay.kimlikHolderDateOfBirth.length > 0 &&
            _kimlikDetay.kimlikIssueDate.length > 0 &&
            _kimlikDetay.kimlikExpiryDate.length > 0) {
      print('KİMLİK DETAYLARI$_kimlikDetay');
      return Future.value(_kimlikDetay);
    } else {
      print('KİMLİK DETAYLARI $_kimlikDetay');
      return await scanImage(imageSource: source);
    }
  }

  static List<String> sortDateList({required List<String> dates}) {
    List<DateTime> tempList = [];
    DateFormat format = DateFormat("dd/MM/yyyy");
    for (int i = 0; i < dates.length; i++) {
      tempList.add(format.parse(dates[i]));
    }
    tempList.sort((a, b) => a.compareTo(b));
    dates.clear();
    for (int i = 0; i < tempList.length; i++) {
      dates.add(format.format(tempList[i]));
    }
    return dates;
  }
}
