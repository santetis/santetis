import 'package:api/src/rpcs/tokens/get_token.dart';
import 'package:api/src/rpcs/tokens/save_token.dart';
import 'package:mockito/mockito.dart';

class SaveTokenInDatabaseMock extends Mock implements SaveTokenInDatabase {}

class GetTokenFromDatabaseMock extends Mock implements GetTokenFromDatabase {}
