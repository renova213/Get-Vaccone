import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vaccine_booking/components/constants.dart';
import 'package:vaccine_booking/view/vaksinasi/widget/panel_widget.dart';
import 'package:vaccine_booking/view_model/profile_view_model.dart';
import 'package:vaccine_booking/view_model/vaksinasi_view_model.dart';

import '../../components/skeleton_container.dart';
import '../../model/vaksinasi/health_facility_model.dart';

class VaksinasiBookingScreen extends StatefulWidget {
  final HealthFacilityModel facilities;
  final int? id;
  const VaksinasiBookingScreen({
    Key? key,
    required this.facilities,
    this.id,
  }) : super(key: key);

  @override
  State<VaksinasiBookingScreen> createState() => _VaksinasiBookingScreenState();
}

class _VaksinasiBookingScreenState extends State<VaksinasiBookingScreen> {
  final TextEditingController dateCtl = TextEditingController();
  final PanelController panelController = PanelController();
  int scheduleId = 0;
  bool vaksinA = false;
  bool vaksinB = false;
  bool vaksinC = false;
  bool vaksinD = false;

  @override
  Widget build(BuildContext context) {
    final schedule = Provider.of<VaksinasiViewModel>(context);
    final user = Provider.of<ProfileViewModel>(context);
    if (user.familyList.isEmpty) {
      Provider.of<ProfileViewModel>(context).getAllFamilies();
    }
    if (user.userFamily.isEmpty) {
      Provider.of<ProfileViewModel>(context).filterUserFamily();
    }
    if (dateCtl.text.isEmpty) {
      schedule.scheduleIdBooking = 0;
      schedule.scheduleList.clear();
      schedule.filterScheduleList.clear();
      schedule.filterScheduleSessionList.clear();
    }
    Provider.of<VaksinasiViewModel>(context).filterSchedule(widget.id!);

    Provider.of<VaksinasiViewModel>(context)
        .filterScheduleSession(dateCtl.text, widget.id!);

    if (schedule.filterBookingList.isEmpty) {
      Provider.of<VaksinasiViewModel>(context)
          .filterBooking(user.userData[0].profile!['user_id'], scheduleId);
    }
    Provider.of<VaksinasiViewModel>(context).filterSelectVaccine();

    return Scaffold(
      body: SlidingUpPanel(
        defaultPanelState: PanelState.CLOSED,
        maxHeight: MediaQuery.of(context).size.height * 0.58,
        minHeight: MediaQuery.of(context).size.height * 0.09,
        controller: panelController,
        parallaxEnabled: true,
        parallaxOffset: .5,
        boxShadow: const [
          BoxShadow(
              offset: Offset(0.0, 1.00),
              blurRadius: 17,
              color: Colors.grey,
              spreadRadius: 1.00),
        ],
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(25),
        ),
        panelBuilder: (controller) => PanelWidget(
          scheduleId: scheduleId,
          id: widget.id,
          facilities: widget.facilities,
          controller: controller,
          panelController: panelController,
          dateSchedule: dateCtl.text,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(gradient: gradientHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        "Pesan Vaksinasi",
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 1.09,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 16,
                          ),
                          imageFacility(),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            widget.facilities.facilityName!,
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                'assets/icons/location.svg',
                                color: Colors.grey.shade700,
                                width: 24,
                                height: 24,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: Text(
                                  widget.facilities.streetName!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2!
                                      .copyWith(color: Colors.grey.shade900),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            "Jadwal",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2!
                                .copyWith(color: Colors.grey.shade700),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          selectDate(schedule),
                          const SizedBox(
                            height: 16,
                          ),
                          selectVaccine(schedule, user),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customContainerVaksin(
      {Color? border,
      Color? color,
      String? jenisVaksin,
      int? stock,
      String? dosis,
      String? time1,
      String? time2,
      double? widthBorder}) {
    return Container(
      width: dateCtl.text.isNotEmpty
          ? MediaQuery.of(context).size.width * 0.43
          : 0,
      height: dateCtl.text.isNotEmpty ? 100 : 0,
      decoration: BoxDecoration(
        border: Border.all(
          color: border!,
          width: widthBorder!,
        ),
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/clock.svg',
                    color: primaryColor,
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    "${time1!.substring(0, 5).replaceAll(':', '.')} - ",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black),
                  ),
                  Text(
                    time2!.substring(0, 5).replaceAll(':', '.'),
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.black),
                  ),
                ],
              ),
              Divider(
                color: Colors.grey.shade700,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/syringe2.svg',
                        color: primaryColor,
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.13,
                        height: 20,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            jenisVaksin!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.grey.shade800),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/dose.svg',
                        color: primaryColor,
                        width: 16,
                        height: 16,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.13,
                        height: 20,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            dosis!.replaceAll('_', ' '),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.grey.shade800),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/product.svg',
                    color: primaryColor,
                    width: 16,
                    height: 16,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    ' Dosis $stock',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.grey.shade800),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageFacility() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.17,
        width: MediaQuery.of(context).size.width * 0.9,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.memory(
            convertBase64Image(
              widget.facilities.image['base64'],
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget selectVaccine(VaksinasiViewModel schedule, ProfileViewModel family) {
    return Column(
      children: [
        Row(
          children: [
            schedule.filterScheduleSessionList.isEmpty
                ? Container()
                : GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          if (vaksinA == false ||
                              vaksinB == true ||
                              vaksinC == true ||
                              vaksinD == true) {
                            setState(() {
                              schedule.selectBookingVaksinasiList.clear();
                              family.userFamily.clear();
                              scheduleId = schedule.scheduleId1;
                              panelController.open();
                            });
                            vaksinA = true;
                            vaksinB = false;
                            vaksinC = false;
                            vaksinD = false;
                          } else {
                            vaksinA = false;
                            vaksinB = false;
                            vaksinC = false;
                            vaksinD = false;
                            panelController.close();
                            scheduleId = 0;
                          }
                        },
                      );
                    },
                    child: vaksinA
                        ? customContainerVaksin(
                            color: secondColorLow,
                            border: pressedColor,
                            jenisVaksin: schedule.vaccine1,
                            time1: schedule.timeStart1,
                            time2: schedule.timeEnd1,
                            stock: schedule.stock1,
                            dosis: schedule.dosis1,
                            widthBorder: 2)
                        : customContainerVaksin(
                            border: secondColor,
                            color: Colors.white,
                            jenisVaksin: schedule.vaccine1,
                            time1: schedule.timeStart1,
                            time2: schedule.timeEnd1,
                            stock: schedule.stock1,
                            dosis: schedule.dosis1,
                            widthBorder: 1),
                  ),
            const SizedBox(
              width: 12,
            ),
            schedule.filterScheduleSessionList.isEmpty ||
                    schedule.filterScheduleSessionList.length == 1
                ? Container()
                : GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          if (vaksinB == false ||
                              vaksinA == true ||
                              vaksinC == true ||
                              vaksinD == true) {
                            setState(() {
                              schedule.selectBookingVaksinasiList.clear();
                              family.userFamily.clear();
                              scheduleId = schedule.scheduleId2;
                              panelController.open();
                            });
                            vaksinB = true;
                            vaksinA = false;
                            vaksinC = false;
                            vaksinD = false;
                          } else {
                            vaksinA = false;
                            vaksinB = false;
                            vaksinC = false;
                            vaksinD = false;
                            panelController.close();
                            scheduleId = 0;
                          }
                        },
                      );
                    },
                    child: vaksinB
                        ? customContainerVaksin(
                            color: secondColorLow,
                            border: pressedColor,
                            jenisVaksin: schedule.vaccine2,
                            time1: schedule.timeStart2,
                            time2: schedule.timeEnd2,
                            stock: schedule.stock2,
                            dosis: schedule.dosis2,
                            widthBorder: 2)
                        : customContainerVaksin(
                            border: secondColor,
                            color: Colors.white,
                            jenisVaksin: schedule.vaccine2,
                            time1: schedule.timeStart2,
                            time2: schedule.timeEnd2,
                            stock: schedule.stock2,
                            dosis: schedule.dosis2,
                            widthBorder: 1),
                  ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            schedule.filterScheduleSessionList.isEmpty ||
                    schedule.filterScheduleSessionList.length == 1 ||
                    schedule.filterScheduleSessionList.length == 2
                ? Container()
                : GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          if (vaksinC == false ||
                              vaksinA == true ||
                              vaksinB == true ||
                              vaksinD == true) {
                            setState(() {
                              schedule.selectBookingVaksinasiList.clear();
                              family.userFamily.clear();
                              scheduleId = schedule.scheduleId3;
                              panelController.open();
                            });

                            vaksinC = true;
                            vaksinA = false;
                            vaksinB = false;
                            vaksinD = false;
                          } else {
                            vaksinA = false;
                            vaksinB = false;
                            vaksinC = false;
                            vaksinD = false;
                            panelController.close();
                            scheduleId = 0;
                          }
                        },
                      );
                    },
                    child: vaksinC
                        ? customContainerVaksin(
                            color: secondColorLow,
                            border: pressedColor,
                            jenisVaksin: schedule.vaccine3,
                            time1: schedule.timeStart3,
                            time2: schedule.timeEnd3,
                            stock: schedule.stock3,
                            dosis: schedule.dosis3,
                            widthBorder: 2)
                        : customContainerVaksin(
                            border: secondColor,
                            color: Colors.white,
                            jenisVaksin: schedule.vaccine3,
                            time1: schedule.timeStart3,
                            time2: schedule.timeEnd3,
                            stock: schedule.stock3,
                            dosis: schedule.dosis3,
                            widthBorder: 1),
                  ),
            const SizedBox(
              width: 12,
            ),
            schedule.filterScheduleSessionList.isEmpty ||
                    schedule.filterScheduleSessionList.length == 1 ||
                    schedule.filterScheduleSessionList.length == 2 ||
                    schedule.filterScheduleSessionList.length == 3
                ? Container()
                : GestureDetector(
                    onTap: () {
                      setState(
                        () {
                          if (vaksinD == false ||
                              vaksinA == true ||
                              vaksinB == true ||
                              vaksinC == true) {
                            setState(() {
                              schedule.selectBookingVaksinasiList.clear();
                              family.userFamily.clear();
                              scheduleId = schedule.scheduleId4;
                              panelController.open();
                            });
                            vaksinD = true;
                            vaksinA = false;
                            vaksinB = false;
                            vaksinC = false;
                          } else {
                            vaksinA = false;
                            vaksinB = false;
                            vaksinC = false;
                            vaksinD = false;
                            panelController.close();
                            scheduleId = 0;
                          }
                        },
                      );
                    },
                    child: vaksinD
                        ? customContainerVaksin(
                            color: secondColorLow,
                            border: pressedColor,
                            jenisVaksin: schedule.vaccine4,
                            time1: schedule.timeStart4,
                            time2: schedule.timeEnd4,
                            stock: schedule.stock4,
                            dosis: schedule.dosis4,
                            widthBorder: 2)
                        : customContainerVaksin(
                            border: secondColor,
                            color: Colors.white,
                            jenisVaksin: schedule.vaccine4,
                            time1: schedule.timeStart4,
                            time2: schedule.timeEnd4,
                            stock: schedule.stock4,
                            dosis: schedule.dosis4,
                            widthBorder: 1),
                  ),
          ],
        ),
      ],
    );
  }

  Widget selectDate(VaksinasiViewModel schedule) {
    DateTime date = DateTime.now();
    DateTime initialDate = DateTime(
      date.year,
      date.month,
      date.day + 1,
    );
    DateTime firstDate = DateTime(
      date.year,
      date.month,
      date.day + 1,
    );
    DateTime lastDate = DateTime(
      date.year,
      date.month,
      date.day + 8,
    );
    return GestureDetector(
      onTap: () async {
        schedule.getAllSchedule();
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: initialDate,
            firstDate: firstDate,
            lastDate: lastDate);

        if (pickedDate != null) {
          setState(
            () {
              dateCtl.text = DateFormat('dd-MM-yyyy').format(pickedDate);
            },
          );
        }
      },
      child: TextFormField(
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.grey.shade700),
        controller: dateCtl,
        enabled: false,
        cursorColor: Colors.white,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          suffixIconConstraints:
              const BoxConstraints(minHeight: 24, minWidth: 24),
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: SvgPicture.asset(
              'assets/icons/suffix.svg',
              color: Colors.grey,
              height: 24,
              width: 24,
            ),
          ),
          contentPadding:
              const EdgeInsets.only(top: 8, left: 16, bottom: 8, right: 8),
          hintText: 'Pilih tanggal',
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.grey.shade400),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: buttonColorSecondary,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: buttonColorSecondary,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          fillColor: Colors.white,
          filled: true,
        ),
        textInputAction: TextInputAction.next,
        validator: (value) {
          if (value!.isEmpty) {
            return "Required";
          }
          return null;
        },
      ),
    );
  }

  Widget imageSkeleton() {
    return SkeletonContainer(
      borderRadius: 10,
      height: MediaQuery.of(context).size.height * 0.17,
      width: MediaQuery.of(context).size.width * 0.9,
    );
  }
}
