import 'package:api/src/rpcs/users/create_user.dart';
import 'package:api/src/rpcs/users/get_user_by_email.dart';
import 'package:api/src/rpcs/users/get_user_with_email_and_password.dart';
import 'package:mockito/mockito.dart';

class GetUserByEmailFromDatabaseMock extends Mock
    implements GetUserByEmailFromDatabase {}

class CreateUserInDatabaseMock extends Mock implements CreateUserInDatabase {}

class GetUserWithEmailAndPasswordFromDatabaseMock extends Mock
    implements GetUserWithEmailAndPasswordFromDatabase {}
