import 'package:flutter/material.dart';

class DropDownCustomTextfailed extends StatefulWidget {
  const DropDownCustomTextfailed({
    super.key,
    this.hintText,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.dropdownItems,
    this.onDropdownChanged,
    this.dropdownValue,
    this.onTap,
  });

  final String? hintText;
  final TextInputType? keyboardType;
  final Icon? prefixIcon;
  final Icon? suffixIcon;
  final List<String>? dropdownItems;
  final ValueChanged<String?>? onDropdownChanged;
  final String? dropdownValue;
  final VoidCallback? onTap;

  @override
  State<DropDownCustomTextfailed> createState() => _DropDownCustomTextfailedState();
}

class _DropDownCustomTextfailedState extends State<DropDownCustomTextfailed> {
  String? _selectedDropdownItem;
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _selectedDropdownItem = widget.dropdownValue;
  }

  void _toggleDropdown() {
    setState(() {
      _isDropdownOpen = !_isDropdownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              _toggleDropdown();
              if (widget.onTap != null) {
                widget.onTap!();
              }
            },
            child: AbsorbPointer(
              child: TextField(
                textAlign: TextAlign.right,
                decoration: InputDecoration(
                  hintText: _selectedDropdownItem ?? widget.hintText,
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(
                      color: _isDropdownOpen ? Colors.green : Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      width: 2.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                ),
              ),
            ),
          ),
          if (_isDropdownOpen && widget.dropdownItems != null)
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(top: 12.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: _isDropdownOpen ? Colors.grey.shade300 : Colors.green),
              ),
              child: Container(
                height: 200, // Set a fixed height for the dropdown
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  itemCount: widget.dropdownItems!.length,
                  itemBuilder: (context, index) {
                    String item = widget.dropdownItems![index];
                    bool isSelected = item == _selectedDropdownItem;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDropdownItem = item;
                          _isDropdownOpen = false;
                          if (widget.onDropdownChanged != null) {
                            widget.onDropdownChanged!(_selectedDropdownItem);
                          }
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                        color: isSelected ? const Color(0XFFDDE4DE) : Colors.transparent,
                        child: Text(
                          item,
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
    );
  }
}
