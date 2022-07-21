import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:travel_app_user/screens/home_screen/components/confirm_pickup_sheet_content.dart';
import 'package:travel_app_user/screens/home_screen/components/ride_confirm_sheet_content.dart';
import 'package:travel_app_user/screens/home_screen/components/rider_details_sheet_content.dart';
import 'package:travel_app_user/widgets/confirm_dialog.dart';

class HomeScreenSheets {
  static showRiderDetailsSheet(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: false,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        builder: (context) {
          return const RiderDetailsSheetContent();
        }).then((val) {
      log("=============================================================");
      if (val != null) {
        if (val == true) {
          showRideConfirmSheet(context);
        }
      }
    });
  }

  static showRideConfirmSheet(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: false,
        context: context,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        builder: (context) {
          return const RiderConfirmSheetContent();
        }).then((val) {
      if (val != null) {
        if (val == true) {
          showConfirmPickupSheet(context);
        }
      } else {
        showRiderDetailsSheet(context);
      }
    });
  }

  static showConfirmPickupSheet(BuildContext context) {
    return showModalBottomSheet(
        isDismissible: false,
        isScrollControlled: true,
        enableDrag: false,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
        ),
        builder: (context) {
          return const ConfirmPickupSheetContent();
        }).then((val) {
      log("=============================================================");
      if (val != null) {
        if (val == true) {
          ConfirmDialog.showCustomDialog(context);
        }
      } else {
        showRideConfirmSheet(context);
      }
    });
  }
}
