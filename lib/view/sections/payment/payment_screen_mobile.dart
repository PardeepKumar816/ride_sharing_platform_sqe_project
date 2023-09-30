

import 'package:flutter/material.dart';

class PaymentScreenMobile extends StatefulWidget {
   PaymentScreenMobile({Key? key,this.payment}) : super(key: key);

  final double? payment;
 final List<String> banks = ["HBL","EasyPaisa","JazzCash","Allied Bank","UBL","NayaPay","SadaPay"];

  @override
  State<PaymentScreenMobile> createState() => _PaymentScreenMobileState();
}

class _PaymentScreenMobileState extends State<PaymentScreenMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Payment"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Amount : ${widget.payment}",style: const TextStyle(color: Colors.white),),
         const Text("Select Bank",style: TextStyle(color: Colors.white),),
          DropdownButton(
            value: widget.banks[0],
              items: widget.banks.map((e) {
                return  DropdownMenuItem(
                  value: e,
                  child: Row(
                    children: [ Text(e)],
                  ),
                );
              }).toList(), onChanged: (value){}
          ),
        ],
      ),
    );
  }
}
