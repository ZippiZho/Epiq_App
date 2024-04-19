import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookbykategori_controller.dart';

class BookbykategoriView extends GetView<BookbykategoriController> {
  const BookbykategoriView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final bodyHeight = height - 55;

    String namaKategori = Get.parameters['namaKategori'].toString();

    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          flexibleSpace: const SizedBox
            (
            width: 100,
          ),
          toolbarHeight: 50,
          title: Text(
            'Buku Berdasarkan $namaKategori',
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
          height: bodyHeight,
          child: RefreshIndicator(
            onRefresh: () async{
              await controller.getDataBookKategori();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: kontenDataBook(),
              ),
            ),
          ),
        )
    );
  }

  Widget kontenDataBook() {
    return Obx((){
      if (controller.dataBookByKategori.isEmpty) {
        return kontenDataKosong();
      } else {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 4 / 6,
          ),
          itemCount: controller.dataBookByKategori.length,
          itemBuilder: (context, index) {
            var buku = controller.dataBookByKategori[index];
            return InkWell(
              onTap: () {
                Get.toNamed(Routes.DETAILBOOK,
                  parameters: {
                    'id': (buku.bukuID ?? 0).toString(),
                    'judul': (buku.judul!).toString()
                  },
                );
              },
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 4/6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.30), // Ubah nilai opacity sesuai kebutuhan
                          BlendMode.darken,
                        ),
                        child: Image.network(
                          buku.coverBuku.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),

                  buku.status == "Popular" ?
                  Positioned(
                    bottom: 10,
                    left: 10,
                    right: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.fire_hydrant_alt_rounded,
                            color: Colors.white,
                            size: 18,
                          ),

                          const SizedBox(
                            width: 3,
                          ),

                          Expanded(
                            child: Text(
                              'Popular Book',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ) : const SizedBox()
                ],
              ),
            );
          },
        );
      }
    });
  }

  Widget kontenDataKosong(){
    // Color
    const Color background = Color(0xFFF5F5F5);

    String namaBuku = Get.parameters['namaKategori'].toString();

    return Center(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: background,
              borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              'Book by $namaBuku empty',
              style: GoogleFonts.montserrat(
                color: const Color(0xFF41B54A),
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.2
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
