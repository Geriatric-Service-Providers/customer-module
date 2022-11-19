import 'package:get/state_manager.dart';
import 'package:shopx/services/remote_services.dart';

class DashboardController extends GetxController {
  var isLoading = true.obs;
  var serviceProviders = [].obs;

  @override
  void onInit() {
    dashboard();
    super.onInit();
  }

  void dashboard() async {
    try {
      isLoading(true);
      var providers = await RemoteServices.fetchOrganization();
      if (providers != null) {
        serviceProviders.value = providers;
      }
    } finally {
      isLoading(false);
    }
  }
}

class MemberController extends GetxController {
  var isLoading = true.obs;
  var serviceProviders = [].obs;

  @override
  void onInit() {
    members();
    super.onInit();
  }

  void members() async {
    try {
      isLoading(true);
      var providers = await RemoteServices.fetchOrganizationMembers();
      if (providers != null) {
        serviceProviders.value = providers;
      }
    } finally {
      isLoading(false);
    }
  }
}
