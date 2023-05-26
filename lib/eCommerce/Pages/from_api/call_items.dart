import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:seregela_gebeya/eCommerce/drawer/e_com_drawer.dart';
import '../../../models/item_model.dart';
import '../../utils/OnHover.dart';
import '../../Methods/ItemDescription.dart';
import '../CartPage.dart';
import '../../categories/categories.dart';
import '../../utils/k_padding.dart';
import '../../../models/Api_Request.dart';
import '../../../models/items_model.dart';
import '../../../provider/viewmodel/productsVM.dart';
import '../../../provider/widgets/cartCounter.dart';
import '../../utils/responsive.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ECommerceCallItems extends StatefulWidget {
  const ECommerceCallItems({
    Key? key,
  }) : super(key: key);

  @override
  _ECommerceCallItemsState createState() => _ECommerceCallItemsState();
}

class _ECommerceCallItemsState extends State<ECommerceCallItems> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // ignore: non_constant_identifier_names
  late List<Items>? _ItemsModel = [];

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

  @override
  void initState() {
    _getData();
    super.initState();
    //_makePutRequest();
  }

  void _getData() async {
    _ItemsModel = (await ApiService().getOrders())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  int selectedIndex = 0;
  bool justopend = true;

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 250),
        child: ECommerceDrawer(),
      ),
      body: _ItemsModel == null || _ItemsModel!.isEmpty
          ? SpinKitFadingCircle(color: Theme.of(context).primaryColor)
          : ResponsiveLayout(
              iphone: MediaQuery.of(context).size.width > 600 &&
                      MediaQuery.of(context).size.width < 800
                  ? callAllItems(context, 3)
                  : callAllItems(context, 2),
              ipad: tablet(context, selectedIndex),
              macbook: desktop(_size, context, selectedIndex),
            ),
    );
  }

  Row desktop(Size _size, BuildContext context, [int? index]) {
    index ??= 0;
    return Row(
      children: [
        Expanded(
          flex: _size.width > 1340 ? 6 : 6,
          child: callAllItems(context, 3),
        ),
        Expanded(
            flex: _size.width > 1340 ? 4 : 4,
            child: itemDescription(
                context,
                _ItemsModel![index].itemName.toString(),
                _ItemsModel![index].price.toString(),
                _ItemsModel![index].imageUrl.toString())),
        Expanded(
          flex: _size.width > 1340 ? 3 : 3,
          child: ECommerceDrawer(),
        ),
      ],
    );
  }

  Row tablet(BuildContext context, [int? index]) {
    index ??= 0;
    return Row(
      children: [
        Expanded(
          flex: 6,
          child: callAllItems(context, 2),
        ),
        Expanded(
          flex: 4,
          child: itemDescription(
              context,
              _ItemsModel![index].itemName.toString(),
              _ItemsModel![index].price.toString(),
              _ItemsModel![index].imageUrl.toString()),
        ),
      ],
    );
  }

  Container callAllItems(BuildContext context, int crossaxiscount) {
    return Container(
      padding: const EdgeInsets.only(top: kIsWeb ? kPadding : 0),
      color: Theme.of(context).secondaryHeaderColor,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                const SizedBox(
                  width: kPadding,
                ),
                Stack(
                  children: [
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Consumer<ProductsVM>(
                          builder: (context, value, child) => IconButton(
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
                                          Provider.of<ProductsVM>(context)
                                              .lst
                                              .length,
                                    ),
                                  )).then((value) => setState(() {}));
                            },
                          ),
                        )),
                    Positioned(
                      top: 0,
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
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: kPadding, vertical: 4),
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Search",
                        fillColor: Colors.white.withOpacity(0.5),
                        filled: true,
                        suffixIcon: const Padding(
                          padding: EdgeInsets.all(kPadding * 0.70),
                          child: Icon(Icons.search),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ),
                if (!ResponsiveLayout.isMacbook(context))
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      _scaffoldKey.currentState!.openEndDrawer();
                    },
                  ),
                const SizedBox(width: kPadding / 2)
              ],
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: kPadding / 2),
                child: Text(
                  "Sergela Gebeya",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF283C63)),
                ),
              ),
            ),
            Categories(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: kPadding),
                child: GridView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: kPadding),
                  itemCount: _ItemsModel!.length,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossaxiscount,
                    mainAxisSpacing: kPadding,
                    crossAxisSpacing: kPadding,
                    childAspectRatio: 0.75,
                  ),
                  itemBuilder: (context, index) => singleItem(
                      context,
                      _ItemsModel![index],
                      ResponsiveLayout.isMacbook(context) ||
                              ResponsiveLayout.isIpad(context)
                          ? true
                          : false,
                      index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector singleItem(
      BuildContext context, Items item, bool selected, int index) {
    //selected = ResponsiveLayout.isIphone(context) ? false : index == 0;
    selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
          justopend = false;
        });
        if (ResponsiveLayout.isIphone(context)) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => itemDescription(
                context,
                item.itemName.toString(),
                item.price.toString(),
                item.imageUrl.toString(),
              ),
            ),
          );
        }
      },
      child: kIsWeb
          ? OnHover(
              builder: (isHovered) {
                final color =
                    isHovered ? Theme.of(context).primaryColor : Colors.white;
                final cartColor =
                    isHovered ? Colors.white : Theme.of(context).primaryColor;
                return productsMethod(
                    selected, index, context, color, item, cartColor);
              },
            )
          : productsMethod(selected, index, context, Colors.white, item,
              Theme.of(context).primaryColor),
    );
  }

  Stack productsMethod(bool selected, int index, BuildContext context,
      Color color, Items item, Color cartColor) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(kPadding),
                height: 180,
                width: 160,
                decoration: BoxDecoration(
                  color: selected
                      ? selectedIndex == index
                          ? Theme.of(context).primaryColor
                          : color
                      : color,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(4, 4),
                      blurRadius: 5,
                      color: Colors.black.withOpacity(0.2),
                    ),
                  ],
                ),
                child: Hero(
                  tag: item.itemId.toString(),
                  child: Image.network(
                    item.imageUrl.toString(),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kPadding / 4),
              child: Center(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  item.itemName.toString(),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Text(
              "${item.price.toString()} Birr",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: kPadding / 2,
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 20,
          child: Consumer<ProductsVM>(
            builder: (context, value, child) => InkWell(
              child: IconButton(
                icon: Icon(Icons.add_shopping_cart, color: cartColor),
                onPressed: () {
                  Item i = Item(
                      name: item.itemName.toString(),
                      image: item.imageUrl.toString(),
                      price: item.price.toString());

                  if (!add_to_cart(value, i)) {
                    final snackBar = SnackBar(
                      /// need to set following properties for best effect of awesome_snackbar_content
                      elevation: 0,
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.transparent,
                      content: AwesomeSnackbarContent(
                        title: 'Product Added',
                        message:
                            '${item.itemName.toString()} has been added to your Cart',

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
                            '${item.itemName.toString()} has already been added to the shopping cart',

                        /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                        contentType: ContentType.warning,
                      ),
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(snackBar);
                  }

                  // Add item to cart
                  // value.add(item.imageUrl.toString(),item.itemName.toString(), item.price.toString());
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
