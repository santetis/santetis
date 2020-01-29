import 'dart:convert';
import 'dart:io';

import 'package:api/src/api/users/users.dart';
import 'package:api/src/rpcs/tokens/get_token.dart';
import 'package:api/src/rpcs/users/get_user_from_token.dart';
import 'package:mockito/mockito.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../mocks/tokens.dart';
import '../mocks/users.dart';

void main() {
  final getUserRequestFactory = (String authorizaion) => Request(
        'get',
        Uri.parse('http://localhost:8080/users/'),
        headers: {
          HttpHeaders.contentTypeHeader: ContentType.json.toString(),
          if (authorizaion?.isNotEmpty == true)
            HttpHeaders.authorizationHeader: authorizaion
        },
      );

  test('get me', () async {
    final getTokenFromDatabase = GetTokenFromDatabaseMock();
    when(getTokenFromDatabase.request(any)).thenAnswer(
      (_) async => [
        {
          'tokens': {'user_id': 1, 'token': 'toto'}
        }
      ],
    );
    final getUserWithTokenFromDatabase = GetUserWithTokenFromDatabaseMock();
    when(getUserWithTokenFromDatabase.request(any)).thenAnswer(
      (_) async => [
        {
          'users': {
            'id': 1,
            'email': 'kevin@santetis.fr',
            'password': 'aaa',
            'account_type': 'admin',
            'created_on': '2020-01-15T14:12:04.986459Z',
            'last_login': null
          }
        }
      ],
    );

    final getTokenRpc = GetTokenRpc(getTokenFromDatabase);
    final getUserWithTokenRpc =
        GetUserWithTokenRpc(getUserWithTokenFromDatabase);

    final users = Users(
      getUserByEmailRpc: null,
      createUserRpc: null,
      getUserWithEmailAndPasswordRpc: null,
      saveTokenRpc: null,
      getTokenRpc: getTokenRpc,
      getUserWithTokenRpc: getUserWithTokenRpc,
    );

    final response = await users.getMe(getUserRequestFactory('toto'));
    expect(response.statusCode, HttpStatus.ok);
  });

  test('no credential', () async {
    final getTokenFromDatabase = GetTokenFromDatabaseMock();
    final getUserWithTokenFromDatabase = GetUserWithTokenFromDatabaseMock();
    final getTokenRpc = GetTokenRpc(getTokenFromDatabase);
    final getUserWithTokenRpc =
        GetUserWithTokenRpc(getUserWithTokenFromDatabase);

    final users = Users(
      getUserByEmailRpc: null,
      createUserRpc: null,
      getUserWithEmailAndPasswordRpc: null,
      saveTokenRpc: null,
      getTokenRpc: getTokenRpc,
      getUserWithTokenRpc: getUserWithTokenRpc,
    );

    final response = await users.getMe(getUserRequestFactory(null));
    expect(response.statusCode, HttpStatus.badRequest);
    expect(json.decode(await response.readAsString())['error'],
        'AUTHORIZATION_HEADER_NEEDED');
  });

  test('bad token', () async {
    final getTokenFromDatabase = GetTokenFromDatabaseMock();
    when(getTokenFromDatabase.request(any)).thenAnswer((_) async => []);

    final getUserWithTokenFromDatabase = GetUserWithTokenFromDatabaseMock();
    final getTokenRpc = GetTokenRpc(getTokenFromDatabase);
    final getUserWithTokenRpc =
        GetUserWithTokenRpc(getUserWithTokenFromDatabase);

    final users = Users(
      getUserByEmailRpc: null,
      createUserRpc: null,
      getUserWithEmailAndPasswordRpc: null,
      saveTokenRpc: null,
      getTokenRpc: getTokenRpc,
      getUserWithTokenRpc: getUserWithTokenRpc,
    );

    final response = await users.getMe(getUserRequestFactory('toto'));
    expect(response.statusCode, HttpStatus.unauthorized);
    expect(json.decode(await response.readAsString())['error'], 'UNAUTHORIZED');
  });

  test('user not found', () async {
    final getTokenFromDatabase = GetTokenFromDatabaseMock();
    when(getTokenFromDatabase.request(any)).thenAnswer(
      (_) async => [
        {
          'tokens': {'user_id': 1, 'token': 'toto'}
        }
      ],
    );

    final getUserWithTokenFromDatabase = GetUserWithTokenFromDatabaseMock();
    when(getUserWithTokenFromDatabase.request(any)).thenAnswer(
      (_) async => [],
    );

    final getTokenRpc = GetTokenRpc(getTokenFromDatabase);
    final getUserWithTokenRpc =
        GetUserWithTokenRpc(getUserWithTokenFromDatabase);

    final users = Users(
      getUserByEmailRpc: null,
      createUserRpc: null,
      getUserWithEmailAndPasswordRpc: null,
      saveTokenRpc: null,
      getTokenRpc: getTokenRpc,
      getUserWithTokenRpc: getUserWithTokenRpc,
    );

    final response = await users.getMe(getUserRequestFactory('toto'));
    expect(response.statusCode, HttpStatus.notFound);
    expect(
        json.decode(await response.readAsString())['error'], 'USER_NOT_FOUND');
  });
}
