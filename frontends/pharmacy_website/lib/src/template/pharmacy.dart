import 'package:meta/meta.dart';
import 'package:pharmacy_website/src/components/components.dart';
import 'package:pharmacy_website/src/factories/now.dart';
import 'package:pharmacy_website/src/models/address.dart';
import 'package:pharmacy_website/src/models/pharmacy.dart';
import 'package:pharmacy_website/src/template/common.dart';

class PharmacyHtml extends Component {
  final Pharmacy pharmacy;
  final OpenType openType;
  final NowFactory nowFactory;

  PharmacyHtml({
    @required this.pharmacy,
    this.openType = OpenType.close,
    @required this.nowFactory,
  });

  @override
  String render() {
    return '''<!DOCTYPE html>
<html lang="fr">
${Head(pharmacy: pharmacy).render()}
${Body(pharmacy: pharmacy, openType: openType, nowFactory: nowFactory).render()}
<script async src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAeUORSJnNLi-dEtxJyy8S7ZwFE0cnFdu0&callback=initMap"></script>
<script>
  function initMap() {
    var pharmacyPosition = {
      lat: ${pharmacy.address.coordinates.latitude}, 
      lng: ${pharmacy.address.coordinates.longitude}
    };
    var map = new google.maps.Map(document.querySelector('#map'), {
      center: pharmacyPosition,
      zoom: 17,
      gestureHandling: 'cooperative'
    });
    var marker = new google.maps.Marker({
      position: pharmacyPosition,
      map: map
    });
  }
</script>
</html>''';
  }
}

class Head extends Component {
  final Pharmacy pharmacy;

  Head({@required this.pharmacy});

  @override
  String render() {
    return '''<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="keywords" content="Santetis, Pharmacie, ${pharmacy.name}, ${pharmacy.address.city}" />
  <meta name="description" content="Le site de la ${pharmacy.name} à ${pharmacy.address.city} vous permet de retrouver facilement les horaires, les coordonées et les services proposés par votre pharmacie" />
  <meta itemprop="name" content="Pharmacie du parc" />
  <meta itemprop="description" content="Le site de la ${pharmacy.name} permet à ses clients d'obtenir rapidement ses coordonnées et ses horaires. Le site permet de visualiser les champs de compétence et les service que propose la pharmacie." />
  <meta name="Category" content="Site de pharmacie" />
  <meta name="author" content="Santetis" />
  <meta name="reply-to" content="kevin@santetis.fr" />
  <meta name="robots" content="index, follow" />
  <meta name="googlebot" content="index, follow" />
  <meta name="revisit-after" content="10 days" />
  <meta name="copyright" content="Santetis - Rieumes 31370 - https://santetis.fr" />
  <meta name="theme-color" content="#1FA463">
  
  <title>${pharmacy.name} à ${pharmacy.address.city}</title>
  
  <link rel="preconnect" href="https://maps.gstatic.com/">
  <link rel="preconnect" href="fonts.gstatic.com"/>
  <link rel="preconnect" href="https://fonts.googleapis.com/">
  <link rel="preconnect" href="https://maps.googleapis.com/">
  
  <link rel="stylesheet" href="/css/main.css">
  <link rel="stylesheet" href="/css/pharmacy.css">
  <link rel="stylesheet" media="(min-width: 740px)" href="/css/pharmacy-desktop.css" defer>
  <link rel="stylesheet" media="(max-width: 739px)" href="/css/pharmacy-mobile.css" defer>

  <link href="https://fonts.googleapis.com/icon?family=Material+Icons&display=swap" rel="stylesheet" defer>
</head>''';
  }
}

class Body extends Component {
  final Pharmacy pharmacy;
  final OpenType openType;
  final NowFactory nowFactory;

  Body({
    @required this.pharmacy,
    @required this.nowFactory,
    this.openType = OpenType.close,
  });

