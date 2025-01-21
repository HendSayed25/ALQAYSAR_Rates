class Customer {
  final int? id;
  final int? uncooperative;
  final int? poor;
  final int? good;
  final int? veryGood;
  final int? excellent;
  final String? name;
  final List<String>? comments;

  Customer({
    this.id,
    this.uncooperative,
    this.poor,
    this.good,
    this.veryGood,
    this.excellent,
    this.name,
    this.comments,
  });

  int get totalRating {
    return uncooperative! + poor! + good! + veryGood! + excellent!;
  }

  double get rateOfUncooperative {
    return (totalRating == 0) ? 0.0 : uncooperative! / totalRating * 100;
  }

  double get rateOfPoor {
    return (totalRating == 0) ? 0.0 : poor! / totalRating * 100;
  }

  double get rateOfGood {
    return (totalRating == 0) ? 0.0 : good! / totalRating * 100;
  }

  double get rateOfVeryGood {
    return (totalRating == 0) ? 0.0 : veryGood! / totalRating * 100;
  }

  double get rateOfExcellent {
    return (totalRating == 0) ? 0.0 : excellent! / totalRating * 100;
  }

  double get rating {
    return (totalRating == 0)
        ? 0.0
        : (good! + veryGood! + excellent!) / totalRating * 5;
  }
}
