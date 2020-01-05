class Coordinates {
  final double longitude;
  final double latitude;

  Coordinates({this.longitude, this.latitude});
}

class Address {
  final int streetNumber;
  final String streetName;
  final String zipCode;
  final String city;
  final Coordinates coordinates;

  Address({
    this.streetNumber,
    this.streetName,
    this.zipCode,
    this.city,
    this.coordinates,
  });

  @override
  String toString() => '$streetNumber $streetName $zipCode $city';
}
