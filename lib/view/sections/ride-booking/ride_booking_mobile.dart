
import 'package:flutter/material.dart';
import 'package:ride_sharing_platform/model/data/dummy_data.dart';
import 'package:ride_sharing_platform/view/sections/carpooling/carpooling_screen_mobile.dart';

class RideBookingMobile extends StatefulWidget {
  const RideBookingMobile({Key? key}) : super(key: key);

  @override
  State<RideBookingMobile> createState() => _RideBookingMobileState();
}

class _RideBookingMobileState extends State<RideBookingMobile> {

  final _controller = TextEditingController();
  List<dynamic> rides = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.2),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Ride Booking"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Center(
              child: Container(
                padding:const EdgeInsets.only(left: 16,right: 10),
                width: MediaQuery.of(context).size.width*0.8,
                height: 48,
                decoration:const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(24))
                ),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: "Input Location Ex: Karachi",
                    border: InputBorder.none
                  ),
                ),
              ),
            ),
          ),
          if(rides.isNotEmpty)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
                child: ListView.builder(
                  itemCount: rides.length,
                    itemBuilder: (context,index){
                    return Card(
                      child: ListTile(
                        title: Text("Location: ${rides[index]["end_location"]}"),
                        subtitle: Text("From: ${rides[index]["start_location"]}"),
                        leading: ElevatedButton(
                          onPressed: (){
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: const Text("Fare"),
                              content: Text(rides[index]["fare"]),
                              actions: [
                                ElevatedButton(onPressed: (){
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CarpoolingScreenMobile(location: _controller.text.toLowerCase(),fare: rides[index]["fare"],)));
                                }, child: const  Text("Book")),
                                ElevatedButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: const Text("Decline"))
                              ],
                            );
                          });
                        },child: const Text("Book"),),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Vehicle id: ${rides[index]["vehicle_id"]}"),
                            const SizedBox(height: 4,),
                            Text("Rider name: ${rides[index]["rider_name"]}"),
                            const SizedBox(height: 4,),
                            Text("Vehicle type: ${rides[index]["vehicle_type"]}")
                          ],
                        ),
                      ),
                    );
                    }),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ElevatedButton(onPressed: (){
              DummyData.rides.forEach((key, value) {
                if(key==_controller.text.toLowerCase()){
                  rides.addAll(value);
                }else if(!DummyData.rides.containsKey(_controller.text.toLowerCase())){
                  rides = [];
                }
              });
              setState(() {

              });
            }, child: const Text("Search")),
          ),
        ],
      ),
    );
  }
}
