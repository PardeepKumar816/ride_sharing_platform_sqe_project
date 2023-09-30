
import 'package:flutter/material.dart';
import 'package:ride_sharing_platform/model/data/dummy_data.dart';
import 'package:ride_sharing_platform/view/sections/payment/payment_screen_mobile.dart';

class CarpoolingScreenMobile extends StatelessWidget {
  const CarpoolingScreenMobile({Key? key,required this.location,required this.fare}) : super(key: key);

  final String location;
  final String fare;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Choose Ride Sharing Partner"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
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
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PaymentScreenMobile(payment:payment,)));
                      }, child: const Text("Share Ride")),
                    ),
                  );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: ElevatedButton(onPressed: (){
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PaymentScreenMobile(payment: double.parse(fare),)));
            }, child: const Text("Skip")),
          ),
        ],
      ),
    );
  }
}
