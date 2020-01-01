import 'package:meta/meta.dart';
import 'package:pharmacy_showcase/src/models/pharmacy.dart';
import 'package:pharmacy_showcase/src/template/component.dart';

class HtmlComponent extends Component {
  final Pharmacy pharmacy;

  HtmlComponent({@required this.pharmacy});

  @override
  String render() {
    return '''<!DOCTYPE html>
<html>
${HeadComponent(pharmacy: pharmacy).render()}
${BodyComponent(pharmacy: pharmacy).render()}
<script defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAeUORSJnNLi-dEtxJyy8S7ZwFE0cnFdu0&callback=initMap"></script>
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

class HeadComponent extends Component {
  final Pharmacy pharmacy;

  HeadComponent({@required this.pharmacy});

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
  
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

  <link rel="stylesheet" href="/css/main.css">
  <link rel="stylesheet" href="/css/pharmacy.css">
</head>''';
  }
}

class BodyComponent extends Component {
  final Pharmacy pharmacy;

  BodyComponent({@required this.pharmacy});

  @override
  String render() {
    return '''<body>
  ${TopBarComponent(pharmacy: pharmacy).render()}
  ${InformationsComponent().render()}
  ${DetailsAndMapComponent(pharmacy: pharmacy).render()}
</body>''';
  }
}

class TopBarComponent extends Component {
  final Pharmacy pharmacy;

  TopBarComponent({@required this.pharmacy});

  @override
  String render() {
    return DivComponent(
      classes: ['top-bar'],
      children: [
        DivComponent(
          classes: ['center-top-bar-content'],
          children: [
            SpanComponent(
              text: pharmacy.name,
              classes: ['grey', 'pharmacy-name'],
            ),
          ],
        ),
      ],
    ).render();
  }
}

class InformationsComponent extends Component {
  @override
  String render() {
    return DivComponent(
      classes: ['center-informations-content'],
      children: [
        RowComponent(
          classes: ['informations', 'v-center'],
          children: [
            MaterialIconComponent(
              iconName: 'info_outline',
              classes: ['informations-icon-size'],
            ),
            SpanComponent(
              text: 'Informations',
              classes: ['informations-style'],
            ),
          ],
        )
      ],
    ).render();
  }
}

class DetailsAndMapComponent extends Component {
  final Pharmacy pharmacy;

  DetailsAndMapComponent({@required this.pharmacy});

  @override
  String render() {
    return DivComponent(
      classes: ['center-details-and-map'],
      children: [
        ColumnComponent(
          children: [
            MapComponent(),
            DetailsComponent(pharmacy: pharmacy),
          ],
        ),
      ],
    ).render();
  }
}

class MapComponent extends Component {
  @override
  String render() {
    return DivComponent(id: 'map').render();
  }
}

class DetailsComponent extends Component {
  final Pharmacy pharmacy;

  DetailsComponent({@required this.pharmacy});

  @override
  String render() {
    return RowComponent(
      classes: ['test'],
      children: [
        SectionComponent(
          children: [
            ColumnComponent(
              children: [
                SpanComponent(
                  text: 'Nous contacter',
                  classes: ['section-title'],
                ),
                UnorderedComponent(
                  classes: ['no-ul-decoration'],
                  children: [
                    ListItemComponent(
                      classes: ['padding-ul-items'],
                      children: [
                        AnchorComponent(
                          classes: ['black', 'no-text-decoration'],
                          href: 'tel:${pharmacy.phone}',
                          children: [
                            RowComponent(
                              classes: ['v-center'],
                              children: [
                                MaterialIconComponent(
                                  iconName: 'phone',
                                  classes: ['icon-padding-right'],
                                ),
                                SpanComponent(
                                    classes: ['list-item-text'],
                                    text: pharmacy.phone)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    ListItemComponent(
                      classes: ['padding-ul-items'],
                      children: [
                        AnchorComponent(
                          classes: ['black', 'no-text-decoration'],
                          href: 'mailto:${pharmacy.email}',
                          children: [
                            RowComponent(
                              classes: ['v-center'],
                              children: [
                                MaterialIconComponent(
                                  iconName: 'mail',
                                  classes: ['icon-padding-right'],
                                ),
                                SpanComponent(
                                    classes: ['list-item-text'],
                                    text: pharmacy.email)
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    ListItemComponent(
                      classes: ['padding-ul-items'],
                      children: [
                        AnchorComponent(
                          classes: ['black', 'no-text-decoration'],
                          href:
                              'https://maps.google.com/?q=${pharmacy.address.toString()}',
                          children: [
                            RowComponent(
                              classes: ['v-center'],
                              children: [
                                MaterialIconComponent(
                                  iconName: 'room',
                                  classes: ['icon-padding-right'],
                                ),
                                ColumnComponent(
                                  classes: ['list-item-text'],
                                  children: [
                                    SpanComponent(
                                      text:
                                          '${pharmacy.address.streetNumber} ${pharmacy.address.streetName}',
                                    ),
                                    SpanComponent(
                                      text:
                                          '${pharmacy.address.zipCode} ${pharmacy.address.city}',
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        SectionComponent(
          children: [
            ColumnComponent(
              children: [
                SpanComponent(
                  text: 'Informations Pratiques',
                  classes: ['section-title'],
                ),
              ],
            ),
          ],
        ),
      ],
    ).render();
  }
}
