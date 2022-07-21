import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:travel_app_user/utils/color_palette.dart';
import 'package:travel_app_user/utils/custom_styles.dart';
import 'package:travel_app_user/utils/size_config.dart';
import 'package:travel_app_user/widgets/navigationWidget/navigation_bar.dart';

enum StatusType { pending, confirm, completed, cancelled }

class HistoryScreen extends StatefulWidget {
  static const String id = 'history-screen';
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      key: scaffoldKey,
      drawer: const CustomNavigationBar(),
      appBar: AppBar(
        title: const Text("Hostory"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () => scaffoldKey.currentState!.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const ImageIcon(AssetImage("images/calender_ic.png")),
            onPressed: () {},
          )
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return SizedBox(
      height: SizeConfig.fullHeight,
      width: SizeConfig.fullWidth,
      child: Column(children: [
        CalendarTimeline(
          initialDate: DateTime(2020, 4, 20),
          firstDate: DateTime(2019, 1, 15),
          lastDate: DateTime(2020, 11, 20),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: ColorPalette.black,
          dayColor: ColorPalette.dark,
          activeDayColor: ColorPalette.green,
          activeBackgroundDayColor: ColorPalette.black,
          dotsColor: ColorPalette.white,
          //  selectableDayPredicate: (date) => date.day != 23,
          locale: 'en_ISO',
        ),
        const Divider(
          thickness: 1,
          height: 20,
        ),
        Expanded(
            child: ListView(
          shrinkWrap: true,
          children: [
            CustomListWidget(
              amount: 2.5,
              dropLocation: "New Delhi Metro Station, Sector 87 ",
              pickupLocation: "New Delhi Metro Station, Sector 34 ",
              status: StatusType.confirm,
            ),
            CustomListWidget(
              amount: 2.5,
              dropLocation: "New Delhi Metro Station, Sector 87 ",
              pickupLocation: "New Delhi Metro Station, Sector 34 ",
              status: StatusType.completed,
            ),
            CustomListWidget(
              amount: 2.5,
              dropLocation: "New Delhi Metro Station, Sector 87 ",
              pickupLocation: "New Delhi Metro Station, Sector 34 ",
              status: StatusType.cancelled,
            ),
            CustomListWidget(
              amount: 2.5,
              dropLocation: "New Delhi Metro Station, Sector 87 ",
              pickupLocation: "New Delhi Metro Station, Sector 34 ",
              status: StatusType.pending,
            )
          ],
        ))
      ]),
    );
  }
}

class CustomListWidget extends StatefulWidget {
  final String pickupLocation;
  final String dropLocation;
  final double amount;
  final StatusType status;

  // ignore: prefer_const_constructors_in_immutables
  CustomListWidget({
    Key? key,
    required this.pickupLocation,
    required this.dropLocation,
    required this.amount,
    required this.status,
  }) : super(key: key);

  @override
  State<CustomListWidget> createState() => _CustomListWidgetState();
}

class _CustomListWidgetState extends State<CustomListWidget> {
  TextEditingController pickupLoc = TextEditingController();
  TextEditingController dropLoc = TextEditingController();
  @override
  void initState() {
    pickupLoc.text = widget.pickupLocation;
    dropLoc.text = widget.dropLocation;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.heightMultiplier * 250,
      width: SizeConfig.fullWidth,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          shadowColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Colors.white,
          child: InkWell(
            borderRadius: BorderRadius.circular(15.0),
            onTap: () {},
            child: Column(
              children: [
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
                                  controller: pickupLoc,
                                  readOnly: true,
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
                                  ),
                                ),
                              ),
                              const Divider(
                                thickness: 1,
                                height: 0,
                              ),
                              Expanded(
                                child: TextField(
                                  readOnly: true,
                                  controller: dropLoc,
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
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    )
                  ]),
                ),
                const Divider(
                  thickness: 1,
                  height: 0,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 25, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$ ${widget.amount}",
                          style: CustomStyleClass.onboardingBoyTextStyle
                              .copyWith(
                                  color: ColorPalette.black,
                                  fontWeight: FontWeight.bold)),
                      // Text("\$ ${widget.amount}")
                      statusStyle(widget.status)
                    ],
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget statusStyle(StatusType status) {
    return Text(
      status == StatusType.cancelled
          ? "Cancelled"
          : status == StatusType.completed
              ? "Completed"
              : status == StatusType.confirm
                  ? "Confirm"
                  : status == StatusType.pending
                      ? "Pending"
                      : "",
      style: CustomStyleClass.onboardingBoyTextStyle.copyWith(
        fontWeight: FontWeight.bold,
        color: status == StatusType.cancelled
            ? ColorPalette.dark
            : status == StatusType.completed
                ? ColorPalette.green
                : status == StatusType.confirm
                    ? Colors.purple
                    : status == StatusType.pending
                        ? Colors.amber
                        : ColorPalette.white,
      ),
    );
  }
}
