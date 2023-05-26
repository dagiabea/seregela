import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'eCommerce/utils/custome_scroll_behavior.dart';
import 'eCommerce/Pages/from_api/call_items.dart';
import 'provider/viewmodel/productsVM.dart';

void main() {
  runApp(
    MyApp(),
    
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsVM(),
        ),
      ], 
    child: MaterialApp(
      scrollBehavior: MyCustomScrollBehavior(),
      debugShowCheckedModeBanner: false,
      title: 'Seregela Gebeya',
      theme: ThemeData(
          primaryColor: const Color(0xFF283C63),
          // ignore: deprecated_member_use
          secondaryHeaderColor: const Color(0xFFE7E9F5),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          iconTheme: IconThemeData(color: Colors.black.withOpacity(0.4))),
      home: const ECommerceCallItems(),
    ),
    );
  }
}
