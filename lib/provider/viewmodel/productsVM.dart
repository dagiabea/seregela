import 'package:flutter/widgets.dart';
import '../../models/item_model.dart';

class ProductsVM with ChangeNotifier {
  List<Item> lst = List<Item>.empty(growable: true);

  add(String image, String name, String price) {
    lst.add(Item(image: image, name: name, price: price));
    notifyListeners();
  }

  del(int index) {
    lst.removeAt(index);
    notifyListeners();
  }
}
