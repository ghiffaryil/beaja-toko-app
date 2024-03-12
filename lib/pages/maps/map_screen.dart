import 'package:beaja_toko/common/constants/styles/colors.dart';
import 'package:beaja_toko/common/constants/widgets/show_toast.dart';
import 'package:beaja_toko/repository/maps/cart_check_maps.dart';
import 'package:beaja_toko/repository/user/alamat_user_repository.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:beaja_toko/common/components/elevated_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  final int kembali;

  const MapScreen({super.key, this.kembali = 1});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController mapController;
  final Set<Marker> _markers = {};
  int jumlahKembali = 1;

  String formattedAddress = '';
  bool _mapLoaded = false;
  bool _showButon = false;
  LatLng? _selectedLocation;

  static LatLng _defaultLatLong = const LatLng(0, 0);
  CameraPosition _kInitialPosition =
      CameraPosition(target: _defaultLatLong, zoom: 18.0);

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  @override
  void initState() {
    super.initState();
    print('Kembali ${widget.kembali}x');
    jumlahKembali = widget.kembali;
    _checkAlamatUser();
    _fetchCurrentLocation();
  }

  void _checkAlamatUser() async {
    final getCartCheckMaps = await CheckMapsRepository().getCartCheckMaps();
    if (getCartCheckMaps['load_map'] != 1) {
      showToast(message: 'Loading Maps ... ', length: Toast.LENGTH_LONG);
      setState(() {
        jumlahKembali = 2;
      });
    } else {}
  }

  Future<void> _fetchCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _defaultLatLong = LatLng(position.latitude, position.longitude);
      _kInitialPosition = CameraPosition(target: _defaultLatLong, zoom: 17.0);
    });
    getUserDetail();
  }

  // READ USER
  void getUserDetail() async {
    final getCartCheckMaps = await CheckMapsRepository().getCartCheckMaps();
    final getAlamatUser = await AlamatUserReporitory().getAlamatUser();
    if (getAlamatUser.isEmpty) {
      AlamatUserReporitory().addAlamatUser(
          '',
          _defaultLatLong.latitude.toString(),
          _defaultLatLong.longitude.toString(),
          '',
          '',
          '');

      CheckMapsRepository().addCheckMaps(1, true);

      if (getCartCheckMaps['load_map'] != 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const MapScreen(
            kembali: 2,
          );
        }));
      }
    }
  }

  void _selectLocation(LatLng position) {
    print('_defaultLatLong $_defaultLatLong');

    setState(() {
      _showButon = true;
      _selectedLocation = position;
      _markers.clear(); // Clear previous markers
      _markers.add(
        Marker(
          markerId: const MarkerId("selected-location"),
          position: position,
          infoWindow: InfoWindow(
            title: 'Latitude - Longitude',
            snippet: '${position.latitude} - ${position.longitude}',
          ),
        ),
      );
    });

    if (_mapLoaded = true) {
      _selectPlacemark(position);
    }
  }

  void _selectPlacemark(LatLng position) async {
    placemarkFromCoordinates(position.latitude, position.longitude)
        .then((placemarks) {
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        String noRumah = placemark.name ?? '';
        String jalan = placemark.street ?? '';
        String kelurahan = placemark.subLocality ?? '';
        String kecamatan = placemark.locality ?? '';
        String provinsi = placemark.administrativeArea ?? '';

        String getformattedAddress = '$jalan, $noRumah, $kecamatan, $provinsi';
        AlamatUserReporitory().addAlamatUser(
            getformattedAddress,
            position.latitude.toString(),
            position.longitude.toString(),
            kelurahan,
            kecamatan,
            provinsi);
        setState(() {
          formattedAddress = getformattedAddress;
        });
      }
    });

    final getAlamatUser = AlamatUserReporitory().getAlamatUser();
    print('Alamat User : $getAlamatUser');
  }

  @override
  void dispose() {
    mapController.dispose(); // Dispose of the GoogleMapController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lokasi Pengiriman'),
          leading: IconButton(
              onPressed: () {
                // Pop the navigation stack based on the value of kembali
                for (int i = 0; i < jumlahKembali; i++) {
                  Navigator.of(context).pop(_selectedLocation);
                }
              },
              icon: const Icon(Icons.arrow_back_ios_new)),
          actions: [
            IconButton(
                onPressed: () {
                  _selectLocation(_defaultLatLong);
                  _mapLoaded = true;
                },
                icon: const Icon(
                  Icons.my_location_rounded,
                  color: AppColors.info,
                ))
          ],
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: _kInitialPosition,
              onTap: _selectLocation,
              markers: _markers,
            ),
            if (_mapLoaded && _selectedLocation != null)
              Positioned(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Lokasi Anda: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        formattedAddress,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
        floatingActionButton: _showButon
            ? Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 40),
                child: ButtonFilled.primary(
                  width: 160,
                  height: 50,
                  onPressed: () {
                    if (_selectedLocation != null) {
                      // Pop the navigation stack based on the value of kembali
                      for (int i = 0; i < jumlahKembali; i++) {
                        Navigator.of(context).pop(_selectedLocation);
                      }
                    } else {
                      showToast(message: 'Tidak ada Lokasi yang dipilih.');
                    }
                  },
                  text: 'Pilih Lokasi',
                ),
              )
            : Container(
                alignment: Alignment.bottomCenter,
                width: double.infinity,
                margin: const EdgeInsets.only(left: 40),
                child: ButtonFilled.info(
                  width: 160,
                  height: 50,
                  onPressed: () {
                    _selectLocation(_defaultLatLong);
                    _mapLoaded = true;
                  },
                  text: 'Lokasi Saya',
                  textColor: AppColors.white,
                ),
              ));
  }
}
