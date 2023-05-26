import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import '../drawer/e_com_drawer.dart';
import '../utils/k_padding.dart';
import 'package:provider/provider.dart';
import '../../provider/viewmodel/productsVM.dart';
import '../utils/responsive_layout.dart';

class CartPage extends StatefulWidget {
  //final List<Map<String, dynamic>> cartItems;
  int itemslength;

  CartPage({super.key, required this.itemslength});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double _totalPrice = 0.00;
  List<int> items_count = [];
  late ProductsVM value;

  @override
  void initState() {
    super.initState();
    value = Provider.of<ProductsVM>(context, listen: false);
    add_items_to_count();
    calculateTotalPrice();
  }

  // ignore: non_constant_identifier_names
  void add_items_to_count() {
    if (widget.itemslength != 0) {
      for (int i = 0; i < widget.itemslength; i++) {
        items_count.add(1);
      }
    }
  }

  void calculateTotalPrice() {
    double totalPrice = 0.0;
    for (int i = 0; i < items_count.length; i++) {
      double price = double.parse(value.lst[i].price);
      totalPrice += items_count[i] * price;
    }
    setState(() {
      _totalPrice = totalPrice;
    });
  }

  void incrementItemCount(int index) {
    setState(() {
      items_count[index]++;
      calculateTotalPrice();
    });
  }

  void decrementItemCount(int index) {
    if (items_count[index] > 1) {
      setState(() {
        items_count[index]--;
        calculateTotalPrice();
      });
    }
  }

  void removeItem(int index) {
    setState(() {
      value.lst.removeAt(index);
      items_count.removeAt(index);
      calculateTotalPrice();
    });
  }

  void _clearCart(ProductsVM value) {
    setState(() {
      value.lst.clear();
      items_count.clear();
      calculateTotalPrice();
    });
  }
  // int _getTotalItemCount() {
  //   int totalItemCount = 0;
  //   for (int i = 0; i < items_count.length; i++) {
  //     totalItemCount += items_count[i];
  //   }

  //   return totalItemCount;
  // }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Consumer<ProductsVM>(
        builder: (context, value, child) => Scaffold(
              backgroundColor: Theme.of(context).secondaryHeaderColor,
              appBar: AppBar(
                iconTheme: IconThemeData(
                  color:
                      Theme.of(context).primaryColor, //change your color here
                ),
                centerTitle: true,
                backgroundColor: Theme.of(context).secondaryHeaderColor,
                actions: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: IconButton(
                      tooltip: "Clear Cart",
                      icon: const Icon(
                        Icons.clear_all,
                      ),
                      onPressed: () {
                        _clearCart(value);
                        final snackBar = SnackBar(
                          /// need to set following properties for best effect of awesome_snackbar_content
                          elevation: 0,
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.transparent,
                          content: AwesomeSnackbarContent(
                            title: 'Cart Cleared',
                            message: 'Cart cleared Successfully',

                            /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                            contentType: ContentType.warning,
                          ),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(snackBar);
                      },
                    ),
                  )
                ],
                title: Text(
                  'Your Cart',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF283C63)),
                ),
              ),
              body: value.lst.isEmpty
                  ? const Center(
                      child: Text('Your cart is empty'),
                    )
                  : ResponsiveLayout(
                      iphone: cartPageFullBody(value, context),
                      ipad: Row(
                        children: [
                          Expanded(
                            flex: _size.width > 1340 ? 2 : 2,
                            child: Container(
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                          Expanded(
                              flex: _size.width > 1340 ? 6 : 6,
                              child: cartPageFullBody(value, context)),
                          Expanded(
                            flex: _size.width > 1340 ? 2 : 2,
                            child: Container(
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ],
                      ),
                      macbook: Row(
                        children: [
                          Expanded(
                            flex: _size.width > 1340 ? 4 : 4,
                            child: Container(
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                          Expanded(
                              flex: _size.width > 1340 ? 6 : 6,
                              child: cartPageFullBody(value, context)),
                          Expanded(
                            flex: _size.width > 1340 ? 4 : 4,
                            child: Container(
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                          ),
                        ],
                      ),
                    ),

              // ResponsiveLayout.isMacbook(context) || ResponsiveLayout.isIpad(context)
              //     ? Row(
              //         children: [
              //           Expanded(
              //             flex: _size.width > 1340 ? 4 : 4,
              //             child: Container(color: Theme.of(context).secondaryHeaderColor,),
              //           ),
              //           Expanded(
              //               flex: _size.width > 1340 ? 5 : 5,
              //               child: cartPageFullBody(value, context)),
              //           Expanded(
              //             flex: _size.width > 1340 ? 4 : 4,
              //             child: Container(color: Theme.of(context).secondaryHeaderColor,),
              //           ),
              //         ],
              //       )
              //     : cartPageFullBody(value, context)));
            ));
  }

  Padding cartPageFullBody(ProductsVM value, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: kPadding / 2, left: kPadding / 2, right: kPadding / 2),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: value.lst.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 10,
                  child: Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      removeItem(index);
                    },
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerRight,
                      child: const Padding(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ListTile(
                        leading: Image.network(
                          value.lst[index].image,
                        ),
                        title: Center(
                            child: Text(
                          value.lst[index].name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        )),
                        subtitle: Center(
                          child: Text(
                            '${value.lst[index].price} Birr',
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove_circle_outline,
                                  color: Theme.of(context).primaryColor),
                              onPressed: () {
                                decrementItemCount(index);
                              },
                            ),
                            Text('${items_count[index]}'),
                            IconButton(
                              icon: Icon(
                                Icons.add_circle_outline,
                                color: Theme.of(context).primaryColor,
                              ),
                              onPressed: () {
                                incrementItemCount(index);
                              },
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete_forever,
                                  color: Colors.red),
                              onPressed: () {
                                final snackBar = SnackBar(
                                  /// need to set following properties for best effect of awesome_snackbar_content
                                  elevation: 0,
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.transparent,
                                  content: AwesomeSnackbarContent(
                                    title: 'Product Removed',
                                    message:
                                        '${value.lst[index].name} has been removed from cart',

                                    /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                                    contentType: ContentType.failure,
                                  ),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(snackBar);

                                removeItem(index);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 2, color: Colors.white),
          Container(
            margin: const EdgeInsets.all(kPadding / 2),
            padding: const EdgeInsets.all(kPadding / 2),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                    Text(
                      '$_totalPrice Birr',
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Delivery:',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      Text(
                        'Next Page',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            height: 2,
            color: Colors.white,
          ),
          const SizedBox(height: 20.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.only(bottom: 30.0),
            child: ElevatedButton(
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
                "Proceed to Checkout",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
