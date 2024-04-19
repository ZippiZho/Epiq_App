import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../controllers/bookmark_controller.dart';

class BookmarkView extends GetView<BookmarkController> {
  const BookmarkView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          title: InkWell(
            onTap: ()async{
              await controller.getData();
            },
            child: Text(
              'Bookmark',
              style: GoogleFonts.montserrat(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w700
              ),
            ),
          ),
          centerTitle: true,
        ),

        body: RefreshIndicator(
          onRefresh: ()async{
            await controller.getData();
          },
          child: SingleChildScrollView(
            child: SizedBox(
              width: width,
              height: height,
              child: Container(
                margin: const EdgeInsets.only(bottom: 160),
                child: setionBookmark(),
                ),
              ),
            ),
          ),
        );
  }

  Widget setionBookmark() {
    return Obx((){
      if(controller.koleksiBook.isEmpty){
        return sectionDataKosong("Bookmarks");
      }else{
        return ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(), // Biarkan bisa di-scroll
          itemCount: controller.koleksiBook.length,
          itemBuilder: (context, index) {
            var koleksiBook = controller.koleksiBook[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.01)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap:(){
                          Get.toNamed(Routes.DETAILBOOK,
                            parameters: {
                              'id': (koleksiBook.bukuID ?? 0).toString(),
                              'judul': (koleksiBook.judul!).toString()
                            },
                          );
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 125,
                              height: 165,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.40), // Ubah nilai opacity sesuai kebutuhan
                                    BlendMode.darken,
                                  ),
                                  child: AspectRatio(
                                    aspectRatio: 4 / 6,
                                    child: Image.network(
                                      koleksiBook.coverBuku.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 10,
                              left: 5,
                              right: 5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.bookmarks,
                                      color: Colors.white,
                                      size: 18,
                                    ),

                                    const SizedBox(
                                      width: 3,
                                    ),

                                    Expanded(
                                      child: Text(
                                        'Saved',
                                        style: GoogleFonts.montserrat(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.3,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      const SizedBox(
                        width: 10,
                      ),

                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    koleksiBook.judul!,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 24,
                                      color: Colors.black,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Text(
                                    koleksiBook.penulis!,
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: const Color(0xFF41B54A),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Row(
                                    children: [
                                      const SizedBox(
                                        height: 3,
                                      ),

                                      Text(
                                        koleksiBook.rating!.toStringAsFixed(1),
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      const SizedBox(
                                        width: 3,
                                      ),

                                      const Icon(
                                        Icons.star_border_outlined,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Wrap(
                                    children: koleksiBook.kategori!.map((kategori) {
                                      return Padding(
                                        padding: const EdgeInsets.only(right: 2.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(100),
                                            color: const Color(0xFFF5F5F5),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                            child: Text(
                                              kategori,
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.w700,
                                                color: Colors
                                                    .black,
                                                letterSpacing: -0.3,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              width: 5,
                            ),

                            InkWell(
                              onTap: (){
                                controller.deleteKoleksiBook(koleksiBook.bukuID.toString(), context);
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF41B54A),
                                    borderRadius: BorderRadius.circular(100)
                                ),
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    });
  }

  Widget sectionDataKosong(String text){
    const Color background = Colors.black;
    const Color borderColor = Color(0xFF424242);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              color: background.withOpacity(0.95),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: borderColor.withOpacity(0.20),
                width: 0.3,
              )
          ),
          child: Center(
            child: Text(
              'Sorry Data $text Empty!',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
