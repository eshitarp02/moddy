import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/log_new_activity/log_new_activity_bloc.dart';
import 'package:to_do_app/presentation/views/log_new_activity/log_new_activity_view.dart';

class LogNewActivityPage extends StatelessWidget {
  const LogNewActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LogNewActivityBloc>(
      create: (context) => LogNewActivityBloc()
        ..add(
          const LogNewActivityOnLoadEvent(),
        ),
      child: const LogNewActivityView(),
    );
  }
}
