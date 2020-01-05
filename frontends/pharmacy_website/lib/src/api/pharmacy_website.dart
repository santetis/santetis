import 'dart:io';

import 'package:pharmacy_website/src/template/schedule.dart';
import 'package:pharmacy_website/src/template/pharmacy.dart';
import 'package:pharmacy_website/src/template/common.dart';
import 'package:pharmacy_website/src/pharmacies/pharmacie_du_parc_31.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

part 'pharmacy_website.g.dart';

class PharmacyWebsite {
  @Route.get('/ping')
  Response ping(Request request) {
    return Response.ok('pong');
  }

  @Route.get('/time')
  Response time(Request request) {
    final now = DateTime.now();
    return Response.ok(
        '${now} timezone infos ${now.timeZoneName}, ${now.timeZoneOffset} utc ${now.toUtc()}');
  }

  @Route.get('/pharmacy/<pharmacyId>/')
  Future<Response> pharmacy(Request request, String pharmacyId) async {
    if (pharmacyId == 'pharmacieduparc31') {
      final openType = getOpenType(pharmacieDuParc31);
      final home =
          PharmacyHtml(pharmacy: pharmacieDuParc31, openType: openType);
      return Response.ok(
        home.render(),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.html.toString(),
        },
      );
    }
    return Response.notFound('');
  }

  @Route.get('/pharmacy/<pharmacyId>/horaire/')
  Future<Response> schedule(Request request, String pharmacyId) async {
    if (pharmacyId == 'pharmacieduparc31') {
      final openType = getOpenType(pharmacieDuParc31);
      final schedule =
          ScheduleHtml(pharmacy: pharmacieDuParc31, openType: openType);
      return Response.ok(
        schedule.render(),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.html.toString(),
        },
      );
    }
    return Response.notFound('');
  }

  Router get router => _$PharmacyWebsiteRouter(this);
}
