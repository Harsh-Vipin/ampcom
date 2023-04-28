import 'dart:convert';
import 'package:ampcom/selectedGenreProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _mobileNumberController = TextEditingController();
  final _emailController = TextEditingController();

  List<dynamic> _genres = [];
  bool _isPersonChecked = true;
  bool _isVirtualChecked = true;

  @override
  void initState() {
    super.initState();
    _fetchGenres();
  }

  Future<void> _fetchGenres() async {
    final response = await http
        .get(Uri.parse('https://apimocha.com/flutterassignment/getGenres'));
    if (response.statusCode == 200) {
      setState(() {
        _genres = jsonDecode(response.body)['data']['genres'];
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Text(
                      "Let's create your ",
                      style: TextStyle(fontSize: 24),
                    ),
                    Text(
                      "account",
                      style: TextStyle(fontSize: 24, color: Colors.green),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'First Name',
                  controller: _firstNameController,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  label: 'Last Name',
                  controller: _lastNameController,
                ),
                const SizedBox(height: 16),
                _buildTextField(
                    label: 'Mobile Number',
                    controller: _mobileNumberController,
                    keyboardType: TextInputType.number),
                const SizedBox(height: 16),
                _buildTextField(
                    label: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress),
                const SizedBox(height: 16),
                const Text(
                  'Genres',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _genres.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Consumer<SelectedGenres>(
                        builder: (context, selectedGenres, child) {
                          return MultiSelectDialogField(
                            items: _genres
                                .map((e) => MultiSelectItem(e, e['name']))
                                .toList(),
                            listType: MultiSelectListType.CHIP,
                            title: const Text("Genres"),
                            selectedColor: Colors.black12,
                            onConfirm: (values) {
                              selectedGenres.setGenres(values);
                            },
                            chipDisplay: MultiSelectChipDisplay(
                              chipColor: Colors.green,
                              onTap: (value) {
                                selectedGenres.removeGenre(value);
                              },
                              icon: const Icon(Icons.close,
                                  size: 8, color: Colors.white),
                              textStyle: const TextStyle(color: Colors.white),
                            ),
                            buttonText: const Text(
                              '',
                              style: TextStyle(color: Colors.green),
                            ),
                          );
                        },
                      ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Performance type:',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Checkbox(
                      value: _isPersonChecked,
                      onChanged: (newValue) {
                        setState(() {
                          _isPersonChecked = newValue ?? false;
                        });
                      },
                    ),
                    const Text('Person'),
                    const SizedBox(
                      width: 40,
                    ),
                    Checkbox(
                      value: _isVirtualChecked,
                      onChanged: (newValue) {
                        setState(() {
                          _isVirtualChecked = newValue ?? false;
                        });
                      },
                    ),
                    const Text('Virtual'),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Center(
                  child: SizedBox(
                    width: 300,
                    child: ElevatedButton(
                      onPressed: () {
                        // handle button press
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'SUBMIT',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.white.withOpacity(0.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white.withOpacity(0.5),
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      style: const TextStyle(
        color: Colors.white,
      ),
      onTap: () {
        setState(() {
          // set the border color to white when the text field is focused
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        });
      },
      onEditingComplete: () {
        setState(() {
          // set the border color back to 50% opacity when the user finishes editing
          controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length),
          );
        });
      },
    );
  }
}
