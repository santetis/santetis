import 'dart:io';

import 'package:pharmacy_showcase/src/models/address.dart';
import 'package:pharmacy_showcase/src/models/pharmacy.dart';
import 'package:pharmacy_showcase/src/template/pharmacy.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'pharmacy_showcase.g.dart';

class PharmacyShowcase {
  @Route.get('/ping')
  Response ping(Request request) {
    return Response.ok('pong');
  }

  @Route.get('/pharmacy/<pharmacyId>')
  Future<Response> pharmacy(Request request, String pharmacyId) async {
    //  todo: get data from database
    if (pharmacyId == 'pharmacieduparc31') {
      final pharmacy = Pharmacy(
        domainName: 'pharmaciduparc31',
        name: 'Pharmacie du parc',
        phone: '0561733157',
        email: 'leparc31@gmail.com',
        address: Address(
          streetNumber: 63,
          streetName: 'Avenue tolosane',
          zipCode: '31520',
          city: 'Ramonville-Saint-Agne',
          coordinates: Coordinates(
            latitude: 43.546812,
            longitude: 1.4734,
          ),
        ),
      );
      final home = HtmlComponent(pharmacy: pharmacy);
      return Response.ok(
        home.render(),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.html.toString(),
        },
      );
    }
    return Response.notFound('');
  }

  Router get router => _$PharmacyShowcaseRouter(this);
}
