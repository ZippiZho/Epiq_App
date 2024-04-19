import 'dart:ui';

import 'package:epiq_fasha/app/data/provider/storage_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/customTextFieldPeminjaman.dart';
import '../controllers/peminjamanbuku_controller.dart';

class PeminjamanbukuView extends GetView<PeminjamanbukuController> {
  const PeminjamanbukuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double AppBarHeight = AppBar().preferredSize.height;
    double BodyHeight = height - AppBarHeight;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: -5,
        flexibleSpace: const SizedBox
          (
          width: 100,
        ),
        toolbarHeight: 50,
        title: Text(
          'Peminjaman Buku',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.montserrat(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        leadingWidth: 55,
        leading: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5),
          width: 45,
          height: 45,
          decoration: BoxDecoration(
              color: const Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(10)
          ),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
      body: SizedBox(
        width: width,
        height: BodyHeight,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 95),
                child: kontenDataDetailBuku(),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5).withOpacity(0.70),
                    border: Border(
                      top: BorderSide(
                        color: const Color(0xFF424242).withOpacity(0.20),
                        width: 0.2,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: buttonDetailBuku(),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget kontenDataDetailBuku() {
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;

    return Obx(
          () {
        if (controller.dataDetailBook.isNull) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF41B54A)),
              ),
            ),
          );
        } else if (controller.dataDetailBook.value == null) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 50),
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.black,
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF41B54A)),
              ),
            ),
          );
        } else {
          var dataBuku = controller.dataDetailBook.value?.buku;
          return  Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.020,
                ),

                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        spreadRadius: -1,
                        blurRadius: 20,
                        offset: const Offset(0, -1), // changes position of shadow
                      ),
                    ],
                  ),
                  height: 250,
                  child: Stack(
                    children: [

                      Positioned(
                        top: 0,
                        right: 0,
                        left: 0,
                        child: SizedBox(
                          width: width,
                          height: 250,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Image.network(
                                  dataBuku!.coverBuku.toString(),
                                  width: double.infinity,
                                  fit: BoxFit.fitWidth,
                                ),
                                BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                                  child: Container(
                                    color: Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Center(
                          child: SizedBox(
                            width: 135,
                            height: 200,
                            child: Image.network(
                              dataBuku.coverBuku.toString(),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: height * 0.015,
                ),

                Text(
                  dataBuku.judul!,
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                    letterSpacing: -0.4,
                    fontSize: 28.0,
                  ),
                  maxLines: 2,
                  textAlign: TextAlign.start,
                ),

                FittedBox(
                  child: Text(
                    "${dataBuku.penerbit!} | @${dataBuku.tahunTerbit!} ",
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(
                  height: height * 0.030,
                ),

                SizedBox(
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Peminjam Buku',
                        style: GoogleFonts.montserrat(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          letterSpacing: -0.2
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      Text(
                        StorageProvider.read(StorageKey.email).toString(),
                        style: GoogleFonts.montserrat(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            letterSpacing: -0.1
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      SizedBox(
                        width: width,
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomTextFieldPeminjaman(
                                preficIcon: const Icon(CupertinoIcons.calendar_today),
                                InitialValue: controller.formattedToday.toString(),
                                labelText: 'Tanggal Peminjaman',
                                obsureText: false,
                              ),
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            Expanded(
                              child: CustomTextFieldPeminjaman(
                                preficIcon: const Icon(CupertinoIcons.calendar),
                                InitialValue: controller.formattedTwoWeeksLater.toString(),
                                labelText: 'Deadline Pengembalian',
                                obsureText: false,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Obx(() => Checkbox(
                            value: controller.isChecked.value,
                            onChanged: (value) {
                              controller.toggleCheckBox();
                            },
                            activeColor: const Color(0xFF41B54A),
                          )
                          ),
                          Expanded(
                            child: Text(
                              "Setuju dengan waktu peminjaman buku",
                              maxLines: 1,
                              style: GoogleFonts.montserrat(
                                fontSize: 12.0,
                                color: Colors.grey,
                                letterSpacing: -0.2,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  Widget buttonDetailBuku() {
    const Color buttonColor = Color(0xFF41B54A);
    const Color borderColor = Color(0xFF424242);

    return SizedBox(
      width: double.infinity,
      height: 50.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(
            color: borderColor.withOpacity(0.30),
            width: 0.3,
          ),
        ),
        onPressed: () {
          if (!controller.isChecked.value) {
            return;
          }
          controller.addPeminjamanBuku();
        },
        child: Text(
          'Setuju & Lanjutkan',
          style: GoogleFonts.montserrat(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
