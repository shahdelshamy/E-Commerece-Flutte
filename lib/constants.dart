class ApiConfig {
  static const String baseUrl = 'https://student.valuxapps.com/api/';

  // Endpoints
  static const String registerEndPoint = 'register';          // POST
  static const String loginEndPoint = 'login';                // POST
  static const String profileEndPoint = 'profile';            // GET
  static const String bannerEndPoint = 'banners';             // GET
  static const String categoryEndPoint = 'categories';        // GET
  static const String productEndPoint = 'home';               // GET
  static const String favoriteEndPoint = 'favorites';         // GET
  // static const String addFavoriteEndPoint = 'favorites';    // POST (Commented out as it seems redundant)
  static const String cartEndPoint = 'carts';                 // POST/GET
  static const String changePasswordEndPoint = 'change-password'; // POST
  static const String changeDataEndPoint = 'update-profile';  // PUT/POST


  // Shared preferences related (static variables)
  static String tokenForSharedPref = '';
  static String imagePath = '';
// static const String imageSharedPref = 'https://student.valuxapps.com/storage/assets/defaults/user.jpg'; // (Commented out)
}
