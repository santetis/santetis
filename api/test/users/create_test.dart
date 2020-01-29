import 'dart:convert';
import 'dart:io';

import 'package:api/src/api/users/users.dart';
import 'package:api/src/rpcs/tokens/get_token.dart';
import 'package:api/src/rpcs/users/create_user.dart';
import 'package:api/src/rpcs/users/get_user_by_email.dart';
import 'package:api/src/rpcs/users/get_user_from_token.dart';
import 'package:mockito/mockito.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../mocks/tokens.dart';
import '../mocks/users.dart';

void main() {
  final createUserRequestFactory =
      ({Map<String, dynamic> data, String authorization}) => Request(
            'post',
            Uri.parse('http://localhost:8080/users/'),
            headers: {
              if (authorization != null)
                HttpHeaders.authorizationHeader: authorization,
              HttpHeaders.contentTypeHeader: ContentType.json.toString(),
            },
            body: json.encode(data),
          );

  final validCreateUserRequestFactory =
      ({String authorization}) => createUserRequestFactory(
            data: {
              'email': 'kevin@santetis.fr',
              'password': 'tata31',
              'account_type': 'admin'
            },
            authorization: authorization,
          );

  Users provisionEveryThings({
    List<Map<String, dynamic>> getTokenFromDatabaseData,
    List<Map<String, dynamic>> getUserWithTokenFromDatabaseData,
    List<Map<String, dynamic>> getUserByEmailFromDatabaseData,
  }) {
    final getTokenFromDatabase = GetTokenFromDatabaseMock();
    when(getTokenFromDatabase.request(any)).thenAnswer(
      (_) async => getTokenFromDatabaseData,
    );
    final getUserWithTokenFromDatabase = GetUserWithTokenFromDatabaseMock();
    when(getUserWithTokenFromDatabase.request(any)).thenAnswer(
      (_) async => getUserWithTokenFromDatabaseData,
    );

    final getUserByEmailFromDatabase = GetUserByEmailFromDatabaseMock();
    when(getUserByEmailFromDatabase.request(any)).thenAnswer(
      (_) async => getUserByEmailFromDatabaseData,
    );

    final createUserInDatabase = CreateUserInDatabaseMock();

    final getTokenRpc = GetTokenRpc(getTokenFromDatabase);
    final getUserWithTokenRpc =
        GetUserWithTokenRpc(getUserWithTokenFromDatabase);
    final getUserByEmailRpc = GetUserByEmailRpc(getUserByEmailFromDatabase);
    final createUserRpc = CreateUserRpc(createUserInDatabase);

    final users = Users(
      getUserByEmailRpc: getUserByEmailRpc,
      createUserRpc: createUserRpc,
      getUserWithEmailAndPasswordRpc: null,
      saveTokenRpc: null,
      getTokenRpc: getTokenRpc,
      getUserWithTokenRpc: getUserWithTokenRpc,
    );
    return users;
  }

  test('create', () async {
    final users = provisionEveryThings(
      getTokenFromDatabaseData: [
        {
          'tokens': {'user_id': 1, 'token': 'toto'}
        }
      ],
      getUserWithTokenFromDatabaseData: [
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
      getUserByEmailFromDatabaseData: [],
    );
    final response = await users
        .createUser(validCreateUserRequestFactory(authorization: 'tata'));
    expect(response.statusCode, HttpStatus.created);
  });

  test('create with no authorization', () async {
    final users = provisionEveryThings(
      getTokenFromDatabaseData: [],
      getUserWithTokenFromDatabaseData: [],
      getUserByEmailFromDatabaseData: [],
    );
    final response = await users.createUser(validCreateUserRequestFactory());
    expect(response.statusCode, HttpStatus.badRequest);
    expect(json.decode(await response.readAsString())['error'],
        'AUTHORIZATION_HEADER_NEEDED');
  });

  test('create with bad token', () async {
    final users = provisionEveryThings(
      getTokenFromDatabaseData: [],
      getUserWithTokenFromDatabaseData: [],
      getUserByEmailFromDatabaseData: [],
    );
    final response = await users
        .createUser(validCreateUserRequestFactory(authorization: 'toto'));
    expect(response.statusCode, HttpStatus.unauthorized);
    expect(json.decode(await response.readAsString())['error'], 'UNAUTHORIZED');
  });

  test('create with good token but not linked to user', () async {
    final users = provisionEveryThings(
      getTokenFromDatabaseData: [
        {
          'tokens': {'user_id': 1, 'token': 'toto'}
        }
      ],
      getUserWithTokenFromDatabaseData: [],
      getUserByEmailFromDatabaseData: [],
    );
    final response = await users
        .createUser(validCreateUserRequestFactory(authorization: 'toto'));
    expect(response.statusCode, HttpStatus.notFound);
    expect(
        json.decode(await response.readAsString())['error'], 'USER_NOT_FOUND');
  });

  test('create with user not admin', () async {
    final users = provisionEveryThings(
      getTokenFromDatabaseData: [
        {
          'tokens': {'user_id': 1, 'token': 'toto'}
        }
      ],
      getUserWithTokenFromDatabaseData: [
        {
          'users': {
            'id': 1,
            'email': 'kevin@santetis.fr',
            'password': 'aaa',
            'account_type': 'doctor',
            'created_on': '2020-01-15T14:12:04.986459Z',
            'last_login': null
          }
        }
      ],
      getUserByEmailFromDatabaseData: [],
    );
    final response = await users
        .createUser(validCreateUserRequestFactory(authorization: 'toto'));
    expect(response.statusCode, HttpStatus.unauthorized);
    expect(json.decode(await response.readAsString())['error'], 'NOT_AN_ADMIN');
  });

  test('create with user already exist', () async {
    final users = provisionEveryThings(
      getTokenFromDatabaseData: [
        {
          'tokens': {'user_id': 1, 'token': 'toto'}
        }
      ],
      getUserWithTokenFromDatabaseData: [
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
      getUserByEmailFromDatabaseData: [
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
    final response = await users
        .createUser(validCreateUserRequestFactory(authorization: 'toto'));
    expect(response.statusCode, HttpStatus.conflict);
    expect(json.decode(await response.readAsString())['error'],
        'USER_ALREADY_EXIST');
  });

  test('create with missing arguments', () async {
    final users = provisionEveryThings(
      getTokenFromDatabaseData: [
        {
          'tokens': {'user_id': 1, 'token': 'toto'}
        }
      ],
      getUserWithTokenFromDatabaseData: [
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
      getUserByEmailFromDatabaseData: [],
    );
    final response = await users
        .createUser(createUserRequestFactory(authorization: 'toto', data: {}));
    expect(response.statusCode, HttpStatus.badRequest);
    final data = json.decode(await response.readAsString());
    expect(data['error'], 'BAD_ARGUMENTS');
    expect(data['value'], ['email', 'password', 'account_type']);
  });
}
