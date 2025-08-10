import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/blocs/log_new_activity/log_new_activity_bloc.dart';
import 'package:to_do_app/core/consts/asset_images.dart';
import 'package:to_do_app/core/consts/strings.dart';
import 'package:to_do_app/core/utils/ui_extension.dart';
import 'package:to_do_app/presentation/widgets/components/single_line_input_content.dart';
import 'package:to_do_app/presentation/widgets/loading_widget.dart';

class LogNewActivityView extends StatelessWidget {
  static const keyPrefix = 'LogNewActivityView';

  const LogNewActivityView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogNewActivityBloc, LogNewActivityState>(
      listener: (BuildContext context, LogNewActivityState state) {
        if (state is LogNewActivityOnLoadState &&
            state.errorMessage.isNotEmpty) {
          UiExtension.showToastError(
            message: state.errorMessage,
          );
        }

        if (state is LogNewActivitySuccess) {
          Navigator.of(context).maybePop();
          UiExtension.showToastSuccess(
            message: 'Activity added successfully',
          );
        }
      },
      builder: (context, state) {
        if (state is LogNewActivityOnLoadState) {
          return Stack(
            children: [
              Column(
                children: [
                  Container(
                    color: Color(0XFF7B38B1),
                    height: MediaQuery.of(context).size.height * .06,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context).maybePop();
                            },
                            child: Image.asset(
                              AssetPNGImages.back,
                              height: 25.0,
                              width: 25.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: 35.0,
                        right: 35.0,
                        top: 70.0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0XFFDCA5FE),
                            Color(0XFFA671C4),
                            Color(0XFF4D18B8),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50.0),
                          topRight: Radius.circular(50.0),
                        ), // Optional: for rounded corners
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 100.0),
                              child: Image.asset(
                                AssetPNGImages.logNewActivityText,
                                height: 34.0,
                                width: 163.0,
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              child: SingleLineInputContent(
                                key: const ValueKey('$keyPrefix-activity'),
                                textInputAction: TextInputAction.next,
                                title: '',
                                hintText: 'Activity',
                                userResponse: state.activity,
                                editTextType: Strings.activity,
                                onChanged: (String activity) {
                                  BlocProvider.of<LogNewActivityBloc>(context)
                                      .add(
                                    LogNewActivityDetailsUpdateEvent(
                                      activity: activity,
                                    ),
                                  );
                                },
                                onSubmitted: (String value) {},
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              child: SingleLineInputContent(
                                key: const ValueKey('$keyPrefix-description'),
                                textInputAction: TextInputAction.next,
                                title: '',
                                hintText: 'Description',
                                userResponse: state.description,
                                editTextType: Strings.description,
                                maxLines: 4,
                                minLines: 4,
                                onChanged: (String description) {
                                  BlocProvider.of<LogNewActivityBloc>(context)
                                      .add(
                                    LogNewActivityDetailsUpdateEvent(
                                      description: description,
                                    ),
                                  );
                                },
                                onSubmitted: (String value) {},
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              child: SingleLineInputContent(
                                key: const ValueKey('$keyPrefix-bookmark'),
                                textInputAction: TextInputAction.next,
                                title: '',
                                hintText: 'Bookmark',
                                userResponse: state.bookmark,
                                editTextType: Strings.bookmark,
                                onChanged: (String bookmark) {
                                  BlocProvider.of<LogNewActivityBloc>(context)
                                      .add(
                                    LogNewActivityDetailsUpdateEvent(
                                      bookmark: bookmark,
                                    ),
                                  );
                                },
                                onSubmitted: (String value) {},
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * .7,
                              child: SingleLineInputContent(
                                key: const ValueKey('$keyPrefix-mood'),
                                textInputAction: TextInputAction.next,
                                title: '',
                                hintText: 'Mood (Optional)',
                                userResponse: state.mood,
                                editTextType: Strings.mood,
                                onChanged: (String mood) {
                                  BlocProvider.of<LogNewActivityBloc>(context)
                                      .add(
                                    LogNewActivityDetailsUpdateEvent(
                                      mood: mood,
                                    ),
                                  );
                                },
                                onSubmitted: (String value) {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 35.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .65,
                                child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<LogNewActivityBloc>(context)
                                        .add(
                                      LogNewActivitySubmitEvent(),
                                    );
                                  },
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
                                  child: state.isLogNewActivityInProgress
                                      ? SizedBox(
                                          height: 23.0,
                                          width: 23.0,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Text(
                                          'Submit Entry',
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
                            Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * .65,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).maybePop();
                                  },
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
                                    'Go back to Dashboard',
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
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .06,
                left: MediaQuery.of(context).size.width * .30,
                child: Image.asset(
                  AssetPNGImages.logNewActivity,
                  height: 175.0,
                  width: 175.0,
                ),
              ),
              Positioned(
                right: -MediaQuery.of(context).size.height * .04,
                top: MediaQuery.of(context).size.width * .25,
                child: Image.asset(
                  AssetPNGImages.uranusPlanet,
                  height: 157.0,
                  width: 157.0,
                ),
              ),
              Positioned(
                left: -MediaQuery.of(context).size.height * .01,
                bottom: MediaQuery.of(context).size.width * .16,
                child: Image.asset(
                  AssetPNGImages.stars,
                  height: 120.0,
                  width: 120.0,
                ),
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
