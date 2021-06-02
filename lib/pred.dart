class Pred {
  String output;


  Pred(this.output);

  factory Pred.fromJson(dynamic json) {
    return Pred(json['output'] as String);
  }

  @override
  String toString() {
    return '{ ${this.output} }';
  }
}