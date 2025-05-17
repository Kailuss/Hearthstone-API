import 'dart:convert';

/// Clase que representa una carta de Hearthstone con todos sus atributos.
class HSCard {
  // Propiedades básicas de la carta
  int id; // ID único de la carta
  int collectible; // Si es coleccionable (1) o no (0)
  String slug; // Identificador único en formato texto (para URLs)
  int classId; // ID de la clase a la que pertenece (ej: Mago, Guerrero)
  List<int> multiClassIds; // IDs de clases adicionales (si es multiclase)
  int? spellSchoolId; // ID de la escuela de hechizos (null si no aplica)
  int cardTypeId; // Tipo de carta (ej: criatura, hechizo, arma)
  int cardSetId; // ID del set/expansión a la que pertenece
  int rarityId; // ID de la rareza (común, épica, legendaria, etc.)
  String artistName; // Nombre del artista que ilustró la carta
  int manaCost; // Coste de maná para jugar la carta
  String name; // Nombre de la carta
  String text; // Texto de habilidad/descripción
  String image; // URL de la imagen normal
  String imageGold; // URL de la imagen dorada (versión premium)
  String flavorText; // Texto de flavor (historia/descripción adicional)
  String cropImage; // URL de la imagen recortada (solo arte)

  // Propiedades opcionales/complejas
  List<int>? childIds; // IDs de cartas relacionadas (ej: partes de una carta combinada)
  List<int>? keywordIds; // IDs de palabras clave (ej: "Grito de batalla")
  bool isZilliaxFunctionalModule; // Si es un módulo funcional de Zilliax (carta especial)
  bool isZilliaxCosmeticModule; // Si es un módulo cosmético de Zilliax
  int? health; // Salud (solo para criaturas)
  int? attack; // Ataque (solo para criaturas/armas)
  int? minionTypeId; // Tipo de criatura (ej: bestia, demonio, mecánico)

  /// Constructor principal con todos los campos requeridos y opcionales
  HSCard({
    required this.id,
    required this.collectible,
    required this.slug,
    required this.classId,
    required this.multiClassIds,
    this.spellSchoolId,
    required this.cardTypeId,
    required this.cardSetId,
    required this.rarityId,
    required this.artistName,
    required this.manaCost,
    required this.name,
    required this.text,
    required this.image,
    required this.imageGold,
    required this.flavorText,
    required this.cropImage,
    this.childIds,
    this.keywordIds,
    required this.isZilliaxFunctionalModule,
    required this.isZilliaxCosmeticModule,
    this.health,
    this.attack,
    this.minionTypeId,
  });

  /// Constructor factory para crear una HSCard desde un JSON string
  factory HSCard.fromJson(String str) => HSCard.fromMap(json.decode(str));

  /// Convierte la carta a un JSON string
  String toJson() => json.encode(toMap());

  /// Constructor factory para crear una HSCard desde un Map (JSON decodificado)
  factory HSCard.fromMap(Map<String, dynamic> json) => HSCard(
        // Asignación con valores por defecto en caso de ser null
        id: json["id"] ?? 0,
        collectible: json["collectible"] ?? 0,
        slug: json["slug"] ?? "",
        classId: json["classId"] ?? 0,
        // Convierte una lista dinámica a List<int> o usa lista vacía si es null
        multiClassIds: json["multiClassIds"] != null ? List<int>.from(json["multiClassIds"].map((x) => x)) : [],
        spellSchoolId: json["spellSchoolId"], // Permite null
        cardTypeId: json["cardTypeId"] ?? 0,
        cardSetId: json["cardSetId"] ?? 0,
        rarityId: json["rarityId"] ?? 0,
        artistName: json["artistName"] ?? "Desconocido",
        manaCost: json["manaCost"] ?? 0,
        name: json["name"] ?? "Sin nombre",
        text: json["text"] ?? "",
        image: json["image"] ?? "",
        imageGold: json["imageGold"] ?? "",
        flavorText: json["flavorText"] ?? "",
        cropImage: json["cropImage"] ?? "",
        // Listas opcionales: si son null, se inicializan vacías
        childIds: json["childIds"] == null ? [] : List<int>.from(json["childIds"]!.map((x) => x)),
        keywordIds: json["keywordIds"] == null ? [] : List<int>.from(json["keywordIds"]!.map((x) => x)),
        isZilliaxFunctionalModule: json["isZilliaxFunctionalModule"] ?? false,
        isZilliaxCosmeticModule: json["isZilliaxCosmeticModule"] ?? false,
        health: json["health"], // Permite null
        attack: json["attack"],
        minionTypeId: json["minionTypeId"], // Permite null
      );

  /// Convierte la carta a un Map (para codificación JSON)
  Map<String, dynamic> toMap() => {
        // Mapeo directo de propiedades primitivas
        "id": id,
        "collectible": collectible,
        "slug": slug,
        "classId": classId,
        // Convierte List<int> a List<dynamic> para JSON
        "multiClassIds": List<dynamic>.from(multiClassIds.map((x) => x)),
        "spellSchoolId": spellSchoolId,
        "cardTypeId": cardTypeId,
        "cardSetId": cardSetId,
        "rarityId": rarityId,
        "artistName": artistName,
        "manaCost": manaCost,
        "name": name,
        "text": text,
        "image": image,
        "imageGold": imageGold,
        "flavorText": flavorText,
        "cropImage": cropImage,
        // Listas opcionales: si son null, se envía lista vacía
        "childIds": childIds == null ? [] : List<dynamic>.from(childIds!.map((x) => x)),
        "keywordIds": keywordIds == null ? [] : List<dynamic>.from(keywordIds!.map((x) => x)),
        "isZilliaxFunctionalModule": isZilliaxFunctionalModule,
        "isZilliaxCosmeticModule": isZilliaxCosmeticModule,
        "health": health,
        "attack": attack,
        "minionTypeId": minionTypeId,
      };
}
