import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Pages/signin/phone_signin.dart';
import '../utils/k_padding.dart';
import '../../provider/viewmodel/productsVM.dart';
import '../utils/responsive.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../Pages/CartPage.dart';
import 'drawer_items.dart';

class ECommerceDrawer extends StatelessWidget {
  ECommerceDrawer({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      padding: EdgeInsets.only(top: kIsWeb ? kPadding : 0),
      color: Theme.of(context).secondaryHeaderColor,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kPadding),
          child: Column(
            children: [
              // Row(
              //   children: [
              //     Image.asset(
              //       "images/sellar.png",
              //       width: 150,
              //     ),
              //     Spacer(),
              //     if (!ResponsiveLayout.isMacbook(context)) CloseButton(),
              //   ],
              // ),
              SizedBox(height: kPadding * 2),
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: 300,
                ),
                child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(
                          vertical: kPadding,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          Colors.white.withOpacity(0.8))),
                  child: Text(
                    "Sign In or Register",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SigninPage(),
                      ),
                    );
                  },
                ),
              ),
              // const SizedBox(height: kPadding),
              // ConstrainedBox(
              //   constraints: const BoxConstraints.tightFor(
              //     width: 300,
              //   ),
              //   child: ElevatedButton(
              //     style: ButtonStyle(
              //         shape: MaterialStateProperty.all(
              //           RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(10),
              //           ),
              //         ),
              //         padding: MaterialStateProperty.all(
              //           const EdgeInsets.symmetric(
              //             vertical: kPadding,
              //           ),
              //         ),
              //         backgroundColor: MaterialStateProperty.all(
              //             Colors.white.withOpacity(0.8))),
              //     child: Text(
              //       "Register",
              //       style: TextStyle(color: Theme.of(context).primaryColor),
              //     ),
              //     onPressed: () {
              //       //   Navigator.push(context,
              //       // MaterialPageRoute(builder: (context) => CartScreen()));
              //     },
              //   ),
              // ),
              SizedBox(height: kPadding * 2),

              DrawerItems(
                number: 0,
                onPressed: () {},
                title: "Your Orders",
                icon: Icons.cloud_circle_outlined,
              ),
              DrawerItems(
                number: 0,
                onPressed: () {},
                title: "Your Account",
                icon: Icons.person_outline_outlined,
              ),

              DrawerItems(
                onPressed: () {},
                title: "Notifications",
                icon: Icons.notifications_active_outlined,
                number: 2,
              ),
              DrawerItems(
                number: 0,
                onPressed: () {},
                title: "Call Center",
                icon: Icons.phone_outlined,
              ),
              DrawerItems(
                number: 0,
                onPressed: () {},
                title: "Contact Us",
                icon: Icons.contact_support_outlined,
              ),
              SizedBox(height: kPadding * 2),
            ],
          ),
        ),
      ),
    );
  }
}
