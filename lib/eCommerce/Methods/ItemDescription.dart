import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/item_model.dart';
import '../utils/k_padding.dart';
import '../../provider/viewmodel/productsVM.dart';
import '../../provider/widgets/cartCounter.dart';
import '../utils/responsive.dart';
import '../Pages/CartPage.dart';

Scaffold itemDescription(
    BuildContext context, String itemName, String itemPrice, String itemImage,
    {List<String> descriptions = const [],
    List<int> descriptionCount = const []}) {
  bool add_to_cart(ProductsVM value, Item item) {
    bool itemAlreadyInCart = false;

    // check if item is already in cart
    for (Item cartItem in value.lst) {
      if (cartItem.name == item.name) {
        itemAlreadyInCart = true;
        break;
      }
    }
    // if item is not already in cart, add it
    if (!itemAlreadyInCart) {
      value.add(
          item.image.toString(), item.name.toString(), item.price.toString());
    }
    return itemAlreadyInCart;
  }

  return Scaffold(
    backgroundColor: Theme.of(context).secondaryHeaderColor,
    appBar: ResponsiveLayout.isIphone(context)
        ? AppBar(
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor, //change your color here
            ),
            backgroundColor: Theme.of(context).secondaryHeaderColor,
            title: Text(
              "Sergela Gebeya",
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            centerTitle: true,
            actions: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: Icon(
                        Icons.shopping_cart_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CartPage(
                                itemslength:
                                    Provider.of<ProductsVM>(context).lst.length,
                              ),
                            ));
                      },
                    ),
                  ),
                  Positioned(
                    top: 8,
                    left: 0,
                    right: 0,
                    child: Consumer<ProductsVM>(
                      builder: (context, value, child) => CartCounter(
                        count: value.lst.length.toString(),
                      ),
                    ),
                  )
                ],
              ),
            ],
          )
        : AppBar(
            centerTitle: true,
            backgroundColor: Theme.of(context).secondaryHeaderColor,
          ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Image.network(itemImage,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.5),
          ),
          const SizedBox(height: 20),
          Text(
            itemName,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Text(
            "$itemPrice Birr",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Container(
              padding: const EdgeInsets.only(bottom: 30.0, left: 30, right: 30),
              child: Consumer<ProductsVM>(
                builder: (context, value, child) => ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                          vertical: kPadding,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Theme.of(context).primaryColor)),
                  child: const Text(
                    "Add to Cart",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    //value.add(itemImage, itemName, itemPrice);
                    Item i = Item(
                        name: itemName, image: itemImage, price: itemPrice);

                    if (!add_to_cart(value, i)) {
                      final snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Product Added',
                          message: '$itemName has been added to your Cart',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.success,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    } else {
                      final snackBar = SnackBar(
                        /// need to set following properties for best effect of awesome_snackbar_content
                        elevation: 0,
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.transparent,
                        content: AwesomeSnackbarContent(
                          title: 'Product already in cart',
                          message:
                              '$itemName has already been added to the shopping cart',

                          /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          contentType: ContentType.warning,
                        ),
                      );
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar()
                        ..showSnackBar(snackBar);
                    }
                  },
                ),
              )),
          const SizedBox(height: 20),
          descriptions.isNotEmpty && descriptionCount.isNotEmpty
              ? const Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              : const SizedBox(height: 10),
          if (descriptions.isNotEmpty && descriptionCount.isNotEmpty)
            for (int i = 0; i < descriptions.length; i++)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: Colors.white),
                      padding: const EdgeInsets.symmetric(
                          vertical: 2.0, horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            descriptions[i],
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${descriptionCount[i]}',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
