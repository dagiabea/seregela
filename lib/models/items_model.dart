// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Items> welcomeFromJson(String str) => List<Items>.from(json.decode(str).map((x) => Items.fromJson(x)));

String welcomeToJson(List<Items> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Items {
    String itemName;
    String imageUrl;
    double price;
    Catagory catagory;
    int itemId;
    List<ItemDescription>? itemDescription;

    Items({
        required this.itemName,
        required this.imageUrl,
        required this.price,
        required this.catagory,
        required this.itemId,
        this.itemDescription,
    });

    factory Items.fromJson(Map<String, dynamic> json) => Items(
        itemName: json["item name"],
        imageUrl: json["image url"],
        price: json["price"]?.toDouble(),
        catagory: catagoryValues.map[json["catagory"]]!,
        itemId: json["item id"],
        itemDescription: json["item description"] == null ? [] : List<ItemDescription>.from(json["item description"]!.map((x) => ItemDescription.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "item name": itemName,
        "image url": imageUrl,
        "price": price,
        "catagory": catagoryValues.reverse[catagory],
        "item id": itemId,
        "item description": itemDescription == null ? [] : List<dynamic>.from(itemDescription!.map((x) => x.toJson())),
    };
}

enum Catagory { PACKAGE, FOOD, HOME_CARE, SELF_CARE }

final catagoryValues = EnumValues({
    "Food": Catagory.FOOD,
    "Home Care": Catagory.HOME_CARE,
    "Package": Catagory.PACKAGE,
    "Self Care": Catagory.SELF_CARE
});

class ItemDescription {
    String itemName;
    int itemCount;

    ItemDescription({
        required this.itemName,
        required this.itemCount,
    });

    factory ItemDescription.fromJson(Map<String, dynamic> json) => ItemDescription(
        itemName: json["item_name"],
        itemCount: json["item_count"],
    );

    Map<String, dynamic> toJson() => {
        "item_name": itemName,
        "item_count": itemCount,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
