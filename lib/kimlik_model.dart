
class KimlikModel {
  String _kimlikNumarasi = "";
  String _kimlikIssueDate = "";
  String _kimlikHolderName = "";
  String _kimlikExpiryDate = "";
  String _kimlikHolderDateOfBirth = "";
  String _seriNo = "";

  @override
  String toString() {
    var string = '';
    string += _kimlikNumarasi.isEmpty ? "" : 'Kimlik Numarası = $kimlikNumarasi\n';
    string +=
    _kimlikExpiryDate.isEmpty ? "" : 'Kimlik Son Geçerlilik Tarihi = $kimlikExpiryDate\n';
    string +=
    _kimlikHolderName.isEmpty ? "" : 'kimlik Holder Name = $kimlikHolderName\n';
    string += _kimlikHolderDateOfBirth.isEmpty
        ? ""
        : 'Doğum Tarihi = $kimlikHolderDateOfBirth\n';
    string += _seriNo.isEmpty
        ? ""
        : 'Seri No = $_seriNo\n';
    return string;
  }

  String get kimlikNumarasi => _kimlikNumarasi;

  String get kimlikIssueDate => _kimlikIssueDate;

  String get kimlikHolderName => _kimlikHolderName;

  String get kimlikExpiryDate => _kimlikExpiryDate;

  String get seriNo => _seriNo;

  String get kimlikHolderDateOfBirth => _kimlikHolderDateOfBirth;

  set kimlikHolderDateOfBirth(String value) {
    _kimlikHolderDateOfBirth = value;
  }
  set seriNo(String value) {
    _seriNo = value;
  }

  set kimlikExpiryDate(String value) {
    _kimlikExpiryDate = value;
  }

  set kimlikHolderName(String value) {
    _kimlikHolderName = value;
  }

  set kimlikIssueDate(String value) {
    _kimlikIssueDate = value;
  }

  set kimlikNumarasi(String value) {
    _kimlikNumarasi = value;
  }
}
