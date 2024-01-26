// To parse this JSON data, do
//
//     final createGem = createGemFromJson(jsonString);

import 'dart:convert';

CreateGem createGemFromJson(String str) => CreateGem.fromJson(json.decode(str));

String createGemToJson(CreateGem data) => json.encode(data.toJson());

class CreateGem {
  final GemPr gemPr;
  final Gem gem;

  CreateGem({
    required this.gemPr,
    required this.gem,
  });

  factory CreateGem.fromJson(Map<String, dynamic> json) => CreateGem(
        gemPr: GemPr.fromJson(json["gem_pr"]),
        gem: Gem.fromJson(json["gem"]),
      );

  Map<String, dynamic> toJson() => {
        "gem_pr": gemPr.toJson(),
        "gem": gem.toJson(),
      };
}

class Gem {
  final bool available;
  final String gemType;
  final int quantity;

  Gem({
    required this.quantity,
    required this.available,
    required this.gemType,
  });

  factory Gem.fromJson(Map<String, dynamic> json) => Gem(
        quantity: json["quantity"],
        available: json["available"],
        gemType: json["gem_type"],
      );

  Map<String, dynamic> toJson() => {
        "quantity": quantity,
        "available": available,
        "gem_type": gemType,
      };
}

class GemPr {
  final int size;
  final int clarity;
  final String color;

  GemPr({
    required this.size,
    required this.clarity,
    required this.color,
  });

  factory GemPr.fromJson(Map<String, dynamic> json) => GemPr(
        size: json["size"],
        clarity: json["clarity"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "size": size,
        "clarity": clarity,
        "color": color,
      };
}
