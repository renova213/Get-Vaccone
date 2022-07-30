import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vaccine_booking/components/constants.dart';

import '../../model/history/history_model.dart';

class DetailHistoryScreen extends StatelessWidget {
  final HistoryModel history;
  const DetailHistoryScreen({Key? key, required this.history})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    String dosis = history.booking!['schedule']['dose'];
    String timeStart = history.booking!['schedule']['operational_hour_start'];
    String timeEnd = history.booking!['schedule']['operational_hour_end'];
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(gradient: gradientHorizontal),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    backIcon(context),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      "Tiket Vaksin",
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ticketContainer(context, history),
                    DottedBorder(
                      customPath: (size) {
                        return Path()
                          ..moveTo(20, 0)
                          ..lineTo(size.width - 20, 0);
                      },
                      color: Colors.grey.shade600,
                      dashPattern: const [4, 2],
                      strokeWidth: 2,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.88,
                        height: 145,
                        child: containerProgramVaccine(
                            context, dosis, timeStart, timeEnd),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    )
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: detailTicket(context, dosis, timeStart, timeEnd),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customColumnDetailTicket({String? title, String? subtitle, context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.grey.shade600),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          "$subtitle",
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.black),
        ),
      ],
    );
  }

  Widget customColumnDetailTicket2({String? title, String? subtitle, context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title",
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: Colors.grey.shade600),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          subtitle!,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(color: Colors.black),
        ),
      ],
    );
  }

  Widget backIcon(context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: SvgPicture.asset(
        'assets/icons/arrow_back.svg',
        color: Colors.white,
        width: 36,
        height: 36,
      ),
    );
  }

  Widget ticketContainer(context, HistoryModel history) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.88,
      height: 90,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              history.family!['name'],
              style: Theme.of(context)
                  .textTheme
                  .subtitle1!
                  .copyWith(color: Colors.black),
            ),
            Row(
              children: [
                Text(
                  "No. Antrian :",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  history.booking!['booking_pass'].toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget detailTicket(context, String dosis, String timeStart, String timeEnd) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Text(
              "Detail Tiket",
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.black),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Divider(
            color: Colors.grey.shade500,
            height: 10,
          ),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  child: customColumnDetailTicket(
                      title: "Nama Lengkap",
                      subtitle: history.family!['name'],
                      context: context),
                ),
                SizedBox(
                  height: 75,
                  width: MediaQuery.of(context).size.width,
                  child: customColumnDetailTicket2(
                      title: "NIK",
                      subtitle: history.family!['nik'],
                      context: context),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  child: customColumnDetailTicket(
                      title: "Tanggal Lahir",
                      subtitle: history.family!['date_of_birth'],
                      context: context),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  child: customColumnDetailTicket(
                      title: "Jenis Kelamin",
                      subtitle: history.family!['gender'],
                      context: context),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  child: customColumnDetailTicket(
                      title: "No. HP",
                      subtitle: history.family!['phone_number'],
                      context: context),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 75,
                  child: customColumnDetailTicket(
                      title: "Alamat",
                      subtitle: history.family!['id_card_address'],
                      context: context),
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 75,
                      child: customColumnDetailTicket(
                          title: "Jenis Vaksin",
                          subtitle: history.booking!['schedule']['vaccine']
                              ['vaccine_name'],
                          context: context),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.34,
                    ),
                    SizedBox(
                      height: 75,
                      child: customColumnDetailTicket(
                          title: "Dosis ke",
                          subtitle: dosis.replaceAll('DOSIS_', ''),
                          context: context),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: 75,
                      child: customColumnDetailTicket(
                          title: "Tanggal Vaksinasi",
                          subtitle: history.booking!['schedule']
                              ['vaccination_date'],
                          context: context),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.21,
                    ),
                    SizedBox(
                      height: 75,
                      child: customColumnDetailTicket(
                          title: "Waktu",
                          subtitle:
                              "${timeStart.substring(0, 5)}-${timeEnd.substring(0, 5)}",
                          context: context),
                    ),
                  ],
                ),
                SizedBox(
                  height: 85,
                  child: customColumnDetailTicket(
                      title: "Lokasi Vaksin",
                      subtitle: history.booking!['schedule']['facility']
                          ['street_name'],
                      context: context),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget containerProgramVaccine(
      context, String dosis, String timeStart, String timeEnd) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                detailVaccine(
                    context: context,
                    title: history.booking!['schedule']['vaccine']
                        ['vaccine_name'],
                    assetIcon: 'assets/icons/syringe2.svg'),
                detailVaccine(
                    context: context,
                    title: dosis.replaceAll('DOSIS_', 'Dosis '),
                    assetIcon: 'assets/icons/dose.svg'),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    detailVaccine(
                        context: context,
                        title: history.booking!['schedule']['vaccination_date'],
                        assetIcon: 'assets/icons/datetime.svg'),
                  ],
                ),
                Row(
                  children: [
                    detailVaccine(
                        context: context,
                        title:
                            "${timeStart.substring(0, 5)} - ${timeEnd.substring(0, 5)}",
                        assetIcon: 'assets/icons/clock.svg'),
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
                  'assets/icons/location.svg',
                  color: primaryColor,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(
                  width: 4,
                ),
                Flexible(
                  child: Text(
                    history.booking!['schedule']['facility']['street_name'],
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2!
                        .copyWith(color: Colors.grey.shade800),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget detailVaccine({context, assetIcon, title}) {
    return Row(
      children: [
        SvgPicture.asset(
          assetIcon,
          color: primaryColor,
          width: 20,
          height: 20,
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: Colors.grey.shade800),
        ),
      ],
    );
  }
}