  @override
  Component build() {
    return BodyComponent(
      children: [
        TopBar(
          pharmacy: pharmacy,
          openType: openType,
          nowFactory: nowFactory,
        ),
        Content(
          pharmacy: pharmacy,
          openType: openType,
          nowFactory: nowFactory,
        ),
      ],
    );
  }
}

class Content extends Component {
  final Pharmacy pharmacy;
  final OpenType openType;
  final NowFactory nowFactory;

  Content({
    @required this.pharmacy,
    @required this.nowFactory,
    this.openType = OpenType.close,
  });

  @override
  Component build() {
    return DivComponent(
      classes: ['content'],
      children: [
        RowComponent(
          classes: ['page-title-content'],
          children: [
            DivComponent(
              classes: ['flexible-1'],
              children: [
                Title(
                  iconName: 'info_outline',
                  text: 'Informations',
                ),
              ],
            ),
            GoToSchedule(),
          ],
        ),
        ColumnComponent(
          classes: ['mobile-state-container'],
          children: [
            MobileState(
              pharmacy: pharmacy,
              openType: openType,
              nowFactory: nowFactory,
            ),
            GoToSchedule(isMobile: true),
          ],
        ),
        Map(),
        ContactUsCard(
          phone: pharmacy.phone,
          email: pharmacy.email,
          address: pharmacy.address,
        ),
        PracticalInformationsCard(
          acceptAnimals: pharmacy.acceptAnimals,
          childToy: pharmacy.childToy,
          handicapAccess: pharmacy.handicapAccess,
          possibilityToSit: pharmacy.possibilityToSit,
          privateCarPark: pharmacy.privateCarPark,
          wc: pharmacy.wc,
        ),
        SantetisCopyright(),
      ],
    );
  }
}

class GoToSchedule extends Component {
  final bool isMobile;

  GoToSchedule({this.isMobile = false});

  @override
  Component build() {
    return AnchorComponent(
      classes: [
        'no-text-decoration',
        '${isMobile ? 'mobile' : 'desktop'}-go-to-schedule',
        'green-background',
      ],
      href: './horaire/',
      children: [
        RowComponent(
          classes: ['v-center', 'h-center'],
          children: [
            MaterialIconComponent(
              iconName: 'schedule',
              classes: ['horaires-icon-size'],
            ),
            SpanComponent(
              text: 'Horaires',
              classes: ['horaires-style'],
            ),
          ],
        ),
      ],
    );
  }
}

class Map extends Component {
  @override
  Component build() {
    return DivComponent(id: 'map');
  }
}

class PracticalInformationsCard extends Component {
  final bool privateCarPark;
  final bool handicapAccess;
  final bool wc;
  final bool possibilityToSit;
  final bool childToy;
  final bool acceptAnimals;

  PracticalInformationsCard({
    this.privateCarPark = false,
    this.handicapAccess = false,
    this.wc = false,
    this.possibilityToSit = false,
    this.childToy = false,
    this.acceptAnimals = false,
  });

