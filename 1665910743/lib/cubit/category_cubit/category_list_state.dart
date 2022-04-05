

class CategoryListState {
  
  final bool searchMode;
  final String searchResult;
  final bool authKey;
  final String? imageUrl;
  

  CategoryListState( {
    this.imageUrl,
    this.authKey = false,
    this.searchResult = '',
    this.searchMode = false,
    
  });
}
