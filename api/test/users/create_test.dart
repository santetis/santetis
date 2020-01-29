import 'dart:convert';
import 'dart:io';

import 'package:api/src/api/users/users.dart';
import 'package:api/src/rpcs/users/create_user.dart';
import 'package:api/src/rpcs/users/get_user_by_email.dart';
import 'package:mockito/mockito.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../mocks/users.dart';

void main() {
  final createUserRequestFactory = () => Request(
        'post',
        Uri.parse('http://localhost:8080/users/'),
        headers: {
          HttpHeaders.authorizationHeader: '1234',
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        },
        body: json.encode(
          {
            'email': 'kevin@santetis.fr',
            'password': 'tata31',
          },
        ),
      );

  test('create', () async {
    final getUserByEmailFromDatabase = GetUserByEmailFromDatabaseMock();
    when(getUserByEmailFromDatabase.request(any)).thenAnswer((_) => []);
    final getUserByEmail = GetUserByEmailRpc(getUserByEmailFromDatabase);

    final createUserInDatabase = CreateUserInDatabaseMock();
    final createUser = CreateUserRpc(createUserInDatabase);

    final users = Users(
      getUserByEmailRpc: getUserByEmail,
      createUserRpc: createUser,
      getUserWithEmailAndPasswordRpc: null,
      saveTokenRpc: null,
      getTokenRpc: null,
      getUserWithTokenRpc: null,
    );
    final response = await users.createUser(createUserRequestFactory());
    expect(response.statusCode, HttpStatus.notImplemented);
  });
}
