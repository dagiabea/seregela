// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:seregela_gebeya/responsive_layout.dart';
// import 'eCommerce/e_com_drawer.dart';
// import 'eCommerce/e_com_item_description.dart';
// import 'from_api/call_items.dart';
// import 'models/Api_Request.dart';
// import 'models/items_model.dart';

// class WidgetTree extends StatefulWidget {
//   const WidgetTree({super.key});

//   @override
//   State<WidgetTree> createState() => _WidgetTreeState();
// }

// class _WidgetTreeState extends State<WidgetTree> {
//   late List<Items>? _ItemsModel = [];

//   @override
//   void initState() {
//     _getData();
//     super.initState();
//     //_makePutRequest();
//   }

//   void _getData() async {
//     _ItemsModel = (await ApiService().getOrders())!;
//     Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
//   }

//   int selectedIndex = 0;
//   bool justopend = true;
//   @override
//   Widget build(BuildContext context) {
//     Size _size = MediaQuery.of(context).size;
//     return _ItemsModel == null || _ItemsModel!.isEmpty
//           ? SpinKitFadingCircle(color: Theme.of(context).primaryColor)
//           : Scaffold(
//       body: ResponsiveLayout(
//         iphone: MediaQuery.of(context).size.width > 600 && MediaQuery.of(context).size.width < 800
//             ? ECommerceCallItems()
//             : ECommerceCallItems(),
//         ipad: Row(
//               children: [
//                 Expanded(
//                   flex: 6,
//                   child:ECommerceCallItems(),
//                 ),
                
//                 Expanded(
//                   flex: 4,
//                   child: ECommerceItemDescription(
//                     descriptions: ["oil","bb","cc"],
//                     descriptionCount: [2,3,4],
//                     itemName: _ItemsModel![0].itemName.toString(),
//                     itemPrice: _ItemsModel![0].price.toString(),
//                     itemImage: _ItemsModel![0].imageUrl.toString(), 
                    
//                   ),
//                 ),
//               ],
//             ),
          
//         macbook: Row(
//           children: [
//             Expanded(
//               flex: _size.width > 1340 ? 6 : 6,
//               child:ECommerceCallItems(),
//             ),
//             Expanded(
//               flex: _size.width > 1340 ? 4 : 4,
//               child: ECommerceItemDescription(
//                 descriptions: ["oil","bb","cc"],
//                 itemName: 'Example Item',
//                 itemPrice: '\$ 20.99 Birr',
//                 itemImage: 'https://firebasestorage.googleapis.com/v0/b/seregela-gebeya.appspot.com/o/seregela%20item%20images%2Fhabesha.jpg?alt=media&token=12434bc0-2b0c-4249-b7a8-2d84280dd7c1',
//               ),
//             ),Expanded(
//               flex: _size.width > 1340 ? 3 : 3,
//               child: ECommerceDrawer(),
//             ),
//           ],
//         ),
//       ), 
//     );
//   }
// }
