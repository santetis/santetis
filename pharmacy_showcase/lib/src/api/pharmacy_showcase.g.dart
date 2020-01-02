// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pharmacy_showcase.dart';

// **************************************************************************
// ShelfRouterGenerator
// **************************************************************************

Router _$PharmacyShowcaseRouter(PharmacyShowcase service) {
  final router = Router();
  router.add('GET', r'/ping', service.ping);
  router.add('GET', r'/time', service.time);
  router.add('GET', r'/pharmacy/<pharmacyId>', service.pharmacy);
  return router;
}
