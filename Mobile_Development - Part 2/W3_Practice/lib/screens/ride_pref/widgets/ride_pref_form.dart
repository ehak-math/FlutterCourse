import 'package:flutter/material.dart';
 
import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';
 
///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;



  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    departure = widget.initRidePref?.departure;
    departureDate = widget.initRidePref?.departureDate ?? DateTime.now();
    arrival = widget.initRidePref?.arrival;
    requestedSeats = widget.initRidePref?.requestedSeats ?? 1;
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
 

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------
  

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [ 
            // Departure Location Selector
            ListTile(
              leading: const Icon(Icons.radio_button_off_rounded, color: Colors.black54),
              title: Text(departure?.name ?? "Select Departure"),
              trailing: GestureDetector(
                onTap: (){},
                child: const Icon(Icons.swap_vert, color: Colors.blue),
              ),
            ),
      
            // Arrival Location Selector
            const Divider(),
            ListTile(
              leading: const Icon(Icons.radio_button_checked, color: Colors.black54),
              title: Text(arrival?.name ?? "Select Arrival"),
            ),
      
            // Date Picker
            const Divider(),
            ListTile(
              leading: const Icon(Icons.calendar_today, color: Colors.black54),
              title: Text(
                "${departureDate.toLocal()}".split(' ')[0],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              onTap: (){},
            ),
      
            // Seat Selector
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person, color: Colors.black54),
              title: Text("$requestedSeats"),
              trailing: DropdownButton<int>(
                value: requestedSeats,
                items: [1, 2, 3, 4].map((e) => DropdownMenuItem(value: e, child: Text("$e"))).toList(),
                onChanged: (value) => setState(() => requestedSeats = value!),
              ),
            ),
      
            // Search Button
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              onPressed: (){},
              child: const Text("Search"),
            ),
           
        ]),
    );
  }
}
