
import 'package:flutter/material.dart';
import 'package:ride_sharing_platform/model/data/dummy_data.dart';
import 'package:ride_sharing_platform/view/sections/carpooling/carpooling_screen_mobile.dart';

import '../carpooling/carpooling_screen_web.dart';

class RideBookingWeb extends StatefulWidget {
  const RideBookingWeb({Key? key}) : super(key: key);

  @override
  State<RideBookingWeb> createState() => _RideBookingWebState();
}

class _RideBookingWebState extends State<RideBookingWeb> {

  final _controller = TextEditingController();
  List<dynamic> rides = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Center(
              child: Container(
                padding:const EdgeInsets.only(left: 16,right: 10),
                width: MediaQuery.of(context).size.width*0.3,
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
                padding: const EdgeInsets.symmetric(vertical: 32,horizontal: 200),
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
                                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> CarpoolingScreenWeb(location: _controller.text.toLowerCase(),fare: rides[index]["fare"],)));
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
                             // const SizedBox(height: 1,),
                              Text("Rider name: ${rides[index]["rider_name"]}"),
                             // const SizedBox(height: 1,),
                              Text("Vehicle type: ${rides[index]["vehicle_type"]}")
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
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
