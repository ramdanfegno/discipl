part of 'fc_list_bloc.dart';

abstract class FCListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadListingPage extends FCListEvent {
  final bool forceRefresh;
  final String? slug;
  final int pageNo;
  final String? searchQ;
  final String? categoryId;
  final ZoneResult? zone;

  LoadListingPage({
    required this.forceRefresh,
    required this.slug,
    required this.pageNo,
    this.searchQ,
    this.categoryId,
    required this.zone
  });
}

class RefreshListingPage extends FCListEvent {
  final bool forceRefresh;
  final String? slug;
  final int pageNo;
  final String? searchQ;
  final String? categoryId;
  final ZoneResult? zone;

  RefreshListingPage({
    required this.forceRefresh,
    required this.slug,
    required this.pageNo,
    this.searchQ,
    this.categoryId,
    required this.zone
  });
}

class SearchListingPage extends FCListEvent {
  final bool forceRefresh;
  final String? slug;
  final String? searchQ;
  final int pageNo;
  final String? categoryId;
  final ZoneResult? zone;

  SearchListingPage({
    required this.forceRefresh,
    required this.slug,
    required this.searchQ,
    required this.pageNo,
    required this.zone,
    this.categoryId
  });
}

class PaginateListingPage extends FCListEvent {
  final bool forceRefresh;
  final String? slug;
  final int pageNo;
  final String? searchQ;
  final List<FitnessCenterModel>? fcList;
  final String? categoryId;
  final ZoneResult? zone;

  PaginateListingPage({
    required this.forceRefresh,
    this.searchQ,
    required this.slug,
    required this.pageNo,
    required this.fcList,
    required this.zone,
    this.categoryId
  });
}
