import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/features/weather/presentation/bloc/search_location_bloc.dart';

import '../../../../../core/utils/color_constants.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _WeatherAppMainScreenState();
}

class _WeatherAppMainScreenState extends State<SearchLocationScreen> {
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<SearchLocationBloc>(context).add(SetInitialStateEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: BlocBuilder<SearchLocationBloc, SearchLocationState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              children: [
                TextFormField(
                  controller: textEditingController,
                  autofocus: true,
                  onChanged: (val) {
                    BlocProvider.of<SearchLocationBloc>(context)
                        .add(SearchLocationWithQueryEvent(val));
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(left: 8, right: 8),
                    fillColor: textFieldBgColor,
                    filled: true,
                    prefixIcon: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: SvgPicture.asset(
                              'assets/images/search_icon.svg',
                              width: 16,
                              height: 16,
                              semanticsLabel: 'Cancel Selection'),
                        ),
                      ],
                    ),
                    hintText: "Search",
                    hintStyle: Theme.of(context).textTheme.bodyText2?.copyWith(
                          fontSize: 17,
                        ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.transparent)),
                  ),
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontSize: 17,
                      ),
                ),
                Expanded(child: buildListView(state)),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildListView(SearchLocationState state) {
    if (state is SearchLocationSuccess) {
      return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: state.locationList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.pop(context, state.locationList.elementAt(index).woeId);
            },
            child: ListTile(
              title: Text(state.locationList.elementAt(index).title ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(fontWeight: FontWeight.w500, fontSize: 16)),
            ),
          );
        },
      );
    } else if (state is SearchLocationEmpty) {
      return Center(
          child: Text(
        "No results",
        style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 16),
      ));
    } else if (state is SearchLocationInitialState) {
      return Center(
          child: Text(
        "Enter you search query",
        style: Theme.of(context).textTheme.headline2?.copyWith(fontSize: 16),
      ));
    } else {
      return Container();
    }
  }
}
