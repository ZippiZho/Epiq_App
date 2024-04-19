import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../components/customSearchBar.dart';
import '../../../routes/app_pages.dart';
import '../controllers/searchbook_controller.dart';

class SearchbookView extends GetView<SearchbookController> {
  const SearchbookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double appBarHeight = AppBar().preferredSize.height;
    double bodyHeight = height - appBarHeight;

    return Scaffold(
        appBar: AppBar(
          titleSpacing: -5,
          flexibleSpace: const SizedBox(
            width: 100,
          ),
          toolbarHeight: 50,
          title: Text(
            'Search Book',
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
                borderRadius: BorderRadius.circular(10)),
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
            onRefresh: () async {
              await controller.getDataAllBuku();
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [

                    CustomSearchBar(
                      controller: controller.searchController,
                      onFocus: true,
                      onChanged: (value){
                        controller.getDataAllBuku();
                      },
                      preficIcon: const Icon(Icons.search_rounded),
                      hinText: "Search a Book Name",
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    kontenDataBook(),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  // Widget kontenSemuaBuku() {
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //       crossAxisCount: 2,
  //       crossAxisSpacing: 10.0,
  //       mainAxisSpacing: 10.0,
  //       childAspectRatio: 3 / 6.7,
  //     ),
  //     itemCount: controller.searchBook.length,
  //     itemBuilder: (context, index) {
  //       var buku = controller.searchBook[index];
  //       return Container(
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(10),
  //           border: Border.all(
  //             color: const Color(0xFF000000).withOpacity(0.10),
  //             width: 1,
  //           ),
  //         ),
  //         child: InkWell(
  //           onTap: () {
  //             Get.toNamed(Routes.DETAILBOOK,
  //               parameters: {
  //                 'id': (buku.bukuID ?? 0).toString(),
  //                 'judul': (buku.judul!).toString()
  //               },
  //             );
  //           },
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               SizedBox(
  //                 width: double.infinity,
  //                 child: Image.network(
  //                   buku.coverBuku.toString(),
  //                   fit: BoxFit.fitHeight,
  //                 ),
  //               ),
  //               Expanded(
  //                 child: Padding(
  //                   padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
  //                   child: Column(
  //                     mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Text(
  //                         buku.judul!,
  //                         maxLines: 2,
  //                         style: GoogleFonts.inter(
  //                           fontWeight: FontWeight.w700,
  //                           color: const Color(0xFF5000CA),
  //                           fontSize: 18.0,
  //                         ),
  //                         textAlign: TextAlign.start,
  //                         overflow: TextOverflow.ellipsis,
  //                       ),
  //
  //                       const SizedBox(
  //                         height: 5,
  //                       ),
  //
  //                       FittedBox(
  //                         child: Text(
  //                           "Penulis: ${buku.penulis!}",
  //                           maxLines: 1,
  //                           style: GoogleFonts.inter(
  //                             fontWeight: FontWeight.w700,
  //                             color: Colors.black,
  //                             fontSize: 10.0,
  //                           ),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //
  //                       const SizedBox(
  //                         height: 5,
  //                       ),
  //
  //                       FittedBox(
  //                         child: Text(
  //                           "${ buku.jumlahHalaman!} Halaman",
  //                           maxLines : 1,
  //                           style: GoogleFonts.inter(
  //                             fontWeight: FontWeight.w800,
  //                             color: Colors.black,
  //                             fontSize: 12.0,
  //                           ),
  //                           textAlign: TextAlign.center,
  //                         ),
  //                       ),
  //
  //                       const SizedBox(
  //                         height: 5,
  //                       ),
  //
  //                       // Menampilkan rating di bawah teks penulis
  //                       buku.rating != null && buku.rating! > 0
  //                           ? RatingBarIndicator(
  //                         direction: Axis.horizontal,
  //                         rating: buku.rating!,
  //                         itemCount: 5,
  //                         itemSize: 15,
  //                         itemBuilder: (context, _) => const Icon(
  //                           Icons.star,
  //                           color: Color(0xFF5000CA),
  //                         ),
  //                       )
  //                           : RatingBarIndicator(
  //                         direction: Axis.horizontal,
  //                         rating: buku.rating!,
  //                         itemCount: 5,
  //                         itemSize: 15,
  //                         itemBuilder: (context, _) => const Icon(
  //                           Icons.star,
  //                           color: Colors.grey,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  
  Widget kontenDataBook() {
    return Obx(() {
      if (controller.searchBook.isEmpty) {
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
          itemCount: controller.searchBook.length,
          itemBuilder: (context, index) {
            var buku = controller.searchBook[index];

            return InkWell(
              onTap: () {
                Get.toNamed(
                  Routes.DETAILBOOK,
                  parameters: {
                    'id': (buku.bukuID ?? 0).toString(),
                    'judul': (buku.judul ?? '').toString(),
                  },
                );
              },
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.30),
                          BlendMode.darken,
                        ),
                        child: Image.network(
                          buku.coverBuku ?? '', // Ensure coverBuku is not null
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  if (buku.status == "Popular")
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
                            const SizedBox(width: 3),
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
                    ),
                ],
              ),
            );
          },
        );
      }
    });
  }

  Widget kontenDataKosong() {
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
                  letterSpacing: -0.2),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
