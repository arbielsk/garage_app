import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:garage_app/bloc/garage_bloc/bloc.dart';
import 'package:garage_app/data_provider/local_garage_data_provider.dart';
import 'package:garage_app/repository/garage_repository.dart';
import 'package:garage_app/widget/garage_screen.dart';

class GarageRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final dataProvider = LocalGarageDataProvider();
        final repo = GarageRepository(dataProvider);
        return GarageBloc(repo);
      },
      child: GarageScreen(),
    );
  }
}
