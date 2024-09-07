abstract class LayoutState{}


class LayoutLoading extends LayoutState{}

class LayoutPageChanged extends LayoutState{}


class BannerLoading extends LayoutState{}
class BannerSuccess extends LayoutState{}
class BannerError extends LayoutState{
  final String? error;
  BannerError({this.error});
}


class CategoryLoading extends LayoutState{}
class CategorySuccess extends LayoutState{}
class CategoryError extends LayoutState{
  final String? error;
  CategoryError({this.error});
}

class ProductSuccess extends LayoutState{}
class ProductError extends LayoutState{
  final String? error;
  ProductError({this.error});
}

class FavoriteProductLoading extends LayoutState{}
class FavoriteProductSuccess extends LayoutState{}
class FavoriteProductError extends LayoutState{}

class AddOrRemoveFavoriteLoading extends LayoutState{}
class AddOrRemoveFavoriteSuccess extends LayoutState{}
class AddOrRemoveFavoriteError extends LayoutState{}

class FilterProductSuccess extends LayoutState{}

class CartsLoading extends LayoutState{}
class CartsSuccess extends LayoutState{}
class CartsError extends LayoutState{}


class AddOrRemoveCartsLoading extends LayoutState{}
class AddOrRemoveCartsSuccess extends LayoutState{}
class AddOrRemoveCartsError extends LayoutState{}


class ChangePasswordLoading extends LayoutState{}
class ChangePasswordSuccess extends LayoutState{}
class ChangePasswordError extends LayoutState{
  final String message;
  ChangePasswordError(this.message);
}

class ChangeDataLoading extends LayoutState{}
class ChangeDataSuccess extends LayoutState{}
class ChangeDataError extends LayoutState{
  final String message;
  ChangeDataError(this.message);
}





