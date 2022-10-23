import 'package:get/state_manager.dart';
import 'package:shopx/services/remote_services.dart';
import 'package:shopx/views/globals.dart';

class CategoryController extends GetxController {
  var isLoading = true.obs;
  var productList = [].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  void fetchCategories() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchCategories();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}

class BannerController extends GetxController {
  var isLoading = true.obs;
  var productList = [].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void fetchBanners() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchBanner();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}

class BannerProductController extends GetxController {
  var isLoading = true.obs;
  var productList = [].obs;

  @override
  void onInit() {
    fetchBannerProducts();
    super.onInit();
  }

  void fetchBannerProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchBannerProducts();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}

class SubCategoryController extends GetxController {
  var isLoading = true.obs;
  var productList = [].obs;

  @override
  void onInit() {
    fetchSubCategories(Globals.primary);
    super.onInit();
  }

  void fetchSubCategories(id) async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchSubCategories(id);
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}

class ProductController extends GetxController {
  var isLoading = true.obs;
  var productList = [].obs;

  @override
  void onInit() {
    fetchProducts(Globals.primary);
    super.onInit();
  }

  void fetchProducts(id) async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchProducts(id);
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}

class CartController extends GetxController {
  var isLoading = true.obs;
  var productList = [].obs;

  @override
  void onInit() {
    fetchCartProducts();
    super.onInit();
  }

  void fetchCartProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchCartProducts();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}

class Controller extends GetxController {
  var total = double.parse(Globals.cartotal).obs;
  increment(value) {
    total += value;
  }

  decrement(value) {
    total -= value;
  }

  getVal() {
    total.value = double.parse(Globals.cartotal);
  }
}

class SearchController extends GetxController {
  var isLoading = true.obs;
  var productList = [].obs;

  @override
  void onInit() {
    fetchSearchProducts();
    super.onInit();
  }

  void fetchSearchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServices.fetchSearchProducts();
      if (products != null) {
        productList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}

class PrevOrderController extends GetxController {
  var isLoading = true.obs;
  var orderList = [].obs;

  @override
  void onInit() {
    fetchPrevOrders();
    super.onInit();
  }

  void fetchPrevOrders() async {
    try {
      isLoading(true);
      var orders = await RemoteServices.fetchPrevOrders();
      if (orders != null) {
        orderList.value = orders;
      }
    } finally {
      isLoading(false);
    }
  }
}
