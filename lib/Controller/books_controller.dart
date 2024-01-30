import 'package:eduventure_nodejs/Model/issue_book_model.dart';
import 'package:get/get.dart';
import '../Model/books_model.dart';
import '../Repository/books_repository.dart';
import '../apis/apis.dart';

class BooksController extends GetxController {
  static BooksController get instance => Get.find();

  final isLoading = false.obs;
  final _booksRepository = Get.put(BooksRepository());
  RxList<BooksModel> allBooks = <BooksModel>[].obs;
  RxList<IssueBookModel> myAppliedBooks = <IssueBookModel>[].obs;
  RxList<IssueBookModel> myIssuedBooks = <IssueBookModel>[].obs;
  RxList<IssueBookModel> myReturnedBooks = <IssueBookModel>[].obs;
  RxList<BooksModel> searchResults = <BooksModel>[].obs; // New list for search results

  @override
  void onInit() {
    fetchBooks();
    fetchMyBooks();
    super.onInit();
  }

  Future<void> fetchBooks() async {
    try {
      isLoading.value = true;

      String token = await Apis().getToken();
      if (token != '') {
        final books = await _booksRepository.getAllBooks(token);
        allBooks.assignAll(books);
        isLoading.value = false;
      }else{

      }


    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchMyBooks() async {
    try {
      isLoading.value = true;

      String token = await Apis().getToken();
      if (token != '') {
        final books = await _booksRepository.getMyIssueBooks(token);

        final appliedBooks = books.where((book) => book.status == "applied").toList();
        myAppliedBooks.assignAll(appliedBooks);

        final issuedBooks = books.where((book) => book.status == "issued").toList();
        myIssuedBooks.assignAll(issuedBooks);

        final returnedBooks = books.where((book) => book.status == "returned").toList();
        myReturnedBooks.assignAll(returnedBooks);
        isLoading.value = false;
      }else{

      }


    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void searchBooks(String searchText) {
    if (searchText.isEmpty) {
      // If search text is empty, show all books
      searchResults.clear();
    } else {
      // Perform a local search in the existing books list
      searchResults.assignAll(allBooks
          .where((book) =>
      book.bookName.toLowerCase().contains(searchText.toLowerCase()) ||
          book.subjectName.toLowerCase().contains(searchText.toLowerCase()) ||
          book.bookId.toLowerCase().contains(searchText.toLowerCase()) ||
          book.authorName.toLowerCase().contains(searchText.toLowerCase()))
          .toList());
    }
  }
}
