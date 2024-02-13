// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// //
// // class AddNewCardScreen extends StatefulWidget {
// //   const AddNewCardScreen({Key? key}) : super(key: key);
// //
// //   @override
// //   State<AddNewCardScreen> createState() => _AddNewCardScreenState();
// // }
// //
// // class _AddNewCardScreenState extends State<AddNewCardScreen> {
// //   TextEditingController cardNumberController = TextEditingController();
// //
// //   CardType cardType = CardType.Invalid;
// //   @override
// //   void initState() {
// //     cardNumberController.addListener(
// //           () {
// //         getCardTypeFrmNumber();
// //       },
// //     );
// //     super.initState();
// //   }
// //   @override
// //   void dispose() {
// //     cardNumberController.dispose();
// //     super.dispose();
// //   }
// //   void getCardTypeFrmNumber() {
// //     if (cardNumberController.text.length <= 6) {
// //       String input = CardUtils.getCleanedNumber(cardNumberController.text);
// //       CardType type = CardUtils.getCardTypeFrmNumber(input);
// //       if (type != cardType) {
// //         setState(() {
// //           cardType = type;
// //         });
// //       }
// //     }
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       appBar: AppBar(title: const Text("New card")),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 16),
// //           child: Column(
// //             children: [
// //               const Spacer(),
// //               Form(
// //                 child: Column(
// //                   children: [
// //                     TextFormField(
// //                       controller: cardNumberController,
// //                       keyboardType: TextInputType.number,
// //                       inputFormatters: [
// //                         FilteringTextInputFormatter.digitsOnly,
// //                         LengthLimitingTextInputFormatter(19),
// //                       ],
// //                       decoration: InputDecoration(
// //                           suffix: CardUtils.getCardIcon(cardType),
// //                           hintText: "Card number"),
// //                     ),
// //                     Padding(
// //                       padding: const EdgeInsets.symmetric(vertical: 16),
// //                       child: TextFormField(
// //                         decoration:
// //                         const InputDecoration(hintText: "Full name"),
// //                       ),
// //                     ),
// //                     Row(
// //                       children: [
// //                         Expanded(
// //                           child: TextFormField(
// //
// //                             keyboardType: TextInputType.number,
// //                             inputFormatters: [
// //                               CardNumberInputFormatter(),
// //                               FilteringTextInputFormatter.digitsOnly,
// //                               // Limit the input
// //                               LengthLimitingTextInputFormatter(4),
// //                             ],
// //                             decoration: const InputDecoration(
// //                                 hintText: "CVV"),
// //                           ),
// //                         ),
// //                         const SizedBox(width: 16),
// //                         Expanded(
// //                           child: TextFormField(
// //                             keyboardType: TextInputType.number,
// //                             inputFormatters: [
// //                               CardMonthInputFormatter(),
// //                               FilteringTextInputFormatter.digitsOnly,
// //                               LengthLimitingTextInputFormatter(5),
// //                             ],
// //                             decoration:
// //                             const InputDecoration(hintText: "MM/YY"
// //
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //               const Spacer(flex: 2),
// //               Padding(
// //                 padding: const EdgeInsets.only(top: 16),
// //                 child: ElevatedButton(
// //                   child: const Text("Add card"),
// //                   onPressed: () {},
// //                 ),
// //               ),
// //               const Spacer(),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// // enum CardType {
// //   Master,
// //   Visa,
// //   Verve,
// //   Discover,
// //   AmericanExpress,
// //   DinersClub,
// //   Jcb,
// //   Others,
// //   Invalid
// // }
// //
// //
// // class CardNumberInputFormatter extends TextInputFormatter {
// //   @override
// //   TextEditingValue formatEditUpdate(
// //       TextEditingValue oldValue, TextEditingValue newValue) {
// //     var text = newValue.text;
// //     if (newValue.selection.baseOffset == 0) {
// //       return newValue;
// //     }
// //     var buffer = StringBuffer();
// //     for (int i = 0; i < text.length; i++) {
// //       buffer.write(text[i]);
// //       var nonZeroIndex = i + 1;
// //       if (nonZeroIndex % 4 == 0 && nonZeroIndex != text.length) {
// //         buffer.write('  '); // Add double spaces.
// //       }
// //     }
// //     var string = buffer.toString();
// //     return newValue.copyWith(
// //         text: string,
// //         selection: TextSelection.collapsed(offset: string.length));
// //   }
// // }
// //
// // class CardMonthInputFormatter extends TextInputFormatter {
// //   @override
// //   TextEditingValue formatEditUpdate(
// //       TextEditingValue oldValue, TextEditingValue newValue) {
// //     var newText = newValue.text;
// //     if (newValue.selection.baseOffset == 0) {
// //       return newValue;
// //     }
// //     var buffer = StringBuffer();
// //     for (int i = 0; i < newText.length; i++) {
// //       buffer.write(newText[i]);
// //       var nonZeroIndex = i + 1;
// //       if (nonZeroIndex % 2 == 0 && nonZeroIndex != newText.length) {
// //         buffer.write('/');
// //       }
// //     }
// //     var string = buffer.toString();
// //     return newValue.copyWith(
// //         text: string,
// //         selection: TextSelection.collapsed(offset: string.length));
// //   }
// // }
// // class CardUtils {
// //   static CardType getCardTypeFrmNumber(String input) {
// //     CardType cardType;
// //     if (input.startsWith(RegExp(
// //         r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
// //       cardType = CardType.Master;
// //     } else if (input.startsWith(RegExp(r'[4]'))) {
// //       cardType = CardType.Visa;
// //     } else if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
// //       cardType = CardType.Verve;
// //     } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
// //       cardType = CardType.AmericanExpress;
// //     } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
// //       cardType = CardType.Discover;
// //     } else if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
// //       cardType = CardType.DinersClub;
// //     } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
// //       cardType = CardType.Jcb;
// //     } else if (input.length <= 8) {
// //       cardType = CardType.Others;
// //     } else {
// //       cardType = CardType.Invalid;
// //     }
// //     return cardType;
// //   }
// //   static String getCleanedNumber(String text) {
// //     RegExp regExp = RegExp(r"[^0-9]");
// //     return text.replaceAll(regExp, '');
// //   }
// //   static Widget? getCardIcon(CardType? cardType) {
// //     String img = "";
// //     Icon? icon;
// //     switch (cardType) {
// //       case CardType.Master:
// //         img = 'mastercard.png';
// //         break;
// //       case CardType.Visa:
// //         img = 'visa.png';
// //         break;
// //       case CardType.Verve:
// //         img = 'verve.png';
// //         break;
// //       case CardType.AmericanExpress:
// //         img = 'american_express.png';
// //         break;
// //       case CardType.Discover:
// //         img = 'discover.png';
// //         break;
// //       case CardType.DinersClub:
// //         img = 'dinners_club.png';
// //         break;
// //       case CardType.Jcb:
// //         img = 'jcb.png';
// //         break;
// //       case CardType.Others:
// //         icon = const Icon(
// //           Icons.credit_card,
// //           size: 24.0,
// //           color: Color(0xFFB8B5C3),
// //         );
// //         break;
// //       default:
// //         icon = const Icon(
// //           Icons.warning,
// //           size: 24.0,
// //           color: Color(0xFFB8B5C3),
// //         );
// //         break;
// //     }
// //     Widget? widget;
// //     if (img.isNotEmpty) {
// //       widget = Image.asset(
// //         'assets/images/$img',
// //         width: 40.0,
// //       );
// //     } else {
// //       widget = icon;
// //     }
// //     return widget;
// //   }
// // }
// //
// //
// //
//
//
//
// ///
//
// import 'dart:math' as math;
// import 'package:customer_ecomerce/Config/global_data.dart';
// import 'package:flutter/material.dart';
//
//
//
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   String cardNumber = '';
//   String cardHolderName = '';
//   String expiryDate = '';
//   String cvv = '';
//   bool showBack = false;
//
//   late FocusNode _focusNode;
//   TextEditingController cardNumberCtrl = TextEditingController();
//   TextEditingController expiryFieldCtrl = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _focusNode = FocusNode();
//     _focusNode.addListener(() {
//       setState(() {
//         _focusNode.hasFocus ? showBack = true : showBack = false;
//       });
//     });
//   }
//
//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             SizedBox(
//               height: 40,
//             ),
//             CreditCard(
//               cardNumber: cardNumber,
//               cardExpiry: expiryDate,
//               cardHolderName: cardHolderName,
//               cvv: cvv,
//               bankName: 'Axis Bank',
//               showBackSide: showBack,
//               frontBackground:GlobalData.green,
//               backBackground: GlobalData.green,
//               showShadow: true,
//               // mask: getCardTypeMask(cardType: CardType.americanExpress),
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: 20,
//                   ),
//                   child: TextFormField(
//                     controller: cardNumberCtrl,
//                     decoration: InputDecoration(hintText: 'Card Number'),
//                     maxLength: 16,
//                     onChanged: (value) {
//                       final newCardNumber = value.trim();
//                       var newStr = '';
//                       final step = 4;
//
//                       for (var i = 0; i < newCardNumber.length; i += step) {
//                         newStr += newCardNumber.substring(
//                             i, math.min(i + step, newCardNumber.length));
//                         if (i + step < newCardNumber.length) newStr += ' ';
//                       }
//
//                       setState(() {
//                         cardNumber = newStr;
//                       });
//                     },
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: 20,
//                   ),
//                   child: TextFormField(
//                     controller: expiryFieldCtrl,
//                     decoration: InputDecoration(hintText: 'Card Expiry'),
//                     maxLength: 5,
//                     onChanged: (value) {
//                       var newDateValue = value.trim();
//                       final isPressingBackspace =
//                           expiryDate.length > newDateValue.length;
//                       final containsSlash = newDateValue.contains('/');
//
//                       if (newDateValue.length >= 2 &&
//                           !containsSlash &&
//                           !isPressingBackspace) {
//                         newDateValue = newDateValue.substring(0, 2) +
//                             '/' +
//                             newDateValue.substring(2);
//                       }
//                       setState(() {
//                         expiryFieldCtrl.text = newDateValue;
//                         expiryFieldCtrl.selection = TextSelection.fromPosition(
//                             TextPosition(offset: newDateValue.length));
//                         expiryDate = newDateValue;
//                       });
//                     },
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(
//                     horizontal: 20,
//                   ),
//                   child: TextFormField(
//                     decoration: InputDecoration(hintText: 'Card Holder Name'),
//                     onChanged: (value) {
//                       setState(() {
//                         cardHolderName = value;
//                       });
//                     },
//                   ),
//                 ),
//                 Container(
//                   margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
//                   child: TextFormField(
//                     decoration: InputDecoration(hintText: 'CVV'),
//                     maxLength: 3,
//                     onChanged: (value) {
//                       setState(() {
//                         cvv = value;
//                       });
//                     },
//                     focusNode: _focusNode,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }