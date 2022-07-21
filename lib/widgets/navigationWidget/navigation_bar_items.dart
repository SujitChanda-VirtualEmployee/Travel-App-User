import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app_user/providers/drawer_navigation_provider.dart';
import 'package:travel_app_user/screens/about_us_screen.dart';
import 'package:travel_app_user/screens/change_password_screen.dart';
import 'package:travel_app_user/screens/contact_us_screen.dart';
import 'package:travel_app_user/screens/history_screen.dart';
import 'package:travel_app_user/screens/home_screen/home_screen.dart';
import 'package:travel_app_user/screens/notification_screen.dart';
import 'package:travel_app_user/screens/rating_screen.dart';
import 'package:travel_app_user/screens/settings_screen.dart';
import 'package:travel_app_user/utils/color_palette.dart';
import 'package:travel_app_user/utils/custom_styles.dart';
import 'package:travel_app_user/utils/size_config.dart';
import 'package:travel_app_user/widgets/custom_buttons.dart';

class NavigationBarItems extends StatefulWidget {
  const NavigationBarItems({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _NavigationBarItemsState createState() => _NavigationBarItemsState();
}

class _NavigationBarItemsState extends State<NavigationBarItems> {
  void select(int n, DrawerNavigationProvider navProvider) {
    for (int i = 0; i < 9; i++) {
      if (i != n) {
        navProvider.selected[i] = false;
      } else {
        navProvider.selected[i] = true;
        //  selected[i] = true;
      }
    }

    // Future.delayed(const Duration(milliseconds: 300), () {
    //   context.read<DrawerNavigationProvider>().closeMenu();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DrawerNavigationProvider>(
        builder: (context, navProvider, child) {
      return Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _header(),
              const SizedBox(height: 10),
              Items(
                  icon: "images/home_ic.png",
                  label: "Home",
                  touched: () {
                    Provider.of<DrawerNavigationProvider>(context,
                            listen: false)
                        .selectPageIndex(0);

                    Navigator.pushReplacementNamed(context, HomeScreen.id);
                    select(0, navProvider);
                  },
                  active: navProvider.selected[0]),
              Items(
                  icon: "images/history_ic.png",
                  label: "History",
                  touched: () {
                    Provider.of<DrawerNavigationProvider>(context,
                            listen: false)
                        .selectPageIndex(1);
                    Navigator.pushReplacementNamed(context, HistoryScreen.id);
                    select(1, navProvider);
                  },
                  active: navProvider.selected[1]),
              Items(
                  icon: "images/settings_ic.png",
                  label: "Settings",
                  touched: () {
                    Provider.of<DrawerNavigationProvider>(context,
                            listen: false)
                        .selectPageIndex(2);
                    Navigator.pushReplacementNamed(context, SettingsScreen.id);
                    select(2, navProvider);
                  },
                  active: navProvider.selected[2]),
              Items(
                  icon: "images/notification_ic.png",
                  label: "Notifications",
                  touched: () {
                    Provider.of<DrawerNavigationProvider>(context,
                            listen: false)
                        .selectPageIndex(3);
                    Navigator.pushReplacementNamed(
                        context, NotificationScreen.id);
                    select(3, navProvider);
                  },
                  active: navProvider.selected[3]),
              Items(
                  label: "Change Password",
                  icon: "images/change_password_ic.png",
                  touched: () {
                    Provider.of<DrawerNavigationProvider>(context,
                            listen: false)
                        .selectPageIndex(4);
                    Navigator.pushReplacementNamed(
                        context, ChangePasswordScreen.id);
                    select(4, navProvider);
                  },
                  active: navProvider.selected[4]),
              Items(
                  label: "Rating",
                  icon: "images/rating_ic.png",
                  touched: () {
                    Provider.of<DrawerNavigationProvider>(context,
                            listen: false)
                        .selectPageIndex(5);
                    Navigator.pushReplacementNamed(context, RatingScreen.id);
                    select(5, navProvider);
                  },
                  active: navProvider.selected[5]),
              Items(
                  label: "Share",
                  icon: "images/share_ic.png",
                  touched: () {
                    Provider.of<DrawerNavigationProvider>(context,
                            listen: false)
                        .selectPageIndex(6);

                    select(6, navProvider);
                  },
                  active: navProvider.selected[6]),
              Items(
                  label: "Contact Us",
                  icon: "images/contact_us_ic.png",
                  touched: () {
                    Provider.of<DrawerNavigationProvider>(context,
                            listen: false)
                        .selectPageIndex(7);
                    Navigator.pushReplacementNamed(context, ContactUsScreen.id);
                    select(7, navProvider);
                  },
                  active: navProvider.selected[7]),
              Items(
                  label: "About Us",
                  icon: "images/about_us_ic.png",
                  touched: () {
                    Provider.of<DrawerNavigationProvider>(context,
                            listen: false)
                        .selectPageIndex(8);
                    Navigator.pushReplacementNamed(context, AboutUsScreen.id);
                    select(8, navProvider);
                  },
                  active: navProvider.selected[8]),
              const SizedBox(height: 20),
              CustomButtonsClass.blackButton(
                  height: 72,
                  title: "LOGOUT",
                  leftMargin: 40,
                  rightMargin: 40,
                  titleStyle: CustomStyleClass.onboardingSkipButtonStyle,
                  onPressed: () {})
            ],
          ),
        ),
      );
    });
  }

  Widget _header() {
    return Container(
      height: SizeConfig.heightMultiplier * 200,
      width: double.infinity,
      color: ColorPalette.black,
      child: SafeArea(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: SizeConfig.widthMultiplier * 10,
              ),
              CircleAvatar(
                radius: (SizeConfig.imageSizeMultiplier * 11) + 2,
                backgroundColor: ColorPalette.green,
                child: CircleAvatar(
                  radius: SizeConfig.imageSizeMultiplier * 11,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'images/login_logo.png',
                    width: SizeConfig.imageSizeMultiplier * 15,
                  ),
                ),
              ),
              SizedBox(
                width: SizeConfig.widthMultiplier * 50,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jhon Doe",
                        style: CustomStyleClass.onboardingBoyTextStyle
                            .copyWith(color: Colors.white)),
                    Row(
                      children: [
                        Text("4.5 ",
                            style: CustomStyleClass.onboardingBoyTextStyle
                                .copyWith(color: Colors.white, fontSize: 14)),
                        const Icon(
                          Icons.star,
                          color: ColorPalette.green,
                          size: 15,
                        )
                      ],
                    )
                  ],
                ),
              )
            ]),
      ),
    );
  }
}

class Items extends StatefulWidget {
  final String icon;
  final Function touched;
  final bool active;
  final String label;

  Items(
      {required this.icon,
      required this.label,
      required this.touched,
      required this.active});
  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
          onTap: () {
            widget.touched();
          },
          splashColor: Colors.white,
          hoverColor: Colors.white12,
          child: Container(
              height: 45,
              margin: const EdgeInsets.only(top: 7, bottom: 7),
              color: widget.active
                  ? ColorPalette.black.withOpacity(0.1)
                  : Colors.transparent,
              child: Row(
                children: [
                  AnimatedContainer(
                      margin: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 1),
                      duration: const Duration(milliseconds: 100),
                      height: 45,
                      width: 5,
                      decoration: BoxDecoration(
                          color: widget.active
                              ? ColorPalette.black
                              : Colors.transparent,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(0.0),
                              bottomRight: Radius.circular(0)))),
                  Flexible(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 15, right: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ImageIcon(AssetImage(widget.icon),
                                color: widget.active
                                    ? ColorPalette.black
                                    : ColorPalette.black.withOpacity(0.5),
                                size: 30),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                widget.label,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                      color: widget.active
                                          ? ColorPalette.black
                                          : ColorPalette.black.withOpacity(0.5),
                                    ),
                              ),
                            )
                          ],
                        )),
                  )
                ],
              ))),
    );
  }
}
