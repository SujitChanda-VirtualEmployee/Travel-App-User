import 'package:flutter/material.dart';
import 'package:travel_app_user/utils/color_palette.dart';
import 'package:travel_app_user/utils/custom_styles.dart';
import 'package:travel_app_user/utils/size_config.dart';
import 'package:travel_app_user/widgets/custom_buttons.dart';
import 'package:travel_app_user/widgets/vehicle_list_tile.dart';

class RiderConfirmSheetContent extends StatefulWidget {
  const RiderConfirmSheetContent({Key? key}) : super(key: key);

  @override
  State<RiderConfirmSheetContent> createState() => _RiderConfirmSheetContentState();
}

class _RiderConfirmSheetContentState extends State<RiderConfirmSheetContent> {
  List<String> distanceList = ['Near by you', '2.5 km', '2.5 km', '2.2 km'];
  List<String> timeRequiredList = ["2 mins", '12 mins', '10 mins', "7 mins"];

  List<double> priceList = [25.00, 10.00, 10.00, 25.00];

  List<String> rideNameList = ["FR Go", 'Auto', 'Bike', "FR Go"];

  List<String> rideImageList = [
    'images/car_ic.png',
    'images/auto_ic.png',
    'images/bike_ic.png',
    'images/car_ic.png'
  ];
  List<bool> itemSelectedList = [true, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.fullHeight / 1.5,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
          color: ColorPalette.white),
      child: Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                "Choose a trip or swipe up for more",
                style: CustomStyleClass.onboardingBoyTextStyle.copyWith(
                  fontSize: SizeConfig.textMultiplier * 1.8,
                  color: ColorPalette.black,
                ),
              ),
            ),
            const Divider(
              thickness: 1,
              height: 30,
            ),
            ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return VehicleListTile(
                    title: rideNameList[index],
                    distance: distanceList[index],
                    price: priceList[index],
                    timeRequired: timeRequiredList[index],
                    image: rideImageList[index],
                    selected: itemSelectedList[index],
                    onTap: () {
                      for (int i = 0; i < rideNameList.length; i++) {
                        itemSelectedList[i] = false;
                      }
                      itemSelectedList[index] = true;
                      setState(() {});
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 1,
                    height: 2,
                  );
                },
                itemCount: rideImageList.length),
            const Expanded(
                child: SizedBox(
              height: 10,
            )),
            CustomButtonsClass.blackButton(
              height: 72,
              onPressed: () {
                Navigator.of(context).pop(true);
                // _showRiderConfirmSheetContent(pickupAddress);
              },
              title: 'CONFIRM YOUR RIDE',
              titleStyle: CustomStyleClass.onboardingSkipButtonStyle,
            ),
          ],
        ),
      ),
    );
  }
}
