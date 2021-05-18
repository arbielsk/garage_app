// Mocks generated by Mockito 5.0.7 from annotations
// in garage_app/test/bloc/garage_bloc/garage_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:garage_app/model/vehicle.dart' as _i4;
import 'package:garage_app/repository/garage_repository.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

/// A class which mocks [GarageRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockGarageRepository extends _i1.Mock implements _i2.GarageRepository {
  MockGarageRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.Vehicle>> getOwnedVehicles() =>
      (super.noSuchMethod(Invocation.method(#getOwnedVehicles, []),
              returnValue: Future<List<_i4.Vehicle>>.value(<_i4.Vehicle>[]))
          as _i3.Future<List<_i4.Vehicle>>);
  @override
  _i3.Future<List<_i4.Vehicle>> addVehicle(_i4.Vehicle? vehicle) =>
      (super.noSuchMethod(Invocation.method(#addVehicle, [vehicle]),
              returnValue: Future<List<_i4.Vehicle>>.value(<_i4.Vehicle>[]))
          as _i3.Future<List<_i4.Vehicle>>);
}
