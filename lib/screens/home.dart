import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hari/screens/fullScreenWidget.dart';
import 'package:hari/services/searchServices.dart';
import 'package:provider/provider.dart';
import 'package:skeletons/skeletons.dart';
import 'package:transparent_image/transparent_image.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  double position = 0.0;

  double sensitivityFactor = 20.0;

  @override
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Consumer<SearchService>(
        builder: (context, SearchService search, child) {
      return ValueListenableBuilder(
          valueListenable: search.scrollNotifier,
          builder: (BuildContext context, index, _) {
            return NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  final ScrollDirection direction = notification.direction;

                  return search.setDir(direction, notification);
                },
                child: NotificationListener<ScrollNotification>(
                  onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollEndNotification) {
                      search.loadMore();
                    }
                    if (scrollNotification.metrics.pixels - position >=
                        sensitivityFactor) {
                      print('Axis Scroll Direction : Up');
                      position = scrollNotification.metrics.pixels;
                      search.setScrollNotiFier(false);
                    }
                    if (position - scrollNotification.metrics.pixels >=
                        sensitivityFactor) {
                      print('Axis Scroll Direction : Down');
                      search.setScrollNotiFier(true);

                      position = scrollNotification.metrics.pixels;
                    }

                    return true;
                  },
                  child: Scaffold(
                    body: ListView(
                      children: [
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: search.scrollNotifier.value == true
                              ? Column(
                                  children: [
                                    search.scrollNotifier.value == true
                                        ? SizedBox(
                                            height: 20,
                                          )
                                        : Container(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 8, 8, 8),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 9,
                                            child: TextField(
                                              onSubmitted: (value) {
                                                search.searchImage();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              controller:
                                                  search.searchController,
                                              cursorColor: Colors.black,
                                              decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                    Icons.search,
                                                    color: Colors.black),
                                                hintStyle: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                                hintText: "Search for ideas",
                                                filled: true,
                                                fillColor: Colors.grey[300],
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
                                              child: Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                    color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50)),
                                                child: IconButton(
                                                    color: Colors.white,
                                                    onPressed: () {
                                                      search.searchImage();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    icon: Icon(Icons
                                                        .double_arrow_outlined)),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 10,
                                  height: 10,
                                  child: Container(),
                                ),
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 250),
                          child: search.scrollNotifier.value == true
                              ? Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Pixby ",
                                        style: TextStyle(color: Colors.teal),
                                      ),
                                      InkWell(
                                        child: IconButton(
                                            icon: Icon(
                                                search.isGrid
                                                    ? Icons.grid_view
                                                    : Icons.list,
                                                color: Colors.teal),
                                            onPressed: () {
                                              search.toggleorientation();
                                            }),
                                      )
                                    ],
                                  ),
                                )
                              : AnimatedContainer(
                                  duration: const Duration(milliseconds: 300),
                                  width: 0,
                                  height: 0,
                                  child: Container(),
                                ),
                        ),
                        Container(
                          height: search.scrollNotifier.value
                              ? MediaQuery.of(context).size.height * 0.83
                              : MediaQuery.of(context).size.height,
                          margin: const EdgeInsets.all(12),
                          child: MasonryGridView.count(
                            crossAxisCount: search.isGrid ? 1 : 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 12,
                            itemCount: search.imageList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15))),
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (ctx) {
                                        return FullScreenView(
                                          url: "${search.imageList[index]}",
                                        );
                                      }));
                                    },
                                    child: CachedNetworkImage(
                                      fit: BoxFit.cover,
                                      imageUrl: "${search.imageList[index]}",
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              Center(
                                        child: SkeletonAvatar(
                                            style: SkeletonAvatarStyle(
                                                width: search.isGrid
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        09
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2,
                                                height: search.isGrid
                                                    ? MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.25
                                                    : MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.15)),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          });
    });
  }
}
