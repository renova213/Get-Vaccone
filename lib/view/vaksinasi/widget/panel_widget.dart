import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vaccine_booking/components/constants.dart';
import 'package:vaccine_booking/components/navigator_fade_transition.dart';
import 'package:vaccine_booking/model/vaksinasi/datail_booking_model.dart';
import 'package:vaccine_booking/view/vaksinasi/widget/content_list_booking.dart';
import 'package:vaccine_booking/view/history/history_screen.dart';
import 'package:vaccine_booking/view/profile/register_family_screen.dart';
import 'package:vaccine_booking/view_model/history_view_model.dart';
import 'package:vaccine_booking/view_model/profile_view_model.dart';

import '../../../model/vaksinasi/booking_model.dart';
import '../../../model/vaksinasi/health_facility_model.dart';
import '../../../view_model/vaksinasi_view_model.dart';

class PanelWidget extends StatefulWidget {
  final HealthFacilityModel facilities;
  final int? id;
  final PanelController panelController;
  final ScrollController controller;
  final String dateSchedule;
  final int scheduleId;
  const PanelWidget(
      {Key? key,
      required this.controller,
      required this.panelController,
      required this.facilities,
      required this.id,
      required this.dateSchedule,
      required this.scheduleId})
      : super(key: key);

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  bool isPressed = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final vaksinasi = Provider.of<VaksinasiViewModel>(context);
    final user = Provider.of<ProfileViewModel>(context);
    final history = Provider.of<HistoryViewModel>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.35,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.53,
                child: const Text(
                  "Pilih Anggota",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.10,
                child: dragHandle(),
              ),
            ],
          ),
          SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.23,
              child: listDaftarAnggota(vaksinasi, user),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: SizedBox(
              height: 55,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ElevatedButton(
                style: secondStateButton,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/new-member.svg',
                      color: primaryColor,
                      height: 22,
                      width: 22,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      "Tambah Keluarga",
                    ),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    NavigatorFadeTransition(
                      child: const RegisterFamilyScreen(),
                    ),
                  );
                  widget.panelController.close();
                },
              ),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: SizedBox(
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              child: vaksinasi.selectBookingVaksinasiList.isEmpty
                  ? ElevatedButton(
                      onPressed: null,
                      child: Text(
                        "Pesan",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: Colors.white),
                      ),
                    )
                  : ElevatedButton(
                      child: isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Pesan",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.white),
                            ),
                      onPressed: () async {
                        if (isLoading) return;
                        setState(() => isLoading = true);
                        String dateNow = DateFormat('dd-MM-yyyy').format(
                          DateTime.now(),
                        );
                        String timeNow = DateFormat('HH:mm:ss').format(
                          DateTime.now(),
                        );
                        if (widget.scheduleId == 0) {
                          Fluttertoast.showToast(
                              toastLength: Toast.LENGTH_LONG,
                              msg: "Pilih jadwal terlebih dahulu");
                        } else {
                          try {
                            await Future.delayed(
                              const Duration(seconds: 0),
                            )
                                .then(
                                  (_) async {
                                    for (int i = 0;
                                        i <
                                            vaksinasi.selectBookingVaksinasiList
                                                .length;
                                        i++) {
                                      await vaksinasi.postBooking(
                                        booking: BookingModel(
                                          bookingDate: "$dateNow $timeNow",
                                          schedule: {"id": widget.scheduleId},
                                          user: {
                                            "id": user.filterUserProfile[0]
                                                .profile['user_id'],
                                          },
                                        ),
                                      );
                                    }
                                  },
                                )
                                .then(
                                  (_) => vaksinasi.bookingList.clear(),
                                )
                                .then(
                                  (_) => vaksinasi.filterBookingList.clear(),
                                )
                                .then(
                                  (_) => vaksinasi.getBookingList(),
                                )
                                .then((_) => setState(() {}))
                                .then(
                                  (_) async => await Future.delayed(
                                    const Duration(seconds: 2),
                                  ),
                                )
                                .then((_) => setState(() {}))
                                .then(
                                  (_) async => await Future.delayed(
                                    const Duration(seconds: 2),
                                  ),
                                )
                                .then(
                                  (_) async {
                                    for (int i = 0;
                                        i <
                                            vaksinasi.selectBookingVaksinasiList
                                                .length;
                                        i++) {
                                      int filterBookingLength =
                                          vaksinasi.filterBookingList.length;
                                      await vaksinasi.postDetailBooking(
                                        DetailBookingModel(
                                            bookingId: vaksinasi
                                                .filterBookingList[
                                                    filterBookingLength - i - 1]
                                                .id,
                                            familyId: vaksinasi
                                                .selectBookingVaksinasiList[
                                                    vaksinasi
                                                            .selectBookingVaksinasiList
                                                            .length -
                                                        i -
                                                        1]
                                                .id,
                                            bookingStatus: "COMPLETED"),
                                      );
                                    }
                                  },
                                )
                                .then(
                                  (_) => history.detailBookingList.clear(),
                                )
                                .then(
                                  (_) =>
                                      history.filterDetailBookingList.clear(),
                                )
                                .then(
                                  (_) => history.filterDetailVaksinasiOrder
                                      .clear(),
                                )
                                .then(
                                  (_) => history.filterNameBooking.clear(),
                                )
                                .then(
                                  (_) => history.filterDetailVaksinasiOrder
                                      .clear(),
                                )
                                .then(
                                  (_) => vaksinasi.selectBookingVaksinasiList
                                      .clear(),
                                )
                                .then(
                                  (_) => user.userFamily.clear(),
                                )
                                .then(
                                  (_) => history.getDetailBooking(),
                                )
                                .then(
                                  (_) => Future.delayed(
                                    const Duration(seconds: 1),
                                  ),
                                )
                                .then(
                                  (_) => setState(() => isLoading = false),
                                )
                                .then(
                                  (_) => showDialog(
                                    context: context,
                                    builder: (context) {
                                      return modalSuccess();
                                    },
                                  ),
                                );
                          } catch (e) {
                            Fluttertoast.showToast(msg: e.toString());
                          }
                        }
                      },
                    ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget modalSuccess() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.65,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close, color: primaryColor, size: 32),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.25,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/successBooking.png'),
                      fit: BoxFit.fill),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                "Pemesanan Sukses!",
                style: Theme.of(context)
                    .textTheme
                    .headline2!
                    .copyWith(color: primaryColor),
              ),
              const SizedBox(
                height: 12,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: Text(
                  "Tiket vaksin kamu sudah dapat dilihat di halaman tiket.",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.grey.shade500),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: const Text(
                      "Lihat Tiket",
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        NavigatorFadeTransition(
                          child: const HistoryScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listDaftarAnggota(
      VaksinasiViewModel vaksinasi, ProfileViewModel user) {
    return ListView.separated(
      controller: widget.controller,
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) {
        return const Divider(
          color: Colors.white,
        );
      },
      itemCount: user.userFamily.length,
      itemBuilder: (context, index) {
        return ContentListBooking(
          family: user.userFamily[index],
          isPressed: isPressed,
          index: index,
          vaksinasi: vaksinasi,
          user: user,
          scheduleId: widget.scheduleId,
        );
      },
    );
  }

  Widget dragHandle() {
    return TextButton(
      onPressed: togglePanel,
      child: SizedBox(
        height: 28,
        width: 28,
        child: SvgPicture.asset(
          'assets/icons/arrow_up.svg',
          color: primaryColor,
        ),
      ),
    );
  }

  void togglePanel() => widget.panelController.isPanelOpen
      ? widget.panelController.close()
      : widget.panelController.open();
}
