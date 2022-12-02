import 'package:be_universe/src/base/assets.dart';
import 'package:be_universe/src/widgets/app_button_widget.dart';
import 'package:be_universe/src/widgets/app_text_field.dart';
import 'package:be_universe/src/widgets/background_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({Key? key}) : super(key: key);

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final _cardNumberController = TextEditingController();
  final _expiryController = TextEditingController();
  final _cvvController = TextEditingController();
  final _nameController = TextEditingController();
  final _hintStyle = GoogleFonts.poppins(
    fontWeight: FontWeight.w700,
    color: const Color(0xFF747688),
  );

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            left: 30,
            right: 30,
            top: padding.top + 56,
          ),
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 30),
                    child: Text(
                      'Payment Method',
                      style: TextStyle(fontSize: 33, color: Colors.white),
                    ),
                  ),
                  _getTitleText(title: 'Card number'),
                  AppTextField(
                    textEditingController: _cardNumberController,
                    hintStyle: _hintStyle,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 14,
                    ),
                    keyboardType: TextInputType.number,
                    maxLength: 16,
                    hint: '****     ****     ****     1234',
                    suffix: Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Image.asset(
                        AppAssets.visaIcon,
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Row(children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _getTitleText(title: 'Expiry date'),
                          AppTextField(
                            contentPadding: _contentPadding,
                            hint: '11/24',
                            keyboardType: TextInputType.number,
                            hintStyle: _hintStyle,
                            textEditingController: _expiryController,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _getTitleText(title: 'CVV'),
                          AppTextField(
                            contentPadding: _contentPadding,
                            maxLength: 3,
                            keyboardType: TextInputType.number,
                            hint: '***',
                            hintStyle: _hintStyle,
                            textEditingController: _cvvController,
                          ),
                        ],
                      ),
                    ),
                  ]),
                  _getTitleText(title: 'Name on card'),
                  AppTextField(
                    contentPadding: _contentPadding,
                    hint: 'Laurie Powell',
                    hintStyle: _hintStyle,
                    textEditingController: _nameController,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppAssets.stripeIcon,
                        width: 60,
                        height: 32,
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Text(
                          'BeUniverse will never store your card details. Payment infrastructure is provided by Stripe',
                          style: GoogleFonts.alata(
                            color: const Color(0xFF9EABB7),
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  AppButtonWidget(
                    title: 'UPDATE CARD',
                    onPressed: () async {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
    Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
      body: BackgroundImageWidget(
        child: Padding(
          padding: EdgeInsets.only(
            left: 34,
            right: 34,
            top: padding.top + 56,
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 74),
                  child: Text(
                    'Payment Method',
                    style: TextStyle(fontSize: 33, color: Colors.white),
                  ),
                ),
                _getTitleText(title: 'Card number'),
                AppTextField(
                  textEditingController: _cardNumberController,
                  hintStyle: _hintStyle,
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 14,
                  ),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(18.59, 18.59),
                      blurRadius: 37.17,
                      spreadRadius: 0,
                      color: const Color(0xFFD3D1D8).withOpacity(0.25),
                    ),
                  ],
                  keyboardType: TextInputType.number,
                  hint: '****     ****     ****     1234',
                  suffix: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Image.asset(
                      AppAssets.visaIcon,
                      height: 50,
                      width: 50,
                    ),
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getTitleText(title: 'Expiry date'),
                        AppTextField(
                          contentPadding: EdgeInsets.zero,
                          hint: '11/24',
                          keyboardType: TextInputType.number,
                          hintStyle: _hintStyle,
                          textEditingController: _expiryController,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _getTitleText(title: 'CVV'),
                        AppTextField(
                          keyboardType: TextInputType.number,
                          hint: '***',
                          hintStyle: _hintStyle,
                          textEditingController: _cvvController,
                        ),
                      ],
                    ),
                  ),
                ]),
                _getTitleText(title: 'Name on card'),
                AppTextField(
                  hint: 'Laurie Powell',
                  hintStyle: _hintStyle,
                  textEditingController: _nameController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(AppAssets.stripeIcon),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Text(
                          'BeUniverse will never store your card details. Payment infrastructure is provided by Stripe',
                          style: GoogleFonts.alata(
                            color: const Color(0xFF9EABB7),
                            fontSize: 11,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                AppButtonWidget(
                  title: 'UPDATE CARD',
                  onPressed: () async {},
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final _contentPadding = const EdgeInsets.symmetric(
    vertical: 16,
    horizontal: 14,
  );

  Widget _getTitleText({required String title}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 15, color: Colors.white),
      ),
    );
  }
}
