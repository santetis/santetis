import 'dart:io';

import 'package:pharmacy_showcase/src/models/address.dart';
import 'package:pharmacy_showcase/src/models/pharmacy.dart';
import 'package:pharmacy_showcase/src/template/pharmacy.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'pharmacy_showcase.g.dart';

class PharmacyShowcase {
  @Route.get('/pharmacy/<pharmacyId>')
  Future<Response> pharmacy(Request request, String pharmacyId) async {
    //  todo: get data from database
    if (pharmacyId == 'pharmacieduparc31') {
      final pharmacy = Pharmacy(
        '',
        'Pharmacie du parc',
        Address(
          64,
          'Avenue tolosane',
          '31520',
          'Ramonville-Saint-Agne',
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
