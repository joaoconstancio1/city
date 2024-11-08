import 'package:city/core/custom_error_widget.dart';
import 'package:city/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(create: (_) => HomePageCubit(Modular.get())..init()),
    ], child: HomePageView());
  }
}

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          centerTitle: true,
        ),
        body: BlocBuilder<HomePageCubit, HomePageState>(
          builder: (context, state) {
            if (state is HomePageLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomePageErrorState) {
              return CustomErrorWidget(
                message: 'Something went wrong. Please try again.',
                onRetry: () {
                  Modular.get<HomePageCubit>().init();
                },
              );
            }

            if (state is HomePageSuccessState) {
              return Card(
                child: Text(state.cities.first.description ?? ''),
              );
            }
            return SizedBox();
          },
        ));
  }
}
