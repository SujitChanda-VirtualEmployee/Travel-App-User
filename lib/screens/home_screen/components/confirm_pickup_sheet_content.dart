import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app_user/utils/color_palette.dart';
import 'package:travel_app_user/utils/custom_styles.dart';
import 'package:travel_app_user/utils/size_config.dart';
import 'package:travel_app_user/widgets/confirm_dialog.dart';
import 'package:travel_app_user/widgets/custom_buttons.dart';

import '../../../providers/location_provider.dart';

class ConfirmPickupSheetContent extends StatefulWidget {
  const ConfirmPickupSheetContent({Key? key}) : super(key: key);

  @override
  State<ConfirmPickupSheetContent> createState() =>
      _ConfirmPickupSheetContentState();
}

class _ConfirmPickupSheetContentState extends State<ConfirmPickupSheetContent> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                "Choose your pickup spot",
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
            SizedBox(
              height: SizeConfig.heightMultiplier * 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Consumer<LocationProvider>(
                      builder: (context, locationData, child) {
                    return Expanded(
                      child: Text(
                        locationData.pickUpLocation.placeName!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: CustomStyleClass.onboardingBoyTextStyle.copyWith(
                            color: ColorPalette.black,
                            fontSize: SizeConfig.textMultiplier * 1.8),
                      ),
                    );
                  }),
                  SizedBox(
                    width: SizeConfig.widthMultiplier * 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorPalette.dark.withOpacity(0.4)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    child: Text(
                      "Search",
                      style: CustomStyleClass.onboardingBoyTextStyle.copyWith(
                          color: ColorPalette.black,
                          fontSize: SizeConfig.textMultiplier * 1.8),
                    ),
                  )
                ],
              ),
            ),
            const Expanded(
              child: SizedBox(height: 1),
            ),
            CustomButtonsClass.blackButton(
              height: 72,
              onPressed: () {
                Navigator.of(context).pop(true);
               
                // Navigator.pop(context);
              },
              title: 'CONFIRM PICKUP',
              titleStyle: CustomStyleClass.onboardingSkipButtonStyle,
            ),
          ],
        ),
      ),
    );
  }
}
