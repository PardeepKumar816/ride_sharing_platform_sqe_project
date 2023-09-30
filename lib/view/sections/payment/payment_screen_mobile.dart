

import 'package:flutter/material.dart';
import 'package:ride_sharing_platform/view/sections/ride-booking/ride_booking_mobile.dart';

class PaymentScreenMobile extends StatefulWidget {
   PaymentScreenMobile({Key? key,this.payment}) : super(key: key);

  final double? payment;
 final List<String> banks = ["HBL","EasyPaisa","JazzCash","Allied Bank","UBL","NayaPay","SadaPay"];

  @override
  State<PaymentScreenMobile> createState() => _PaymentScreenMobileState();
}

class _PaymentScreenMobileState extends State<PaymentScreenMobile> {

  String _value = "";
  final _controller1 = TextEditingController();
  final _controller2 = TextEditingController();
  final _controller3 = TextEditingController();
  final _controller4 = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _value =  widget.banks[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Payment"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Amount : ${widget.payment}",style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.white)),
              const SizedBox(height: 32,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Select Bank:",style: TextStyle(color: Colors.white),),
                 const  SizedBox(width: 32,),
                  DropdownButton(
                    dropdownColor: Colors.grey,
                    style: const TextStyle(color: Colors.white),
                    iconDisabledColor: Colors.white,
                    iconEnabledColor: Colors.yellow,
                    value: _value,
                      items: widget.banks.map((e) {
                        return  DropdownMenuItem(
                          value: e,
                          child: Row(
                            children: [ Text(e,style: const  TextStyle(color: Colors.white),)],
                          ),
                        );
                      }).toList(), onChanged: (value){
                      setState(() {
                        _value = value!;
                      });
                  }
                  ),
                ],
              ),
              _value != "EasyPaisa" && _value != "JazzCash" ?
              Padding(
                padding: const EdgeInsets.only(top: 48),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      padding: const EdgeInsets.only(left: 16),
                      decoration: const  BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.white
                      ),
                      child: TextField(
                        controller: _controller2,
                        decoration: const InputDecoration(
                          hintText: "Name on Card",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Container(
                      width: MediaQuery.of(context).size.width*0.8,
                      padding: const EdgeInsets.only(left: 16),
                      decoration: const  BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.white
                      ),
                      child: TextField(
                        controller: _controller1,
                        decoration: const InputDecoration(
                          hintText: "Card Number",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width*0.35,
                          padding: const EdgeInsets.only(left: 16),
                          decoration: const  BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              color: Colors.white
                          ),
                          child: TextField(
                            controller: _controller3,
                            decoration: const InputDecoration(
                              label: Text("Expiry"),
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: "8/25",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16,),
                        Container(
                          width: MediaQuery.of(context).size.width*0.35,
                          padding: const EdgeInsets.only(left: 16),
                          decoration: const  BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              color: Colors.white
                          ),
                          child: TextField(
                            controller: _controller4,
                            decoration: const InputDecoration(
                              label: Text("CVV"),
                              labelStyle: TextStyle(color: Colors.black),
                              hintText: "XXX",
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 64,),
                    ElevatedButton(onPressed: (){
                     if(_controller1.text.isNotEmpty && _controller2.text.isNotEmpty
                          && _controller3.text.isNotEmpty && _controller4.text.isNotEmpty) {
                       buildShowDialog(context);
                     }
                    }, child:const Text("Proceed")),
                  ],
                ),
              ) :
                Padding(
                  padding: const EdgeInsets.only(top: 48),
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.8,
                        padding: const EdgeInsets.only(left: 16),
                        decoration: const  BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          color: Colors.white
                        ),
                        child: TextField(
                          controller: _controller1,
                          decoration: const InputDecoration(
                            hintText: "Enter account number or IBAN",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 64,),
                      ElevatedButton(onPressed: (){
                        if(_controller1.text.isNotEmpty){
                          buildShowDialog(context);
                        }
                      }, child:const Text("Proceed")),
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> buildShowDialog(BuildContext context) {
    return showDialog(context: context, builder: (context){
                    return AlertDialog(
                      title: const Text("Payment Successfull"),
                      content: Text("Amount: ${widget.payment} from account ${_controller1.text}"),
                      actions: [
                        ElevatedButton(onPressed: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const RideBookingMobile() ));
                        }, child: const  Text("Ok")),
                      ],
                    );
                  });
  }



}
