import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:garage_app/model/vehicle_state.dart';

part 'vehicle_bloc_state.freezed.dart';

@freezed
class VehicleStateBloc with _$VehicleStateBloc {
  const factory VehicleStateBloc.initial() = VehicleStateInitial;
  const factory VehicleStateBloc.load() = VehicleStateLoad;
  const factory VehicleStateBloc.loaded({required VehicleState vehicleState}) =
      VehicleStateLoaded;
  const factory VehicleStateBloc.failed({required String error}) =
      VehicleStateFailed;
}
