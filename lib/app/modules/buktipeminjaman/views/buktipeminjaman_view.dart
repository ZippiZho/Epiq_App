import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/buktipeminjaman_controller.dart';

class BuktipeminjamanView extends GetView<BuktipeminjamanController> {
  const BuktipeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 80, bottom: 30),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      kontenData(width, height),

                      Align(
                        alignment: Alignment.topCenter,
                        child: FractionalTranslation(
                          translation: const Offset(0.01, -0.50),
                          child: SizedBox(
                            width: 100,
                            height: 100,
                            child: Image.asset(
                              'lib/assets/images/model3.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),

                      // Gambar di tengah-tengah
                      Positioned(
                        left: 0,
                        right: 0,
                        top: (height - 300) / 2, // Posisi vertikal agar berada di tengah
                        child: SizedBox(
                          width: width,
                          height: 100,
                          child: Opacity(
                            opacity: 0.1,
                            child: SvgPicture.asset(
                              'lib/assets/logo/logo_green.svg',
                              fit: BoxFit.fitHeight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }

  Widget kontenData(double width, double height){
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Obx((){
          String asalHalaman = Get.parameters['asalHalaman'].toString();

          if (controller.detailPeminjaman.value == null){
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF41B54A)),
                ),
              ),
            );
          }else{
            var dataPeminjaman = controller.detailPeminjaman.value;

            return SingleChildScrollView(
              child: Column(
                children: [

                  const SizedBox(
                    height: 30,
                  ),

                  FittedBox(
                    child: Text(
                      'Peminjaman Buku Berhasil',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          letterSpacing: -0.3,
                          fontSize: 20.0,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.010,
                  ),

                  Divider(
                    color: Colors.black.withOpacity(0.10),
                    thickness: 1,
                  ),

                  SizedBox(
                    height: height * 0.020,
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Text(
                        dataPeminjaman!.kodePeminjaman.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF41B54A),
                            fontSize: 36.0
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.030,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: kontenBuktiPeminjaman(
                            'Tanggal Peminjaman', dataPeminjaman.tanggalPinjam.toString()
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),

                      Expanded(
                        child: kontenBuktiPeminjaman(
                            'Deadline Peminjaman', dataPeminjaman.deadline.toString()
                        ),
                      ),
                    ],
                  ),



                  SizedBox(
                    height: height * 0.040,
                  ),

                  Divider(
                    color: Colors.black.withOpacity(0.10),
                    thickness: 1,
                  ),

                  SizedBox(
                    height: height * 0.030,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: kontenBuktiPeminjaman(
                            'Nama Peminjam', dataPeminjaman.username.toString()
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: kontenBuktiPeminjaman(
                            'Nama Buku', dataPeminjaman.judulBuku.toString()
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: kontenBuktiPeminjaman(
                            'Penulis Buku', dataPeminjaman.penulisBuku.toString()
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: kontenBuktiPeminjaman(
                            'Tahun Terbit', dataPeminjaman.tahunBuku.toString()
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: height * 0.040,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          'Note:',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              color: Colors.grey,
                              fontSize: 20.0
                          ),
                        ),
                      ),

                      SizedBox(
                        height: height * 0.005,
                      ),

                      FittedBox(
                        child: Text(
                          'Harap kembalikan buku tepat waktu. Terima kasih.',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF41B54A),
                              fontSize: 14.0
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: height * 0.055,
                  ),

                  kontenButton(
                          (){
                        String asalHalaman = Get.parameters['asalHalaman'].toString();
                        if (asalHalaman == 'detailBuku') {
                          Get.offAllNamed(Routes.DASHBOARD); // Navigasi ke halaman detail buku
                        } else if (asalHalaman == 'historyPeminjaman') {
                          Get.back();
                        }
                      },
                      Text(
                        asalHalaman == 'detailBuku' ? 'Kembali ke Beranda' : 'Kembali',
                        style: GoogleFonts.montserrat(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black),
                      ),
                      100.0,
                      const Color(0xFF41B54A)
                  ),
                ],
              ),
            );
          }
        })
    );
  }

  Widget kontenBuktiPeminjaman(String judul, String isi){
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Text(
              judul,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                  fontSize: 16.0
              ),
            ),
          ),

          FittedBox(
            child: Text(
              isi,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16.0
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget kontenButton(final onPressed,final Widget child,
      final double radius,
      final Color buttonColor,){
    const Color borderColor = Color(0xFF424242);
    return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)
            ),
            side: const BorderSide(
              color: borderColor, // Warna border (stroke)
              width: 0.03, // Lebar border (stroke)
            ),
          ),
          onPressed: onPressed,
          child: child,
        )
    );
  }
}
