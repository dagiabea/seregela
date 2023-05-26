import 'package:flutter/material.dart';
import '../../utils/responsive.dart';
import 'otp.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({Key? key}) : super(key: key);

  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).secondaryHeaderColor,
        body: ResponsiveLayout(
            iphone: mainBody(context),
            ipad: Row(
              children: [
                Expanded(
                  flex: _size.width > 1340 ? 2 : 2,
                  child: Container(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
                Expanded(
                    flex: _size.width > 1340 ? 8 : 8, child: mainBody(context)),
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
                  flex: _size.width > 1340 ? 3 : 3,
                  child: Container(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
                Expanded(
                    flex: _size.width > 1340 ? 7 : 7, child: mainBody(context)),
                Expanded(
                  flex: _size.width > 1340 ? 3 : 3,
                  child: Container(
                    color: Theme.of(context).secondaryHeaderColor,
                  ),
                ),
              ],
            )));
  }

  SingleChildScrollView mainBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                // Align(
                //   alignment: Alignment.topLeft,
                //   child: GestureDetector(
                //     onTap: () => Navigator.pop(context),
                //     child: Icon(
                //       Icons.arrow_back,
                //       size: 32,
                //       color: Colors.black54,
                //     ),
                //   ),
                // ),
                const SizedBox(
                  height: 18,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/images/illustration-2.png',
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const Text(
                  'Registration',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Add your phone number. we'll send you a verification code so we know you're real",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 28,
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.number,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10)),
                            prefix: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                '(+251)',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            suffixIcon: const Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 32,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => const OtpVerify()),
                              );
                            },
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Theme.of(context).primaryColor),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: Text(
                                'Send',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
