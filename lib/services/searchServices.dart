import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hari/modals/searchModals.dart';
import 'package:http/http.dart' as http;

class SearchService extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();

  bool isSearching = false;
  bool isGrid = false;
  bool isLoading = false;
  int pageCount = 1;

  List<String> imageList = [
    'https://cdn.pixabay.com/photo/2019/03/15/09/49/girl-4056684_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/15/16/25/clock-5834193__340.jpg',
    'https://cdn.pixabay.com/photo/2020/09/18/19/31/laptop-5582775_960_720.jpg',
    'https://media.istockphoto.com/photos/woman-kayaking-in-fjord-in-norway-picture-id1059380230?b=1&k=6&m=1059380230&s=170667a&w=0&h=kA_A_XrhZJjw2bo5jIJ7089-VktFK0h0I4OWDqaac0c=',
    'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
    'https://cdn.pixabay.com/photo/2017/02/12/10/29/christmas-2059698_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/01/29/17/09/snowboard-4803050_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
    'https://cdn.pixabay.com/photo/2020/12/09/09/27/women-5816861_960_720.jpg',
  ];

  SearchModal? imageData = SearchModal();
  SearchModal? loadImageData = SearchModal();

  // toggle search
  toggleSearch() {
    isSearching = !isSearching;
    notifyListeners();
  }

  // toggle search
  toggleorientation() {
    isGrid = !isGrid;
    notifyListeners();
  }

  ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

  setScrollNotiFier(status) {
    scrollNotifier.value = status;
    notifyListeners();
  }

  setDir(direction, notification, {bool? isfalse}) {
    if (isfalse == false) {
      scrollNotifier.value = false;
    } else if (direction == ScrollDirection.reverse) {
      scrollNotifier.value = false;
    } else if (direction == ScrollDirection.forward) {
      scrollNotifier.value = true;
    }

    return true;
  }

  searchImage() async {
    pageCount = 1;
    isLoading = true;
    notifyListeners();
    imageData = await fetchImages(searchController.text, 1);
    if (imageData != null) {
      mapImage();
    }
    isLoading = false;
    notifyListeners();
  }

  loadMore() async {
    pageCount = pageCount + 1;
    isLoading = true;
    notifyListeners();
    imageData = await fetchImages(searchController.text, pageCount);
    if (imageData != null) {
      imageData?.hits?.forEach((element) {
        if (imageList.contains(element.toString())) {
        } else {
          imageList.add(element.webformatUrl.toString());
          // imageList.add(element.previewUrl.toString());
        }
      });
    }
    isLoading = false;
    notifyListeners();
  }

  mapImage() {
    imageList = [];
    imageData?.hits?.forEach((element) {
      if (imageList.contains(element.toString())) {
      } else {
        imageList.add(element.webformatUrl.toString());
        // imageList.add(element.previewUrl.toString());
      }
    });
    pageCount = pageCount + 1;
    notifyListeners();
  }

  Future<SearchModal?> fetchImages(query, page) async {
    print("PAGE CONUT : " + page.toString());
    print("Query : " + query);
    SearchModal? result = SearchModal();
    var url = Uri.parse(
        "https://pixabay.com/api/?key=20296099-b89cb45bd315181d25ecb6b6a&q=$query&image_type=photo&page=$page&per_page=20");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final item = jsonDecode(response.body);
        result = searchModalFromJson(jsonEncode(item));

        print('Search Success');
      } else {
        print('Search Error');
      }
    } catch (e) {
      log(e.toString());
    }
    return result;
  }
}
