
class KimlikModel {
  String _cnicNumber = "";
  String _cnicIssueDate = "";
  String _cnicHolderName = "";
  String _cnicExpiryDate = "";
  String _cnicHolderDateOfBirth = "";
  String _seriNo = "";

  @override
  String toString() {
    var string = '';
    string += _cnicNumber.isEmpty ? "" : 'Kimlik Numarası = $cnicNumber\n';
    string +=
    _cnicExpiryDate.isEmpty ? "" : 'Kimlik Son Geçerlilik Tarihi = $cnicExpiryDate\n';
    string +=
    _cnicIssueDate.isEmpty ? "" : 'Cnic Issue Date = $cnicIssueDate\n';
    string +=
    _cnicHolderName.isEmpty ? "" : 'Cnic Holder Name = $cnicHolderName\n';
    string += _cnicHolderDateOfBirth.isEmpty
        ? ""
        : 'Doğum Tarihi = $cnicHolderDateOfBirth\n';
    string += _seriNo.isEmpty
        ? ""
        : 'Seri No = $_seriNo\n';
    return string;
  }

  String get cnicNumber => _cnicNumber;

  String get cnicIssueDate => _cnicIssueDate;

  String get cnicHolderName => _cnicHolderName;

  String get cnicExpiryDate => _cnicExpiryDate;

  String get seriNo => _seriNo;

  String get cnicHolderDateOfBirth => _cnicHolderDateOfBirth;

  set cnicHolderDateOfBirth(String value) {
    _cnicHolderDateOfBirth = value;
  }
  set seriNo(String value) {
    _seriNo = value;
  }

  set cnicExpiryDate(String value) {
    _cnicExpiryDate = value;
  }

  set cnicHolderName(String value) {
    _cnicHolderName = value;
  }

  set cnicIssueDate(String value) {
    _cnicIssueDate = value;
  }

  set cnicNumber(String value) {
    _cnicNumber = value;
  }
}
