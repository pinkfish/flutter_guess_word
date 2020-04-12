/*
 * Copyright (c) 2020 pinkfish
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
 * OR OTHER DEALINGS IN THE SOFTWARE.
 */

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:built_collection/built_collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_word_guesser/data/gamecategory.dart';
import 'package:flutter_word_guesser/services/gamedata.dart';
import 'package:meta/meta.dart';

///
/// The data associated with the category.
///
abstract class CategoryState extends Equatable {
  final BuiltList<GameCategory> categories;

  CategoryState({@required this.categories});

  @override
  List<Object> get props => [categories];
}

///
/// We have a category, default state.
///
class CategoryLoaded extends CategoryState {
  CategoryLoaded({BuiltList<GameCategory> categories, CategoryState state})
      : assert(categories != null || state != null),
        super(categories: categories ?? state.categories);

  @override
  String toString() {
    return 'CategoryLoaded{}';
  }
}

///
/// What the system has not yet read the category state.
///
class CategoryUninitialized extends CategoryState {
  CategoryUninitialized() : super(categories: BuiltList.of([]));
}

abstract class CategoryEvent extends Equatable {}

class _CategoryNewList extends CategoryEvent {
  final BuiltList<GameCategory> categories;

  _CategoryNewList({@required this.categories});

  @override
  List<Object> get props => [categories];
}

///
/// Bloc to handle updates and state of a specific category.
///
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final GameData db;

  StreamSubscription<BuiltList<GameCategory>> _categorySub;

  CategoryBloc({@required this.db}) {
    _categorySub = db.getAllCategories().listen(_onCategoryUpdate);
  }

  void _onCategoryUpdate(BuiltList<GameCategory> g) {
    add(_CategoryNewList(categories: g));
  }

  @override
  Future<void> close() async {
    _categorySub?.cancel();
    _categorySub = null;
    await super.close();
  }

  @override
  CategoryState get initialState {
    return CategoryUninitialized();
  }

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is _CategoryNewList) {
      yield CategoryLoaded(categories: event.categories, state: state);
    }
  }
}
