import 'package:pharmacy_showcase/src/models/address.dart';

class Pharmacy {
  final String domainName;
  final String name;
  final Address address;
  final String phone;
  final String email;

  Pharmacy({
    this.domainName,
    this.name,
    this.address,
    this.phone,
    this.email,
  });
}
