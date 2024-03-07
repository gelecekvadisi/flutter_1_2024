class Ogrenci {
  String? _adSoyad;
  int? _yas;
  bool? _mezunMu;
  List<String>? _aldigiDersler;
  bool? _erkekMi;
  String? _danisman;
  double? _gno;

  Ogrenci(
      {String? adSoyad,
      int? yas,
      bool? mezunMu,
      List<String>? aldigiDersler,
      bool? erkekMi,
      String? danisman,
      double? gno}) {
    if (adSoyad != null) {
      this._adSoyad = adSoyad;
    }
    if (yas != null) {
      this._yas = yas;
    }
    if (mezunMu != null) {
      this._mezunMu = mezunMu;
    }
    if (aldigiDersler != null) {
      this._aldigiDersler = aldigiDersler;
    }
    if (erkekMi != null) {
      this._erkekMi = erkekMi;
    }
    if (danisman != null) {
      this._danisman = danisman;
    }
    if (gno != null) {
      this._gno = gno;
    }
  }

  String? get adSoyad => _adSoyad;
  set adSoyad(String? adSoyad) => _adSoyad = adSoyad;
  int? get yas => _yas;
  set yas(int? yas) => _yas = yas;
  bool? get mezunMu => _mezunMu;
  set mezunMu(bool? mezunMu) => _mezunMu = mezunMu;
  List<String>? get aldigiDersler => _aldigiDersler;
  set aldigiDersler(List<String>? aldigiDersler) =>
      _aldigiDersler = aldigiDersler;
  bool? get erkekMi => _erkekMi;
  set erkekMi(bool? erkekMi) => _erkekMi = erkekMi;
  String? get danisman => _danisman;
  set danisman(String? danisman) => _danisman = danisman;
  double? get gno => _gno;
  set gno(double? gno) => _gno = gno;

  Ogrenci.fromJson(Map<String, dynamic> json) {
    _adSoyad = json['adSoyad'];
    _yas = json['yas'];
    _mezunMu = json['mezunMu'];
    _aldigiDersler = json['aldigiDersler'].cast<String>();
    _erkekMi = json['erkekMi'];
    _danisman = json['danisman'];
    _gno = json['gno'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adSoyad'] = this._adSoyad;
    data['yas'] = this._yas;
    data['mezunMu'] = this._mezunMu;
    data['aldigiDersler'] = this._aldigiDersler;
    data['erkekMi'] = this._erkekMi;
    data['danisman'] = this._danisman;
    data['gno'] = this._gno;
    return data;
  }

  @override
  String toString() {
    return adSoyad ?? "";
  }
}
