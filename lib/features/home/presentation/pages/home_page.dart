import 'package:city/core/custom_error_widget.dart';
import 'package:city/core/custom_loading_widget.dart';
import 'package:city/core/core_extensions.dart';
import 'package:city/features/home/presentation/components/show_delete_confirmation_dialog.dart';
import 'package:city/features/home/presentation/components/weather_card.dart';
import 'package:city/features/home/presentation/cubit/home_page_cubit.dart';
import 'package:city/features/home/presentation/cubit/home_page_states.dart';
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
        backgroundColor: Colors.blueAccent,
        title: Text(
          'Weather Info',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              Modular.to.pushNamed('/edit').then((_) {
                if (context.mounted) {
                  context.read<HomePageCubit>().init();
                }
              });
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
            return ListView.builder(
              itemCount: state.cities.length,
              itemBuilder: (context, index) {
                final reversedCities = state.cities.reversed.toList();
                final city = reversedCities[index];
                return WeatherCard(
                  city: city,
                  onDelete: () => showDeleteConfirmationDialog(
                    context,
                    () {
                      context.read<HomePageCubit>().deleteCity(city.id ?? '');
                      Navigator.of(context).pop();
                    },
                  ),
                  onEdit: () {
                    Modular.to
                        .pushNamed(
                      '/edit',
                      arguments: city,
                    )
                        .then((_) {
                      if (context.mounted) {
                        context.read<HomePageCubit>().init();
                      }
                    });
                  },
                );
              },
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
