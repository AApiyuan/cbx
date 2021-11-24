import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:haidai_flutter_module/widget/refresh_header.dart';
import 'package:haidai_flutter_module/widget/refresh_footer.dart';

class RefreshUtils {
  static Header defaultHeader() {
    return RefreshHeader();
  }

  static Footer defaultFooter() {
    return RefreshFooter();
  }
}