  @override
  Component build() {
    return CardDetail(
      classes: ['practical-informations'],
      label: 'Informations Pratiques',
      children: [
        if (privateCarPark)
          ListItemComponent(
            classes: ['padding-ul-items'],
            children: [
              CardDetailListItem(
                iconName: 'local_parking',
                children: [
                  SpanComponent(
                    classes: ['list-item-text'],
                    text: 'Parking privé',
                  ),
                ],
              ),
            ],
          ),
        if (handicapAccess)
          ListItemComponent(
            classes: ['padding-ul-items'],
            children: [
              CardDetailListItem(
                iconName: 'accessible',
                children: [
                  SpanComponent(
                    classes: ['list-item-text'],
                    text: 'Accès handicapé',
                  ),
                ],
              ),
            ],
          ),
        if (wc)
          ListItemComponent(
            classes: ['padding-ul-items'],
            children: [
              CardDetailListItem(
                iconName: 'wc',
                children: [
                  SpanComponent(
                    classes: ['list-item-text'],
                    text: 'WC',
                  ),
                ],
              ),
            ],
          ),
        if (possibilityToSit)
          ListItemComponent(
            classes: ['padding-ul-items'],
            children: [
              CardDetailListItem(
                iconName: 'airline_seat_recline_normal',
                children: [
                  SpanComponent(
                    classes: ['list-item-text'],
                    text: 'Places assises',
                  ),
                ],
              ),
            ],
          ),
        if (childToy)
          ListItemComponent(
            classes: ['padding-ul-items'],
            children: [
              CardDetailListItem(
                iconName: 'child_care',
                children: [
                  SpanComponent(
                    classes: ['list-item-text'],
                    text: 'Jouet pour enfant',
                  ),
                ],
              ),
            ],
          ),
        if (acceptAnimals)
          ListItemComponent(
            classes: ['padding-ul-items'],
            children: [
              CardDetailListItem(
                iconName: 'pets',
                children: [
                  SpanComponent(
                    classes: ['list-item-text'],
                    text: 'Animaux acceptés',
                  ),
                ],
              ),
            ],
          ),
      ],
    );
  }
}

class ContactUsCard extends Component {
  final String phone;
  final String email;
  final Address address;

  ContactUsCard(
      {@required this.phone, @required this.email, @required this.address});

  @override
  Component build() {
    return CardDetail(
      classes: ['contact-us'],
      label: 'Nous Contacter',
      children: [
        ListItemComponent(
          classes: ['padding-ul-items'],
          children: [
            CardDetailAnchorListItem(
              href: 'tel:$phone',
              iconName: 'phone',
              children: [
                SpanComponent(
                  classes: ['anchor-list-item-text', 'list-item-text'],
                  text: phone,
                ),
              ],
            ),
          ],
        ),
        ListItemComponent(
          classes: ['padding-ul-items'],
          children: [
            CardDetailAnchorListItem(
              href: 'mailto:$email',
              iconName: 'mail',
              children: [
                SpanComponent(
                  classes: ['anchor-list-item-text', 'list-item-text'],
                  text: email,
                ),
              ],
            ),
          ],
        ),
        ListItemComponent(
          classes: ['padding-ul-items'],
          children: [
            CardDetailAnchorListItem(
              href: 'https://maps.google.com/?q=${address.toString()}',
              iconName: 'room',
              children: [
                ColumnComponent(
                  classes: ['anchor-list-item-text', 'list-item-text'],
                  children: [
                    SpanComponent(
                      text: '${address.streetNumber} ${address.streetName}',
                    ),
                    SpanComponent(
                      text: '${address.zipCode} ${address.city}',
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CardDetailAnchorListItem extends Component {
  final String iconName;
  final String href;
  final List<Component> children;

  CardDetailAnchorListItem({this.iconName, this.href, this.children});

  @override
  Component build() {
    return AnchorComponent(
      classes: ['black', 'no-text-decoration'],
      href: href,
      children: [
        CardDetailListItem(iconName: iconName, children: children),
      ],
    );
  }
}

class CardDetailListItem extends Component {
  final String iconName;
  final List<Component> children;

  CardDetailListItem({this.iconName, this.children});

  @override
  Component build() {
    return RowComponent(
      classes: ['v-center'],
      children: [
        MaterialIconComponent(
          iconName: iconName,
          classes: ['icon-list-item'],
        ),
        ...children
      ],
    );
  }
}

class CardDetail extends Component {
  final String label;
  final List<String> classes;
  final List<Component> children;

  CardDetail({this.label, this.children, this.classes});

  @override
  Component build() {
    return SectionComponent(
      classes: classes,
      children: [
        ColumnComponent(
          children: [
            SpanComponent(
              text: label,
              classes: ['section-title'],
            ),
            UnorderedListComponent(
              classes: ['no-ul-decoration', 'no-ul-margin-bottom'],
              children: children,
            )
          ],
        ),
      ],
    );
  }
}
