import 'package:haidai_flutter_module/page/customer/model/store_customer_list_item_do_entity.dart';


class FilterCustomerModel {

  int count = 0;
  StoreCustomerListItemDoEntity? customer;

  FilterCustomerModel.all(int id, String name, int count) {
    this.customer = StoreCustomerListItemDoEntity();
    this.customer!.customerName = name;
    this.customer!.id = id;
    this.count = count;
  }

  FilterCustomerModel(this.customer);

  addCount() {
    count++;
  }

  bool isCurrCustomer(int? id) => id == customer?.id;

}