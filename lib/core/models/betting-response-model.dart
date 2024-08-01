class BettingResponseModel {
  Data? data;

  BettingResponseModel({this.data});

  BettingResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Bet9ja? bet9ja;
  Bet9ja? mLotto;
  Bet9ja? westernLotto;
  Bet9ja? bangBet;
  Bet9ja? nairaBet;
  Bet9ja? betKing;
  Bet9ja? greenLotto;
  Bet9ja? eliestLotto;
  Bet9ja? hALLABET;
  Bet9ja? betWay;
  Bet9ja? merryBet;
  Bet9ja? sureBet;
  Bet9ja? sportyBet;

  Data(
      {this.bet9ja,
      this.mLotto,
      this.westernLotto,
      this.bangBet,
      this.nairaBet,
      this.betKing,
      this.greenLotto,
      this.eliestLotto,
      this.hALLABET,
      this.betWay,
      this.merryBet,
      this.sureBet,
      this.sportyBet});

  Data.fromJson(Map<String, dynamic> json) {
    bet9ja = json['Bet9ja'] != null ? Bet9ja.fromJson(json['Bet9ja']) : null;
    mLotto = json['MLotto'] != null ? Bet9ja.fromJson(json['MLotto']) : null;
    westernLotto = json['Western Lotto'] != null
        ? Bet9ja.fromJson(json['Western Lotto'])
        : null;
    bangBet = json['BangBet'] != null ? Bet9ja.fromJson(json['BangBet']) : null;
    nairaBet =
        json['NairaBet'] != null ? Bet9ja.fromJson(json['NairaBet']) : null;
    betKing = json['BetKing'] != null ? Bet9ja.fromJson(json['BetKing']) : null;
    greenLotto =
        json['GreenLotto'] != null ? Bet9ja.fromJson(json['GreenLotto']) : null;
    eliestLotto = json['EliestLotto'] != null
        ? Bet9ja.fromJson(json['EliestLotto'])
        : null;
    hALLABET =
        json['HALLABET'] != null ? Bet9ja.fromJson(json['HALLABET']) : null;
    betWay = json['BetWay'] != null ? Bet9ja.fromJson(json['BetWay']) : null;
    merryBet =
        json['MerryBet'] != null ? Bet9ja.fromJson(json['MerryBet']) : null;
    sureBet = json['SureBet'] != null ? Bet9ja.fromJson(json['SureBet']) : null;
    sportyBet =
        json['SportyBet'] != null ? Bet9ja.fromJson(json['SportyBet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bet9ja != null) {
      data['Bet9ja'] = bet9ja!.toJson();
    }
    if (mLotto != null) {
      data['MLotto'] = mLotto!.toJson();
    }
    if (westernLotto != null) {
      data['Western Lotto'] = westernLotto!.toJson();
    }
    if (bangBet != null) {
      data['BangBet'] = bangBet!.toJson();
    }
    if (nairaBet != null) {
      data['NairaBet'] = nairaBet!.toJson();
    }
    if (betKing != null) {
      data['BetKing'] = betKing!.toJson();
    }
    if (greenLotto != null) {
      data['GreenLotto'] = greenLotto!.toJson();
    }
    if (eliestLotto != null) {
      data['EliestLotto'] = eliestLotto!.toJson();
    }
    if (hALLABET != null) {
      data['HALLABET'] = hALLABET!.toJson();
    }
    if (betWay != null) {
      data['BetWay'] = betWay!.toJson();
    }
    if (merryBet != null) {
      data['MerryBet'] = merryBet!.toJson();
    }
    if (sureBet != null) {
      data['SureBet'] = sureBet!.toJson();
    }
    if (sportyBet != null) {
      data['SportyBet'] = sportyBet!.toJson();
    }
    return data;
  }
}

class Bet9ja {
  int? id;
  String? slug;
  int? groupId;
  bool? skipValidation;
  bool? handleWithProductCode;
  bool? isRestricted;
  bool? hideInstitution;

  Bet9ja(
      {this.id,
      this.slug,
      this.groupId,
      this.skipValidation,
      this.handleWithProductCode,
      this.isRestricted,
      this.hideInstitution});

  Bet9ja.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    groupId = json['groupId'];
    skipValidation = json['skipValidation'];
    handleWithProductCode = json['handleWithProductCode'];
    isRestricted = json['isRestricted'];
    hideInstitution = json['hideInstitution'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['slug'] = slug;
    data['groupId'] = groupId;
    data['skipValidation'] = skipValidation;
    data['handleWithProductCode'] = handleWithProductCode;
    data['isRestricted'] = isRestricted;
    data['hideInstitution'] = hideInstitution;
    return data;
  }
}
