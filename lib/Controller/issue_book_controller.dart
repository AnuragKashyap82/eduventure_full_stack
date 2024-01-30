import 'package:get/get.dart';

import '../Model/issue_book_model.dart';
import '../Repository/issue_book_repository.dart';
import '../apis/apis.dart';

class IssueBookController extends GetxController {
  static IssueBookController get instance => Get.find();

  final isLoading = false.obs;
  final _issueBookRepository = Get.put(IssueBookRepository());
  RxList<IssueBookModel> allIssuedBooks = <IssueBookModel>[].obs;
  RxList<IssueBookModel> allAppliedBooks = <IssueBookModel>[].obs;

  RxList<IssueBookModel> userIssuedBooks = <IssueBookModel>[].obs;
  RxList<IssueBookModel> userAppliedBooks = <IssueBookModel>[].obs;

  RxList<IssueBookModel> searchResults = <IssueBookModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAllIssueBooks();
    fetchIndividualIssueBooks("20901100105");
  }

  Future<void> fetchAllIssueBooks() async {
    try {
      isLoading.value = true;
      String token = await Apis().getToken();
      if (token != '') {
        final issueBooks = await _issueBookRepository.getAllIssuedBooks(token);

        // Set to store unique UIDs
        final Set<String> uniqueUidsIssued = Set();
        final Set<String> uniqueUidsApplied = Set();

        // List to store unique issued and applied books
        final List<IssueBookModel> uniqueIssuedBooks = [];
        final List<IssueBookModel> uniqueAppliedBooks = [];

        for (final issueBook in issueBooks) {
          // Check if the UID is already in the set
          if (issueBook.status == 'issued' && !uniqueUidsIssued.contains(issueBook.studentId)) {
            uniqueUidsIssued.add(issueBook.studentId);
            uniqueIssuedBooks.add(issueBook);
          }

          // Check if the UID is already in the set
          if (issueBook.status == 'applied' && !uniqueUidsApplied.contains(issueBook.studentId)) {
            uniqueUidsApplied.add(issueBook.studentId);
            uniqueAppliedBooks.add(issueBook);
          }
        }

        allIssuedBooks.assignAll(uniqueIssuedBooks);
        allAppliedBooks.assignAll(uniqueAppliedBooks);
        isLoading.value = false;
      }else{
        isLoading.value = false;
      }




    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchIndividualIssueBooks(String studentId) async {
    try {
      isLoading.value = true;
      String token = await Apis().getToken();
      if (token != '') {
        final issueBooks = await _issueBookRepository.getAllIssuedBooks(token);



        final userAppliedBook = issueBooks.where((books) => books.status == "applied" && books.studentId == studentId).toList();
        userAppliedBooks.assignAll(userAppliedBook);

        final userIssuedBook = issueBooks.where((books) => books.status == "issued" && books.studentId == studentId).toList();
        userIssuedBooks.assignAll(userIssuedBook);

        isLoading.value = false;
      }else{
        isLoading.value = false;
      }




    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void searchUserApplied(String searchText) {
    if (searchText.isEmpty) {
      // If search text is empty, show all books
      searchResults.clear();
    } else {
      // Perform a local search in the existing books list
      searchResults.assignAll(allAppliedBooks
          .where((book) =>
      book.name.toLowerCase().contains(searchText.toLowerCase()) ||
          book.studentId.toLowerCase().contains(searchText.toLowerCase()))
          .toList());
    }
  }

  void searchUserIssued(String searchText) {
    if (searchText.isEmpty) {
      // If search text is empty, show all books
      searchResults.clear();
    } else {
      // Perform a local search in the existing books list
      searchResults.assignAll(allIssuedBooks
          .where((book) =>
      book.name.toLowerCase().contains(searchText.toLowerCase()) ||
          book.studentId.toLowerCase().contains(searchText.toLowerCase()))
          .toList());
    }
  }
}
