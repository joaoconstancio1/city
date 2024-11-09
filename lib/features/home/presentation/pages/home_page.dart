import 'package:city/core/custom_error_widget.dart';
import 'package:city/core/custom_loading_widget.dart';
import 'package:city/core/core_extensions.dart';
import 'package:city/features/home/presentation/components/show_delete_confirmation_dialog.dart';
import 'package:city/features/home/presentation/components/weather_card.dart';
import 'package:city/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomePageCubit(Modular.get())..init()),
      ],
      child: HomePageView(),
    );
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
        title: Text('Weather Info'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              context.read<HomePageCubit>().addCity();
            },
          ),
        ],
      ),
      body: BlocBuilder<HomePageCubit, HomePageState>(
        builder: (context, state) {
          if (state is HomePageLoadingState) {
            return CustomLoadingWidget();
          }

          if (state is HomePageErrorState) {
            return CustomErrorWidget(
              details: state.exception.toString(),
              message: 'Something went wrong. Please try again.',
              onRetry: () {
                context.read<HomePageCubit>().init();
              },
            );
          }

          if (state is HomePageSuccessState) {
            return WeatherCard(
              data: state.cities,
              onDelete: (id) {
                showDeleteConfirmationDialog(context, id);
              },
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
