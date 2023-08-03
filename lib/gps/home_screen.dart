import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';
import 'model/category/category.dart';

class LocationScreen extends StatelessWidget {
  final LocationController locationController = Get.put(LocationController());

   LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CARP Background Location'),
      ),
      body: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: const Text('START'),
                onPressed: locationController.start,
              ),
              ElevatedButton(
                child: const Text('STOP'),
                onPressed: locationController.stop,
              ),
              ElevatedButton(
                child: const Text('CURRENT LOCATION'),
                onPressed: locationController.getCurrentLocation,
               //  onPressed: (){
               //    Category cat = Category(1,'test',10,DateTime.now().toString(),DateTime.now().toString());
               //    locationController.addCategory(cat);
               //  },
              ),
              Divider(),
              Obx(
                    () => Text(
                  "Status: ${locationController.locationStatus.value.toString().split('.').last}",
                ),
              ),
              Divider(),
              Obx(
                    () => locationController.currentLocation.value != null
                    ? Column(
                  children: <Widget>[
                    Text(
                      '${locationController.currentLocation.value!.latitude}, ${locationController.currentLocation.value!.longitude}',
                    ),
                    Text(
                      '@',
                    ),
                    Text(
                      '${DateTime.fromMillisecondsSinceEpoch(locationController.currentLocation.value!.time ~/ 1)}',
                    ),
                  ],
                )
                    : Text("No location yet"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
