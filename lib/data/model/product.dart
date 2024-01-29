class Product {
  Product({
    this.code,
    this.sn,
    this.name,
    this.lokasi,
    this.stock,
    this.unit,
    this.kondisi,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  String? code;
  String? sn;
  String? name;
  String? lokasi;
  int? stock;
  String? unit;
  String? kondisi;
  String? price;
  String? createdAt;
  String? updatedAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        code: json["code"],
        sn: json["sn"],
        name: json["name"],
        lokasi: json["lokasi"],
        stock:
            json["stock"] != null ? int.parse(json["stock"].toString()) : null,
        unit: json["unit"],
        kondisi: json["kondisi"],
        price: json["price"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "sn": sn,
        "name": name,
        "lokasi": lokasi,
        "stock": stock,
        "unit": unit,
        "kondisi": kondisi,
        "price": price,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };

  static where(Function(dynamic user) param0) {}
}
