import 'package:bloc/bloc.dart';
import 'package:garage_app/bloc/garage_bloc/event.dart';
import 'package:garage_app/bloc/garage_bloc/state.dart';
import 'package:garage_app/repository/garage_repository.dart';

class GarageBloc extends Bloc<GarageBlocEvent, GarageBlocState> {
  final GarageRepository repo;

  GarageBloc(this.repo) : super(InitialState());

  @override
  Stream<GarageBlocState> mapEventToState(GarageBlocEvent event) async* {
    if (event is LoadVehiclesEvent) {
      yield LoadVehiclesState();
      try {
        final vehicles = await repo.getOwnedVehicles();
        yield LoadVehiclesSuccessState(vehicles);
      } catch (e) {
        yield LoadVehiclesFailState(e.toString());
      }
    }
  }
}
