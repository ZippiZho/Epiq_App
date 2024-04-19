import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/historypeminjaman_controller.dart';

class HistorypeminjamanView extends GetView<HistorypeminjamanController> {
  const HistorypeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // size
    final height = MediaQuery.of(Get.context!).size.height;
    final width = MediaQuery.of(Get.context!).size.width;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title: InkWell(
            onTap: ()async{
              await controller.getDataPeminjaman();
            },
            child: Text(
              'History Peminjaman',
              style: GoogleFonts.montserrat(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.w700
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: SizedBox(
          width: width,
          height: height,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70),
              child: Column(
                children: [
                  sectionHistoryPeminjaman(),
                  SizedBox(
                    height: height * 0.020,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget sectionHistoryPeminjaman() {
    const Color background = Color(0xFF008A93);
    const Color borderColor = Color(0xFF424242);

    // size
    final width = MediaQuery.of(Get.context!).size.width;
    return SizedBox(
      child: Obx(
            () {
          if (controller.historyPeminjaman.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: borderColor.withOpacity(0.30),
                        width: 0.3,
                      )),
                  child: Center(
                    child: Text(
                      'History Peminjaman empty',
                      style: GoogleFonts.montserrat(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            );
          } else {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.historyPeminjaman.length,
              itemBuilder: (context, index) {
                var dataHistory = controller.historyPeminjaman[index];
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: 180,
                  width: width - 40.0,
                  child: InkWell(
                    onTap: (){
                      dataHistory.status == 'Selesai' ? controller.kontenBeriUlasan(dataHistory.bukuId.toString(), dataHistory.judulBuku.toString()) :
                      Get.toNamed(Routes.BUKTIPEMINJAMAN, parameters: {
                        'idPeminjaman': dataHistory.peminjamanID.toString(),
                        'asalHalaman' : 'historyPeminjaman',
                      });
                    },
                    child: Stack(
                      children: [
                        // Container dengan latar hitam dan konten dataHistory
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 150,
                            width: width - 40.0,
                            padding: const EdgeInsets.only(left: 135,top: 10, bottom: 10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF383838),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataHistory.kodePeminjaman!,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      fontSize: 20.0,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    dataHistory.judulBuku!,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    'Tanggal Pinjam : ${dataHistory.tanggalPinjam!}',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Deadline Pengembalian : ${dataHistory.tanggalKembali!}',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        // Gambar di sebelah kiri (overlay)
                        Positioned(
                          left: 10,
                          top: 0,
                          bottom: 10,
                          child: Container(
                            width: 130,
                            height: 180,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: ColorFiltered(
                                    colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.30), // Ubah nilai opacity sesuai kebutuhan
                                      BlendMode.darken,
                                    ),
                                    child: Image.network(
                                      dataHistory.coverBuku.toString(),
                                      width: 130,
                                      height: 180,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: dataHistory.status == 'Ditolak'
                                            ? const Color(0xFFEA1818)
                                            : dataHistory.status == 'Dipinjam'
                                            ? const Color(0xFF121212)
                                            : dataHistory.status ==
                                            'Selesai'
                                            ? const Color(0xFF41B54A)
                                            : const Color(0xFF1B1B1D),
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        )),
                                    child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            dataHistory.status == 'Selesai' ? const SizedBox() : const Icon(
                                              CupertinoIcons.info_circle_fill,
                                              color: Colors.white,
                                              size: 20,
                                            ),


                                            dataHistory.status == 'Selesai' ? const SizedBox() : const SizedBox(
                                              width: 10,
                                            ),

                                            Text(
                                              dataHistory.status == 'Selesai' ? 'Beri Ulasan' : dataHistory.status.toString(),
                                              style: GoogleFonts.montserrat(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
