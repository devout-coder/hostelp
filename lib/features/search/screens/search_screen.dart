import 'package:flutter/material.dart';
import 'package:hostelp/features/search/utils.dart';
// import 'package:hostelp/features/search/widgets/button.dart';
// import 'package:hostelp/features/search/widgets/filter_checkbox_widget.dart';
// import 'package:hostelp/features/search/widgets/search_filter_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:routemaster/routemaster.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? _currentAddress = '';
  late Position _currentPosition;
  void selectService(int index) {
    for (int i = 0; i < Utils.selectedOptionList.length; i++) {
      if (index == i) {
        Utils.selectedOptionList[i] = true;
      } else {
        Utils.selectedOptionList[i] = false;
      }
    }
  }

  void selectGenderMethod(int? value) {
    setState(() {
      Utils.selectedGender = value;
    });
  }

  Future<Position> _determinePosition() async {
    // bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    // serviceEnabled = await Geolocator.isLocationServiceEnabled();
    // if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    // }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 70,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            // The search area here
            title: SizedBox(
              height: 50,
              child: Material(
                child: SizedBox(
                  height: 100,
                  child: TextField(
                    autofocus: true,
                    textAlignVertical: TextAlignVertical.bottom,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      // fontFamily: 'EuclidCircular',
                      fontWeight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(25),
                      hintText: 'Search here',
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: Color(0xff645CBB),
                          width: 2.5,
                        ),
                      ),
                      prefixIcon: IconButton(
                        onPressed: () {
                          Routemaster.of(context).pop();
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    children: [
                      // OutlinedButton(
                      //   onPressed: () {},
                      //   child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //       children: [
                      //         Text('Search',
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .labelMedium
                      //                 ?.copyWith(
                      //                     color: Theme.of(context)
                      //                         .colorScheme
                      //                         .primary)),
                      //         const Icon(Icons.search)
                      //       ]),
                      // ),
                      // const SizedBox(height: 10),
                      TextField(
                        textInputAction: TextInputAction.done,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                            hintText: 'Enter location',
                            hintStyle: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.primary,
                                width: 2.0,
                              ),
                            ),
                            suffixIcon: IconButton(
                                onPressed: () {
                                  Routemaster.of(context).push('/hostellist');
                                },
                                icon: Icon(
                                  Icons.location_on_rounded,
                                  color: Theme.of(context).colorScheme.primary,
                                ))),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () async {
                          _currentPosition = await _determinePosition();
                          // print(_currentPosition);
                          await _getAddressFromLatLng(_currentPosition);
                          // print(_currentAddress);
                        },
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Current location',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium
                                      ?.copyWith(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                              const Icon(Icons.location_searching_rounded)
                            ]),
                      ),
                      Text(_currentAddress ?? ''),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  void filterSelectionManager(int index) {
    for (int i = 0; i < Utils.selectedRoomList.length; i++) {
      if (i == index) {
        Utils.selectedRoomList[i]['isFilterSelected'] =
            !Utils.selectedRoomList[i]['isFilterSelected'];
      } else {
        Utils.selectedRoomList[i]['isFilterSelected'] = false;
      }
    }
  }
}
