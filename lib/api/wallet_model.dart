// ignore: camel_case_types
class wallet_method_model {
  int? status;
  String? message;
  TotalWallet? totalWallet;
  List<Pmdata>? pmdata;

  wallet_method_model(
      {this.status, this.message, this.totalWallet, this.pmdata});

  wallet_method_model.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalWallet = json['total_wallet'] != null
        ? TotalWallet.fromJson(json['total_wallet'])
        : null;
    if (json['pmdata'] != null) {
      pmdata = <Pmdata>[];
      json['pmdata'].forEach((v) {
        pmdata!.add(Pmdata.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (totalWallet != null) {
      data['total_wallet'] = totalWallet!.toJson();
    }
    if (pmdata != null) {
      data['pmdata'] = pmdata!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TotalWallet {
  String? wallet;

  TotalWallet({this.wallet});

  TotalWallet.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet'] = wallet;
    return data;
  }
}

class Pmdata {
  int? id;
  String? paymentName;
  String? environment;
  String? testPublicKey;
  String? testSecretKey;
  String? livePublicKey;
  String? liveSecretKey;
  String? encryptionKey;
  String? isAvailable;
  String? createdAt;
  String? updatedAt;

  Pmdata(
      {this.id,
        this.paymentName,
        this.environment,
        this.testPublicKey,
        this.testSecretKey,
        this.livePublicKey,
        this.liveSecretKey,
        this.encryptionKey,
        this.isAvailable,
        this.createdAt,
        this.updatedAt,
      });

  Pmdata.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    paymentName = json['paymentname'];
    environment = json['environment'];
    testPublicKey = json['test_public_key'];
    testSecretKey = json['test_secret_key'];
    livePublicKey = json['live_public_key'];
    liveSecretKey = json['live_secret_key'];
    encryptionKey = json['encryption_key'];
    isAvailable = json['is_available'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['paymentname'] = paymentName;
    data['environment'] = environment;
    data['test_public_key'] = testPublicKey;
    data['test_secret_key'] = testSecretKey;
    data['live_public_key'] = livePublicKey;
    data['live_secret_key'] = liveSecretKey;
    data['encryption_key'] = encryptionKey;
    data['is_available'] = isAvailable;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}



//
// class checkout extends StatefulWidget {
//   const checkout({Key? key}) : super(key: key);
//
//   @override
//   State<checkout> createState() => _checkoutState();
// }
//
// class _checkoutState extends State<checkout> {
//
//   bool isvisible = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar:AppBar(
//
//       title: Text("Checkout",style: loginstyle,),
//       leading:  IconButton(
//         icon: Icon(Icons.arrow_back),
//         onPressed: () => Navigator.of(context).pop(),
//       ),
//       elevation: 0,
//     ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Container(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     Column(
//                       children: [
//                             Container(
//                               height: MediaQuery.of(context).size.height/0.8,
//                               child: ListView.builder(
//                                 physics: NeverScrollableScrollPhysics(),
//                                 itemCount: 5,
//                                 itemBuilder:(context,index){
//                                   return
//
//                                 Card(
//                                   color: color.white,
//                                   child: Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Container(
//                                                     height: 100,
//                                                     width: 80,
//                                                     alignment: Alignment.topLeft,
//                                                     margin: EdgeInsets.all(5),
//                                                     decoration: BoxDecoration(borderRadius: BorderRadius.only(
//                                                         topLeft: Radius.circular(5),
//                                                         bottomLeft: Radius.circular(5),
//                                                         bottomRight: Radius.circular(5),
//                                                         topRight: Radius.circular(5)
//                                                     ),
//                                                       image: DecorationImage(
//                                                           image: AssetImage(image.placeholder),
//                                                           fit: BoxFit.cover
//                                                       ),
//                                                     ),
//                                                   ), Expanded(
//                                                     child: Column(
//                                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                                       children: [
//                                                         Row(children: [
//                                                           Container(margin: EdgeInsets.only(top: 7, left: 5),
//                                                               child: Text("Roadster Men Khaki Solid Pa...",
//                                                                   style: TextStyle(fontSize: 15,fontFamily: 'semibold',color: color.black))),
//                                                         ],),
//                                                         Row(children: [
//                                                           Container(margin: EdgeInsets.only(top: 7, left: 5),
//                                                             child: Text("Size: M", style: TextStyle(fontSize: 12,
//                                                                 fontFamily: 'regular',
//                                                                 color: Colors.black38)),),
//                                                           Spacer(),
//                                                           Container(margin: EdgeInsets.only(top: 7, left: 5,right: 15),
//                                                             child: Text("Qty: 2*2,500.00\$", style: TextStyle(fontSize: 12,
//                                                                 fontFamily: 'regular',
//                                                                 color: Colors.black38)),),
//                                                         ],),
//                                                         Row(
//                                                           children: [
//                                                             Container(margin: EdgeInsets.only(
//                                                                 left: 5, top: 10, bottom: 10),
//                                                               child: Text("2,400.00\$", style: TextStyle(
//                                                                   fontFamily: 'bold', fontSize: 15,color: color.black)),)
//                                                           ],
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Container(margin: EdgeInsets.only(left: 10, right: 5,top: 7),
//                                                     child: Text("Shipping", style: TextStyle(
//                                                         color: Colors.black26,
//                                                         fontFamily: 'regular',
//                                                         fontSize: 13)),),
//                                                   Container(margin: EdgeInsets.only(left: 5, right: 5,top: 7),
//                                                     child: Text("Tax", style: TextStyle(color: Colors.black26,
//                                                         fontFamily: 'regular',
//                                                         fontSize: 13)),),
//                                                   Container(margin: EdgeInsets.only(left: 5, right: 15,top: 7),
//                                                     child: Text("Total", style: TextStyle(
//                                                         color: Colors.black26,
//                                                         fontFamily: 'regular',
//                                                         fontSize: 13)),),
//                                                 ],
//                                               ),
//                                               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Container(margin: EdgeInsets.only(left: 10, right: 5),
//                                                     child: Text(" 0.00\$",
//                                                         style: TextStyle(fontFamily: 'regular', fontSize: 13,color: color.black)),),
//                                                   Container(margin: EdgeInsets.only(left: 5, right: 5),
//                                                     child: Text("     2.00\$",
//                                                         style: TextStyle(fontFamily: 'regular', fontSize: 13,color: color.black)),),
//                                                   Container(margin: EdgeInsets.only(right: 5),
//                                                     child: Text(" 0.00\$  ",
//                                                         style: TextStyle(fontFamily: 'regular', fontSize: 13,color: color.black)),),
//                                                 ],
//                                               ),
//                                             ],
//                                       ),
//                                 );
//                                 },),
//                             ),
//
//                                       InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             isvisible = true;
//                                           });
//                                         },
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: color.blue,
//                                             // border: Border.all(
//                                             //     color: color.black12,
//                                             //     width: 1.0
//                                             // ),
//                                             borderRadius: BorderRadius.all(
//                                                 Radius.circular(10)
//                                             ),
//                                           ),
//
//                                           height: MediaQuery.of(context).size.height/12,
//                                           width: MediaQuery.of(context).size.width/1,
//                                           margin: EdgeInsets.only(left: 7,right: 7),
//                                           child: Column(
//                                             children: [
//                                               Row(children: [Container(margin: EdgeInsets.only(left: 15,right: 15),alignment: Alignment.center,child: Icon(Icons.ac_unit_outlined,size: 20,color: color.white),),
//
//                                               Expanded(child: Column(
//                                                 children: [
//                                                   Container(alignment: Alignment.center,child: Text("Have a coupon? Click here to enter your code",style: TextStyle(color: color.white,fontFamily: 'regular',fontSize: 15)),),
//                                                 ],
//                                               )),
//                                             ],
//                                           ),
//                                             ]),
//                                         ),
//                                       ),
//                                       Visibility(
//                                           visible: isvisible,
//                                           child: Column(
//                                             children: [
//                                               Container(margin: EdgeInsets.only(top: 15,bottom: 20),child: Text("If You have a coupon code,Plese apply it below",style: TextStyle(fontFamily: 'regular',color: Colors.grey,)),),
//
//                                               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                children: [
//                                                 Container(
//                                                   margin: EdgeInsets.only(left: 10),
//
//
//                                                   width: MediaQuery.of(context).size.width/ 1.6,
//                                                   child: TextField(
//                                                     decoration: InputDecoration(
//                                                       filled: true,
//                                                       //border:OutlineInputBorder(),
//                                                       focusedBorder: OutlineInputBorder(
//                                                         borderSide: BorderSide(color: color.black12),
//                                                         // borderRadius: new BorderRadius.circular(25.7),
//                                                       ),
//                                                       border: OutlineInputBorder(
//                                                           borderSide:  BorderSide(color:color.black12)),
//                                                       hintText: ("Coupon Code"),
//                                                     ),
//                                                     style:noramlfont,
//                                                   ),),
//                                                 Container(
//                                                   margin: EdgeInsets.only(right: 10),
//                                                   height: MediaQuery.of(context).size.height/13.2,
//                                                   width: MediaQuery.of(context).size.width/3.5,
//                                                   child: ElevatedButton(
//                                                       style: ElevatedButton.styleFrom(primary: color.black12),
//                                                       onPressed: () {
//
//
//                                                   }, child: Text("Apply",style:TextStyle(color: color.black,fontFamily: 'semibold'),)),
//                                                 )
//                                               ],
//                                         ),
//                                             ],
//                                           ),
//                                        ),
//                             Container(alignment: Alignment.topLeft,
//                               margin: EdgeInsets.only(left: 10,top: 15),
//                               child: Text("Billing / Shiping address", style: TextStyle(fontFamily: 'semibold',fontSize: 17)),),
//                             Container(
//                               height: MediaQuery.of(context).size.height/4.5,
//                               width: MediaQuery.of(context).size.height/1,
//                               margin: EdgeInsets.only(top: 10,left: 10,right: 10),
//                               decoration: BoxDecoration(
//                                 color: color.black12,
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(10),
//                                   topRight: Radius.circular(10),
//                                   bottomLeft: Radius.circular(10),
//                                   bottomRight: Radius.circular(10),
//                                 ),
//                               ),
//
//                               child: Container(
//                                 alignment: Alignment.center,
//                                 height: MediaQuery.of(context).size.height/11,
//                                 width: MediaQuery.of(context).size.width/2.5,
//                                 child: ElevatedButton(
//                                     style: ElevatedButton.styleFrom(
//                                       primary:color.blue, // background
//                                       // foreground
//                                     ),
//                                     onPressed: () {
//                                   Navigator.push(context, MaterialPageRoute(builder: (context) {
//                                     return myaddress();
//                                   },));
//
//                                 }, child: Text("Select Address",style: buttonfont,)),
//                               )
//                             ),
//
//                             Container(alignment: Alignment.topLeft,
//                               margin: EdgeInsets.only(left: 10,top: 10),
//                               child: Text("Order Info", style: TextStyle(fontFamily: 'semibold',fontSize: 17)),),
//                             Container(margin: EdgeInsets.only(left: 10,right: 10,top: 5),child: Row(children: [Container(child: Text("Subtotal",
//                                 style: TextStyle(color: Colors.grey,fontFamily: 'regular',fontSize: 15)),),
//                               Spacer(),
//                               Container(child: Text("2,400.00\$",
//                                   style: TextStyle(color: Colors.grey,fontFamily: 'regular',fontSize: 15)),)
//                             ]),),
//                             Container(margin: EdgeInsets.only(left: 10,right: 10,top: 5),child: Row(children: [
//                               Container(child: Text("Tax",
//                                 style: TextStyle(color: Colors.grey,fontFamily: 'regular',fontSize: 15)),),
//                               Spacer(),
//                               Container(child: Text("2.00\$",
//                                   style: TextStyle(color: Colors.grey,fontFamily: 'regular',fontSize: 15)),)
//                             ]),),
//                             Container(margin: EdgeInsets.only(left: 10,right: 10,top: 5),child: Row(children: [Container(child: Text("Shipping",
//                                 style: TextStyle(color: Colors.grey,fontFamily: 'regular',fontSize: 15)),),
//                               Spacer(),
//                               Container(child: Text("0.00\$",
//                                   style: TextStyle(color: Colors.grey,fontFamily: 'regular',fontSize: 15)),)
//                             ]),),
//                             Container(margin: EdgeInsets.only(left: 10,right: 10,top: 5),child: Row(children: [Container(child: Text("Discount",
//                                 style: TextStyle(color: Colors.grey,fontFamily: 'regular',fontSize: 15)),),
//                               Spacer(),
//                               Container(child: Text("0.00\$",
//                                   style: TextStyle(color: Colors.grey,fontFamily: 'regular',fontSize: 15)),)
//                             ]),),
//                             Divider(thickness: 1,color: color.black12,),
//                             Row(children: [Container(margin: EdgeInsets.only(left: 10,right: 15,top: 5),child: Text("Grand Total",
//                                 style: TextStyle(fontFamily: 'semibold',fontSize: 17)),),
//                               Spacer(),
//                               Container(margin: EdgeInsets.only(left: 10,right: 10,top: 5),child: Text("2,402.00\$",
//                                   style: TextStyle(fontFamily: 'semibold',fontSize: 17)),)
//                             ]),
//                             Container(alignment: Alignment.topLeft,margin: EdgeInsets.only(top: 10,left: 10),
//                               child: Text("Note", style: TextStyle(fontFamily: 'semibold',fontSize: 17)),),
//                             Container(height: MediaQuery.of(context).size.height/7.5,
//                               width: MediaQuery.of(context).size.height/1,
//                               margin: EdgeInsets.only(top: 10,left: 10,right: 10,bottom: 5),
//                               decoration: BoxDecoration(
//                                 color: color.black12,
//                                 borderRadius: BorderRadius.only(
//                                   topLeft: Radius.circular(10),
//                                   topRight: Radius.circular(10),
//                                   bottomLeft: Radius.circular(10),
//                                   bottomRight: Radius.circular(10),
//                                 ),
//                               ),
//                               child:Container(margin: EdgeInsets.only(left: 10,top: 10),child: Text("Order Note",style: TextStyle(fontFamily: 'regular',fontSize: 15,color: color.black))) ,
//                             ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Container( height: MediaQuery.of(context).size.height/ 13,
//               width: MediaQuery.of(context).size.width/ 1,child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   primary:color.blue, // background
//                   // foreground
//                 ),
//                 onPressed: () {
//                 Navigator.push(context, MaterialPageRoute(builder: (context) {
//                   return addmoney();
//                 },));
//               }, child: Text("Procced to payment",style: buttonfont),)),
//         ],
//       )
//     );
//   }
// }



