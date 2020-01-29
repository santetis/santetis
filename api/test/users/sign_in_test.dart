import 'dart:convert';
import 'dart:io';

import 'package:api/src/api/users/users.dart';
import 'package:api/src/rpcs/tokens/save_token.dart';
import 'package:api/src/rpcs/users/get_user_with_email_and_password.dart';
import 'package:mockito/mockito.dart';
import 'package:network_entities/network_entities.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../mocks/tokens.dart';
import '../mocks/users.dart';

void main() {
  final signInUserRequestFactory = (String email, String password) => Request(
        'post',
        Uri.parse('http://localhost:8080/users/sign_in'),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
        },
        body: json.encode(
          {
            'email': email,
            'password': password,
          },
        ),
      );

  test('sign_in with valid credential', () async {
    final email = 'kevin@santetis.fr';
    final password = 'tete31';
    final getUserWithEmailAndPasswordFromDatabase =
        GetUserWithEmailAndPasswordFromDatabaseMock();
    when(getUserWithEmailAndPasswordFromDatabase.request(any))
        .thenAnswer((_) => [
              {
                'users': {
                  'id': 1,
                  'email': 'kevin@santetis.fr',
                  'password': 'aaa',
                  'account_type': 'admin',
                  'created_on': '2020-01-15T13:56:40.651553Z',
                  'last_login': null,
                }
              }
            ]);
    final getUserWithEmailAndPassword =
        GetUserWithEmailAndPasswordRpc(getUserWithEmailAndPasswordFromDatabase);
    final saveTokenInDatabase = SaveTokenInDatabaseMock();
    final saveTokenRpc = SaveTokenRpc(saveTokenInDatabase);

    final users = Users(
      getUserByEmailRpc: null,
      createUserRpc: null,
      getUserWithEmailAndPasswordRpc: getUserWithEmailAndPassword,
      saveTokenRpc: saveTokenRpc,
      getTokenRpc: null,
      getUserWithTokenRpc: null,
    );
    final response =
        await users.signIn(signInUserRequestFactory(email, password));
    expect(response.statusCode, HttpStatus.ok);
    final body = await response.readAsString();
    final data = SignInResponseData.fromJson(json.decode(body));
    expect(data.token, isNotNull);
  });

  test('sign_in with invalid credential', () async {
    final getUserWithEmailAndPasswordFromDatabase =
        GetUserWithEmailAndPasswordFromDatabaseMock();
    when(getUserWithEmailAndPasswordFromDatabase.request(any))
        .thenAnswer((_) => []);
    final getUserWithEmailAndPassword =
        GetUserWithEmailAndPasswordRpc(getUserWithEmailAndPasswordFromDatabase);
    final saveTokenInDatabase = SaveTokenInDatabaseMock();
    final saveTokenRpc = SaveTokenRpc(saveTokenInDatabase);

    final users = Users(
      getUserByEmailRpc: null,
      createUserRpc: null,
      getUserWithEmailAndPasswordRpc: getUserWithEmailAndPassword,
      saveTokenRpc: saveTokenRpc,
      getTokenRpc: null,
      getUserWithTokenRpc: null,
    );
    final response = await users
        .signIn(signInUserRequestFactory('kevin@santetis.fr', 'tttt'));
    expect(response.statusCode, HttpStatus.notFound);
  });
}
