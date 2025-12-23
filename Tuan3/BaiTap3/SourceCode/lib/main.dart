import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// Model cho Sách
class Book {
  final String id;
  final String name;
  bool isBorrowed;
  String? borrowedBy;

  Book({
    required this.id,
    required this.name,
    this.isBorrowed = false,
    this.borrowedBy,
  });
}

// Model cho Nhân viên/Người dùng
class Employee {
  final String id;
  final String name;

  Employee({required this.id, required this.name});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quản lý Thư viện',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LibraryManagementSystem(),
    );
  }
}

class LibraryManagementSystem extends StatefulWidget {
  const LibraryManagementSystem({super.key});

  @override
  State<LibraryManagementSystem> createState() =>
      _LibraryManagementSystemState();
}

class _LibraryManagementSystemState extends State<LibraryManagementSystem> {
  int _selectedIndex = 0;
  final TextEditingController _employeeController = TextEditingController();
  final TextEditingController _bookController = TextEditingController();

  List<Book> books = [
    Book(id: '1', name: 'Sách 01'),
    Book(id: '2', name: 'Sách 02'),
  ];

  List<Employee> employees = [Employee(id: '1', name: 'Nguyen Van A')];

  String? currentEmployee;
  List<String> selectedBooks = [];

  @override
  void initState() {
    super.initState();
    currentEmployee = employees.isNotEmpty ? employees[0].name : null;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addBook() {
    if (_bookController.text.isNotEmpty) {
      setState(() {
        books.add(
          Book(id: (books.length + 1).toString(), name: _bookController.text),
        );
        _bookController.clear();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đã thêm sách mới')));
    }
  }

  void _addEmployee() {
    if (_employeeController.text.isNotEmpty) {
      setState(() {
        employees.add(
          Employee(
            id: (employees.length + 1).toString(),
            name: _employeeController.text,
          ),
        );
        _employeeController.clear();
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Đã thêm nhân viên mới')));
    }
  }

  void _borrowBooks() {
    if (selectedBooks.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn sách để mượn')),
      );
      return;
    }

    if (currentEmployee == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Vui lòng chọn nhân viên')));
      return;
    }

    setState(() {
      for (String bookId in selectedBooks) {
        Book book = books.firstWhere((b) => b.id == bookId);
        book.isBorrowed = true;
        book.borrowedBy = currentEmployee;
      }
      selectedBooks.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$currentEmployee đã mượn ${selectedBooks.length} cuốn sách',
        ),
      ),
    );
  }

  Widget _buildManagementTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Nhân viên',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    currentEmployee ?? 'Chọn nhân viên',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Chọn nhân viên'),
                      content: SizedBox(
                        width: double.maxFinite,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: employees.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(employees[index].name),
                              onTap: () {
                                setState(() {
                                  currentEmployee = employees[index].name;
                                });
                                Navigator.pop(context);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: const Text('Đổi'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Danh sách sách',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  Book book = books[index];
                  bool isSelected = selectedBooks.contains(book.id);
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Checkbox(
                          value: isSelected,
                          onChanged: book.isBorrowed
                              ? null
                              : (value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedBooks.add(book.id);
                                    } else {
                                      selectedBooks.remove(book.id);
                                    }
                                  });
                                },
                          activeColor: Colors.pink,
                        ),
                        Expanded(
                          child: Text(
                            book.name,
                            style: TextStyle(
                              fontSize: 16,
                              color: book.isBorrowed
                                  ? Colors.grey
                                  : Colors.black,
                            ),
                          ),
                        ),
                        if (book.isBorrowed)
                          Text(
                            'Đã mượn',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: _borrowBooks,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Thêm', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBooksTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Danh sách sách',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _bookController,
                  decoration: InputDecoration(
                    hintText: 'Tên sách',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _addBook,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                Book book = books[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.book),
                    title: Text(book.name),
                    subtitle: book.isBorrowed
                        ? Text('Đã mượn bởi: ${book.borrowedBy}')
                        : const Text('Có sẵn'),
                    trailing: book.isBorrowed
                        ? IconButton(
                            icon: const Icon(Icons.undo),
                            onPressed: () {
                              setState(() {
                                book.isBorrowed = false;
                                book.borrowedBy = null;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('${book.name} đã được trả'),
                                ),
                              );
                            },
                          )
                        : const Icon(Icons.check_circle, color: Colors.green),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Danh sách nhân viên',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _employeeController,
                  decoration: InputDecoration(
                    hintText: 'Tên nhân viên',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _addEmployee,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.add),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                Employee employee = employees[index];
                List<Book> borrowedBooks = books
                    .where((b) => b.borrowedBy == employee.name)
                    .toList();

                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(employee.name),
                    subtitle: Text(
                      'Đã mượn: ${borrowedBooks.length} cuốn sách',
                    ),
                    trailing: borrowedBooks.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.list),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Sách của ${employee.name}'),
                                  content: SizedBox(
                                    width: double.maxFinite,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: borrowedBooks.length,
                                      itemBuilder: (context, i) {
                                        return ListTile(
                                          title: Text(borrowedBooks[i].name),
                                        );
                                      },
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('Đóng'),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                        : null,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      _buildManagementTab(),
      _buildBooksTab(),
      _buildEmployeesTab(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hệ thống\nQuản lý Thư viện',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Quản lý'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'DS Sách'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Nhân viên'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  void dispose() {
    _employeeController.dispose();
    _bookController.dispose();
    super.dispose();
  }
}