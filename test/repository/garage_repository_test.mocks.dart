// Mocks generated by Mockito 5.0.7 from annotations
// in garage_app/test/repository/garage_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:garage_app/data_provider/garage_data_provider.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

/// A class which mocks [GarageDataProvider].
///
/// See the documentation for Mockito's code generation for more information.
class MockGarageDataProvider extends _i1.Mock
    implements _i2.GarageDataProvider {
  MockGarageDataProvider() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<Map<String, dynamic>>> getOwnedVehicles() =>
      (super.noSuchMethod(Invocation.method(#getOwnedVehicles, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i3.Future<List<Map<String, dynamic>>>);
  @override
  _i3.Future<bool> addVehicle(Map<String, dynamic>? vehicle) =>
      (super.noSuchMethod(Invocation.method(#addVehicle, [vehicle]),
          returnValue: Future<bool>.value(false)) as _i3.Future<bool>);
}