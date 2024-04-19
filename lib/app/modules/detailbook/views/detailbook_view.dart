import 'dart:ui';

import 'package:epiq_fasha/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../data/model/buku/response_detail_buku.dart';
import '../controllers/detailbook_controller.dart';

class DetailbookView extends GetView<DetailbookController> {
  const DetailbookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double AppBarHeight = AppBar().preferredSize.height;
    double BodyHeight = height - AppBarHeight;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 10,
        flexibleSpace: const SizedBox
          (
          width: 100,
        ),
        toolbarHeight: 50,
        title: Text(
          Get.parameters['judul'].toString(),
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
        actions: [
          Obx(() {
            var dataBuku = controller.dataDetailBook.value?.buku;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: IconButton(
                  icon: Icon(
                    dataBuku?.status == 'Tersimpan'
                        ? CupertinoIcons.heart_fill
                        : CupertinoIcons.suit_heart,
                    color: dataBuku?.status == 'Tersimpan'
                        ? const Color(0xFF41B54A)
                        : Colors.black,
                    size: 24,
                  ),
                  onPressed: () {
                    if (dataBuku?.status == 'Tersimpan') {
                      return;
                    } else {
                      controller.addKoleksiBuku(context);
                    }
                  },
                ),
              ),
            );
          })
        ],
      ),
      body: Container(
        width: width,
        height: BodyHeight,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 95), // Sesuaikan dengan tinggi tombol
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
          var dataKategori = controller.dataDetailBook.value?.kategori;
          var dataUlasan = controller.dataDetailBook.value?.ulasan;
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
                  height: height * 0.020,
                ),

                Container(
                  width: width,
                  decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5).withOpacity(0.60),
                      borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Center(
                              child: SizedBox(
                                width: 35,
                                height: 35,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.asset(
                                    'lib/assets/images/profile.png',
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  dataBuku.penulis ?? '',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontSize: 12
                                  ),
                                ),

                                Text(
                                  'Bahagia itu sederhana',
                                  style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black.withOpacity(0.50),
                                      fontSize: 10
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: const Color(0xFFF3F3F3),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Icon(Icons.telegram),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: height * 0.005,
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.010,
                    ),
                    Text(
                      "Description Book:",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    Text(
                      dataBuku.deskripsi!,
                      maxLines: 15,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.80),
                        fontSize: 14.0,
                        letterSpacing: -0.3
                      ),
                      textAlign: TextAlign.justify,
                    ),
                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text(
                      "Category Book:",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.005,
                    ),
                    Wrap(
                      children: dataKategori!.map((kategori) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: TextButton(
                            onPressed: () {
                              // Tambahkan fungsi yang ingin dijalankan saat tombol ditekan
                            },
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xFFF5F5F5).withOpacity(0.50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            child: Text(
                              kategori,
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: Colors
                                    .black, // Sesuaikan dengan warna yang diinginkan
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    SizedBox(
                      height: height * 0.015,
                    ),
                    Text(
                      "Ulasan Buku",
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(
                      height: height * 0.010,
                    ),
                    buildUlasanList(dataUlasan),

                    SizedBox(
                      height: height * 0.010,
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget buildUlasanList(List<Ulasan>? ulasanList) {
    final width = MediaQuery.of(Get.context!).size.width;

    return ulasanList != null && ulasanList.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ulasanList.length,
      itemBuilder: (context, index) {
        Ulasan ulasan = ulasanList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5).withOpacity(0.50),
                borderRadius: BorderRadius.circular(10),
            ),
            width: width,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'lib/assets/images/profile.png',
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: width * 0.035,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ulasan.users?.username ?? '',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 12),
                            ),

                            // Menampilkan rating di bawah teks penulis
                            RatingBarIndicator(
                              direction: Axis.horizontal,
                              rating: ulasan.rating!.toDouble(),
                              itemCount: 5,
                              itemSize: 10,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    ulasan.ulasan ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    )
        : Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5).withOpacity(0.50),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF424242).withOpacity(0.1),
          width: 0.2,
        ),
      ),
      child: Text(
        'Belum ada ulasan buku',
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget buttonDetailBuku() {
    const Color buttonColor = Color(0xFF41B54A);
    const Color borderColor = Color(0xFF424242);

    return Obx((){
      var dataBuku = controller.dataDetailBook.value?.buku;
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
            if (dataBuku?.statusPeminjaman == 'Belum dipinjam') {
              Get.toNamed(Routes.PEMINJAMANBUKU,
                parameters: {
                  'id': (dataBuku?.bukuID ?? 0).toString(),
                  'judul': (dataBuku?.judul!).toString()
                },
              );
            }else if(dataBuku?.statusPeminjaman == 'Dipinjam'){
              return;
            }
          },
          child: Text(
            dataBuku?.statusPeminjaman == 'Belum dipinjam'
                ? 'Pinjam Buku' : 'Dipinjam',
            style: GoogleFonts.montserrat(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      );
    });
  }
}
