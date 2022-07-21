import 'package:flutter/material.dart';
import 'package:travel_app_user/screens/update_profile_screen.dart';
import 'package:travel_app_user/utils/color_palette.dart';
import 'package:travel_app_user/utils/custom_styles.dart';
import 'package:travel_app_user/utils/size_config.dart';
import 'package:travel_app_user/widgets/custom_buttons.dart';

class MyProfileScreen extends StatefulWidget {
  static const String id = 'myProfile-screen';
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  Widget body() {
    return SizedBox(
      height: SizeConfig.fullHeight,
      width: SizeConfig.fullWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          logoPicture(
              height: SizeConfig.imageSizeMultiplier * 40,
              width: SizeConfig.imageSizeMultiplier * 40),
          Column(
            children: [
              credentials(title: "Fisrt Name", value: "Jhon"),
              credentials(title: "Last Name", value: "Doe"),
              credentials(title: "Mobile Number", value: "+1 99999 99999"),
              credentials(title: "Email-ID", value: "jhondoe12@gmail.com"),
            ],
          ),
          SizedBox(height: 10),
          CustomButtonsClass.blackButton(
              height: 71,
              title: "UPDATE PROFILE",
              titleStyle: CustomStyleClass.onboardingSkipButtonStyle,
              onPressed: () {
                Navigator.pushNamed(context, UpdateProfileScreen.id);
              }),
          SizedBox(height: 30)
        ],
      ),
    );
  }

  Widget logoPicture({
    required double height,
    required double width,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(color: ColorPalette.dark, spreadRadius: 1, blurRadius: 1.5)
      ], borderRadius: BorderRadius.circular(100), color: ColorPalette.green),
      height: height,
      width: width,
      child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(2),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: ColorPalette.white),
          child: Image.asset(
            "images/intro_one_ic.png",
            fit: BoxFit.contain,
          )),
    );
  }

  Widget credentials({required String title, required String value}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: CustomStyleClass.onboardingBoyTextStyle),
              Text(value,
                  style: CustomStyleClass.onboardingBoyTextStyle
                      .copyWith(color: ColorPalette.black))
            ],
          ),
        ),
        const Divider(
          thickness: 1,
        )
      ],
    );
  }
}
