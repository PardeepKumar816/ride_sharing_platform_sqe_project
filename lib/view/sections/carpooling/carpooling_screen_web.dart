
import 'package:flutter/material.dart';
import 'package:ride_sharing_platform/model/data/dummy_data.dart';
import 'package:ride_sharing_platform/view/sections/payment/payment_screen_mobile.dart';
import 'package:ride_sharing_platform/view/sections/payment/payment_screen_web.dart';

class CarpoolingScreenWeb extends StatelessWidget {
  const CarpoolingScreenWeb({Key? key,required this.location,required this.fare}) : super(key: key);

  final String location;
  final String fare;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 68,horizontal: MediaQuery.of(context).size.width*0.3),
              child: ListView.builder(
                  itemCount: DummyData.carpoolingUsers[location].length,
                  itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        title: Text(DummyData.carpoolingUsers[location][index]['name']),
                        subtitle: Text(DummyData.carpoolingUsers[location][index]['gender']),
                        trailing: Text("Age: ${DummyData.carpoolingUsers[location][index]['Age']}"),
                        leading: ElevatedButton(onPressed: (){
                          double payment = double.parse(fare)/2;
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PaymentScreenWeb(payment:payment,)));
                        }, child: const Text("Share Ride")),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: ElevatedButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PaymentScreenWeb(payment: double.parse(fare),)));
            }, child: const Text("Skip")),
          ),
        ],
      ),
    );
  }
}
