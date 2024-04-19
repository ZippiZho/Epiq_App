class Endpoint {
  static const String baseUrlApi =
      // "http://192.168.4.134:8000/api/users/";
      "http://192.168.43.21:8000/api/users/";

  // Auth
  static const String register = "${baseUrlApi}registrasi";
  static const String login = "${baseUrlApi}login";
  static const String logout = "${baseUrlApi}login";
  static const String getDataProfile = "${baseUrlApi}get-profile";
  static const String updateProfile = "${baseUrlApi}update/profile";

  // Book
  static const String buku = "${baseUrlApi}buku";
  static const String bukuNew = "${baseUrlApi}buku/new";
  static const String bukuPopular = "${baseUrlApi}popular/buku";
  static const String kategoriBuku = "${baseUrlApi}kategori";
  static const String detailBuku = "${baseUrlApi}buku/detail";
  static const String searchBook = baseUrlApi;
  static const String bukuByKategori = "${baseUrlApi}buku/kategori";

  // Bookmark
  static const String bookmark = "${baseUrlApi}koleksi";
  static const String deleteBookmark = "${baseUrlApi}";

  // Ulasan Buku
  static const String ulasanBuku = "${baseUrlApi}ulasan";

  // Peminjaman
  static const String pinjamBuku = "${baseUrlApi}pinjam";
  static const String detailPeminjaman = "${baseUrlApi}detail/pinjam";
}