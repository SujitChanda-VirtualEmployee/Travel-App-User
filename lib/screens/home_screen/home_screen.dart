import 'dart:async';
import 'dart:developer';
import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:travel_app_user/providers/location_provider.dart';
import 'package:travel_app_user/screens/home_screen/components/all_sheets.dart';
import 'package:travel_app_user/screens/home_screen/components/confirm_pickup_sheet_content.dart';
import 'package:travel_app_user/screens/home_screen/components/rider_details_sheet_content.dart';
import 'package:travel_app_user/utils/color_palette.dart';
import 'package:travel_app_user/utils/custom_styles.dart';
import 'package:travel_app_user/utils/size_config.dart';
import 'package:travel_app_user/widgets/custom_buttons.dart';
import 'package:travel_app_user/widgets/confirm_dialog.dart';
import 'package:travel_app_user/widgets/custom_textFields.dart';
import 'package:travel_app_user/widgets/navigationWidget/navigation_bar.dart';
import 'package:travel_app_user/widgets/vehicle_list_tile.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController anim_controller;
  GoogleMapController? _mapController;
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markersSet = Set<Marker>();
  double containerHeight = 400;
  Set<Polyline> polylineSet = Set<Polyline>();
  List<LatLng> polylineCorOrdinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  BitmapDescriptor? animatingMarkerIcon;
  String? status = "";
  String durationRide = "";
  bool isRequestingDirection = false;
  LatLng currentLocation = const LatLng(37.421632, 122.084664);
  late Timer timer;
  double currentLat = 0, currentLng = 0;
  bool semaphore = false;
  bool _locating = false;
  int durationCounter = 0;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  String customerToken = "";
  double riderDetailsSheetHeight = 0;
  PanelController _pc = PanelController();
  bool floatingButtonVisble = true;

  DraggableScrollableController dragController =
      DraggableScrollableController();
  final minChildSize = 0.2;

  void animatedHide() {
    dragController.animateTo(
      minChildSize,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOutBack,
    );
  }

  CameraPosition kLake = const CameraPosition(
      // bearing: 192.8334901395799,
      tilt: 20,
      target: LatLng(22.609464, 88.427546),
      zoom: 14);

  Future<BitmapDescriptor> bitmapDescriptorFromSvgAsset(
      BuildContext context, String assetName, double size) async {
    String svgString =
        await DefaultAssetBundle.of(context).loadString(assetName);

    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, "");

    // ignore: use_build_context_synchronously
    MediaQueryData queryData = MediaQuery.of(context);
    double devicePixelRatio = queryData.devicePixelRatio;
    double width = size * devicePixelRatio;
    double height = size * devicePixelRatio;

    ui.Picture picture = svgDrawableRoot.toPicture(size: Size(width, height));

    ui.Image image = await picture.toImage(width.toInt(), height.toInt());
    ByteData bytes = await (image.toByteData(format: ui.ImageByteFormat.png)
        as FutureOr<ByteData>);
    return BitmapDescriptor.fromBytes(bytes.buffer.asUint8List());
  }

  @override
  void initState() {
    anim_controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    dragController = DraggableScrollableController();
    super.initState();
  }

  @override
  void dispose() {
    anim_controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final locationData = Provider.of<LocationProvider>(context);

    setState(() {
      currentLocation = LatLng(Provider.of<LocationProvider>(context).latitude,
          Provider.of<LocationProvider>(context).longitude);
    });

    Future<void> _goToTheLake() async {
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: currentLocation,
        zoom: 18,
      )));
    }

    void onCreated(GoogleMapController controller) {
      _controller.complete(controller);
      _mapController = controller;
      _goToTheLake();
    }



    return Consumer<LocationProvider>(builder: (context, locationData, child) {
      return Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: const CustomNavigationBar(),
        floatingActionButton: floatingButtonVisble
            ? Container(
                padding: EdgeInsets.only(
                    bottom: locationData.pickupLoc.text.isNotEmpty &&
                            locationData.dropLoc.text.isNotEmpty
                        ? 220
                        : 150),
                child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    child: RotationTransition(
                      turns:
                          Tween(begin: 0.0, end: 1.0).animate(anim_controller),
                      child: const Icon(Icons.my_location_rounded,
                          color: ColorPalette.black),
                    ),
                    onPressed: () {
                      anim_controller.forward();
                      locationData.getCurrentPosition().then((value) {
                        _mapController!
                            .animateCamera(
                                CameraUpdate.newCameraPosition(CameraPosition(
                          target: LatLng(value.latitude, value.longitude),
                          zoom: 18,
                        )))
                            .then((value) {
                          anim_controller.reset();
                        });
                        setState(() {});
                      });
                    }),
              )
            : null,
        body: SlidingUpPanel(
          backdropEnabled: true,
          // parallaxEnabled: true,
          // parallaxOffset: 0.5,
          controller: _pc,
          onPanelClosed: () {
            floatingButtonVisble = true;
            setState(() {});
          },
          onPanelOpened: () {
            setState(() {
              floatingButtonVisble = false;
            });
          },
          color: Colors.transparent,
          // renderPanelSheet: false,
          minHeight: locationData.pickupLoc.text.isNotEmpty &&
                  locationData.dropLoc.text.isNotEmpty
              ? 220
              : 150,
          maxHeight: SizeConfig.fullHeight - SizeConfig.heightMultiplier * 150,
          panel: Container(
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey.shade300)],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(children: [
                    Image.asset(
                      "images/pich_drop_ic.png",
                      height: 100,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: TextField(
                                  onTap: () => _pc.open(),
                                  onChanged: (val) {
                                    // findPlace(val);
                                    setState(() {});
                                  },
                                  onSubmitted: (val) {
                                    setState(() {});
                                  },
                                  controller: locationData.pickupLoc,
                                  decoration: InputDecoration(
                                    labelText: "Pick Up ",
                                    labelStyle: CustomStyleClass
                                        .onboardingBoyTextStyle
                                        .copyWith(
                                            color: ColorPalette.dark,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2),
                                    border: InputBorder.none,
                                    isDense: true,
                                    suffixIcon: IconButton(
                                      icon: const Icon(
                                        CupertinoIcons.clear_circled_solid,
                                        color: ColorPalette.dark,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        locationData.clearLocation(
                                            locationData.pickupLoc);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                height: 0,
                              ),
                              Expanded(
                                child: TextField(
                                  onTap: () => _pc.open(),
                                  onChanged: (val) {
                                    // findPlace(val);
                                    setState(() {});
                                  },
                                  onSubmitted: (val) {
                                    setState(() {});
                                  },
                                  controller: locationData.dropLoc,
                                  decoration: InputDecoration(
                                    labelText: "Drop Off ",
                                    labelStyle: CustomStyleClass
                                        .onboardingBoyTextStyle
                                        .copyWith(
                                            color: ColorPalette.dark,
                                            fontSize:
                                                SizeConfig.textMultiplier * 2),
                                    border: InputBorder.none,
                                    isDense: true,
                                    suffixIcon: IconButton(
                                      icon: const Icon(
                                        CupertinoIcons.clear_circled_solid,
                                        color: ColorPalette.dark,
                                        size: 20,
                                      ),
                                      onPressed: () {
                                        locationData.clearLocation(
                                            locationData.dropLoc);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    )
                  ]),
                ),
                Visibility(
                  visible: locationData.pickupLoc.text.isNotEmpty &&
                      locationData.dropLoc.text.isNotEmpty,
                  child: CustomButtonsClass.blackButton(
                    height: 71,
                    onPressed: () {
                      setState(() {
                        _pc.close();

                        HomeScreenSheets.showRiderDetailsSheet(context);
                      });
                    },
                    title: 'SEARCH NEAR BY',
                    titleStyle: CustomStyleClass.onboardingSkipButtonStyle,
                  ),
                ),
                const SizedBox(height: 20),
                const Divider(
                  thickness: 15,
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, top: 10, bottom: 10.0),
                  child: Text("Popular Location",
                      style: CustomStyleClass.onboardingBoyTextStyle),
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: ListView(
                    padding: const EdgeInsets.only(top: 10),
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Image.asset("images/droff_ic.png"),
                            const SizedBox(width: 10),
                            Text("University of Washington",
                                style: CustomStyleClass.onboardingBoyTextStyle
                                    .copyWith(color: ColorPalette.black))
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Image.asset("images/droff_ic.png"),
                            const SizedBox(width: 10),
                            Text("Sector 66, Noida, New Delhi",
                                style: CustomStyleClass.onboardingBoyTextStyle
                                    .copyWith(color: ColorPalette.black))
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Image.asset("images/droff_ic.png"),
                            const SizedBox(width: 10),
                            Text("University of Washington",
                                style: CustomStyleClass.onboardingBoyTextStyle
                                    .copyWith(color: ColorPalette.black))
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Image.asset("images/droff_ic.png"),
                            const SizedBox(width: 10),
                            Text("Sector 66, Noida, New Delhi",
                                style: CustomStyleClass.onboardingBoyTextStyle
                                    .copyWith(color: ColorPalette.black))
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),

          body: Stack(
            children: [
              GoogleMap(
                key: widget.key,
                initialCameraPosition: CameraPosition(
                  target: currentLocation,
                  zoom: 18,
                ),
                zoomControlsEnabled: false,
                minMaxZoomPreference: const MinMaxZoomPreference(1.5, 20.8),
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                mapToolbarEnabled: true,
                onCameraMove: (CameraPosition position) {
                  setState(() {
                    _locating = true;
                  });
                  locationData.onCameraMove(position);
                },
                onMapCreated: onCreated,
                onCameraIdle: () {
                  setState(() {
                    _locating = false;
                  });
                  locationData.getMoveCamera();
                },
              ),
              const Positioned.fill(
                child: SpinKitPulse(
                  color: ColorPalette.green,
                  size: 200.0,
                ),
              ),
              Center(
                child: SizedBox(
                  height: 100,
                  //margin: EdgeInsets.only(bottom: 40),
                  child: Image.asset(
                    'images/navigation_ic-1.png',
                  ),
                ),
              ),
              Positioned(
                  top: 0,
                  left: 15,
                  child: SafeArea(
                      child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0.7, 0.7),
                              color: ColorPalette.dark.withOpacity(0.6),
                              blurRadius: 10,
                              spreadRadius: 2),
                        ],
                        color: Colors.white),
                    child: IconButton(
                        onPressed: () => scaffoldKey.currentState!.openDrawer(),
                        icon: const Icon(Icons.menu)),
                  )))
            ],
          ),
        ),
      );
    });
  }
}
