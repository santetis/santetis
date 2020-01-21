// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_website.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$PharmacyWebsiteRouter(PharmacyWebsite service) {
  final router = Router();
  router.add('GET', r'/ping', service.ping);
  router.add('GET', r'/time', service.time);
  router.add('GET', r'/pharmacy/<pharmacyId>/', service.pharmacy);
  router.add('GET', r'/pharmacy/<pharmacyId>/horaire/', service.schedule);
  router.add('GET', r'/robots.txt', service.robots);
  return router;
}
