import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:to_do_app/blocs/home/home_bloc.dart';
import 'package:to_do_app/core/consts/asset_images.dart';
import 'package:to_do_app/presentation/widgets/loading_widget.dart';
import 'package:to_do_app/routes/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeOnLoadState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Color(0XFF7B38B1),
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Image.asset(
                        AssetPNGImages.threeDots,
                        height: 25.0,
                        width: 25.0,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .15,
                        width: MediaQuery.of(context).size.width * .65,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              AssetPNGImages.quickStats,
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              AssetPNGImages.quickStatsText,
                              height: 80.0,
                              width: 150.0,
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * .15,
                      width: MediaQuery.of(context).size.width * .65,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            AssetPNGImages.progressTracker,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            AssetPNGImages.progressTrackerText,
                            height: 80.0,
                            width: 200.0,
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: ElevatedButton(
                          onPressed: () {
                            context.pushNamed(Routes.logNewActivity.name);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2.0,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Text(
                            'Log in New Activity',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .75,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2.0,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Text(
                            'View all the activities',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * .85,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFFFFD48E),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 2.0,
                                color: Colors.black,
                              ),
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                          ),
                          child: Image.asset(
                            AssetPNGImages.iAmBoard,
                            height: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * .18,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0XFF5299d9),
                        Color(0XFF95CCE8),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        53.0,
                      ),
                      topRight: Radius.circular(
                        53.0,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .55,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0XFF534FCF),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 2.0,
                                  color: Colors.black,
                                ),
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                            ),
                            child: Text(
                              'Set your Goal',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14.0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .55,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0XFF534FCF),
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 2.0,
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                              ),
                              child: Text(
                                'Your Achievements',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: Color(0XFF7B38B1),
                height: MediaQuery.of(context).size.height * .06,
                width: MediaQuery.of(context).size.width,
              ),
            ],
          );
        } else {
          return LoadingWidget();
        }
      },
    );
  }
}
