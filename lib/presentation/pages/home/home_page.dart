import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/home/home_bloc.dart';
import 'package:to_do_app/presentation/views/home/home_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc()
        ..add(
          const HomeOnLoadEvent(),
        ),
      child: const HomeView(),
    );
  }
}
