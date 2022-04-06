import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodle_mart/provider/address_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/config/constants/api_configurations.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/views/search/search.dart';
import 'package:foodle_mart/widgets/form_field_widget.dart';
import 'package:provider/provider.dart';

class AddNewAddress extends StatefulWidget {
  static const routeName = '/add-new-address';
  AddNewAddress({Key? key}) : super(key: key);

  @override
  State<AddNewAddress> createState() => _AddNewAddressState();
}

class _AddNewAddressState extends State<AddNewAddress> {
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _cityController = TextEditingController();
  final _districtController = TextEditingController();
  final _stateController = TextEditingController();
  final _addresstypeController = TextEditingController();

  static const _dropDownitems2 = <String>["Home", "Work"];

  final List<DropdownMenuItem<String>> _dropDownButtonItems2 = _dropDownitems2
      .map((String value) =>
          DropdownMenuItem<String>(child: Text(value), value: value))
      .toList();

  String? _btnSelectVal;

  @override
  void initState() {
    _getStatesList();
    _getDistrictList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                Color.fromRGBO(246, 219, 59, 1),
                Color.fromARGB(255, 246, 227, 59),
              ]))),
          // automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
              child: TextButton(
                onPressed: () async {
                  if (_nameController.text.isEmpty ||
                      _mobileController.text.isEmpty ||
                      _landmarkController.text.isEmpty ||
                      _cityController.text.isEmpty ||
                      _addressController.text.isEmpty ||
                      _districtController.text.isEmpty ||
                      _stateController.text.isEmpty ||
                      _addresstypeController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Please fill the empty fields."),
                        duration: Duration(seconds: 3)));
                  } else {
                    var response = await AddressApi.createAddress(
                        _nameController.text,
                        _phoneController.text,
                        _mobileController.text,
                        _landmarkController.text,
                        _cityController.text,
                        _addressController.text,
                        _districtController.text,
                        _stateController.text,
                        _addresstypeController.text);
                    if (response == true) {
                      context.read<AddressApiProvider>().address();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Address Added Sucessfull'),
                        duration: Duration(seconds: 2),
                      ));
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Check the information given."),
                          duration: Duration(seconds: 1)));
                    }
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.save, color: Colors.grey.shade800, size: 20),
                    SizedBox(width: 10),
                    Text("Save", style: TextStyle(color: Colors.black))
                  ],
                ),
              ),
            )
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black)),
          title: Text("Add New Address",
              style: TextStyle(color: Colors.black, fontSize: 16)),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                AddAddressTextfield(
                    controller: _nameController, hintText: "name"),
                SizedBox(height: 20.h),
                AddAddressTextfield(
                    controller: _mobileController, hintText: "mobile"),
                SizedBox(height: 20.h),
                AddAddressTextfield(
                    controller: _phoneController, hintText: "phone"),
                SizedBox(height: 20.h),
                AddAddressTextfield(
                    controller: _addressController, hintText: "address"),
                SizedBox(height: 20.h),
                AddAddressTextfield(
                    controller: _landmarkController, hintText: "landmark"),
                SizedBox(height: 20.h),
                AddAddressTextfield(
                    controller: _cityController, hintText: "city"),
                SizedBox(height: 20.h),
                Container(
                  height: 45,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(width: 1, color: Colors.grey.shade200)),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          hint: Text('Choose District'),
                          isExpanded: true,
                          value: _myDistrict,
                          onChanged: (String? newValue) {
                            setState(() {
                              _myDistrict = newValue;
                              _districtController.text = newValue.toString();
                              print(_myDistrict);
                            });
                          },
                          items: districtList?.map((e) {
                            return DropdownMenuItem(
                              child: Text(e['name']),
                              value: e['id'].toString(),
                            );
                          }).toList())),
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 45,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(width: 1, color: Colors.grey.shade200)),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          hint: Text('Choose State'),
                          isExpanded: true,
                          value: _myState,
                          onChanged: (String? newValue) {
                            setState(() {
                              _myState = newValue;
                              _stateController.text = newValue.toString();
                              print(_myState);
                            });
                          },
                          items: stateList?.map((e) {
                            return DropdownMenuItem(
                              child: Text(e['name']),
                              value: e['id'].toString(),
                            );
                          }).toList())),
                ),
                SizedBox(height: 20.h),
                Container(
                  height: 45,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(width: 1, color: Colors.grey.shade200)),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                          hint: Text('Choose type'),
                          isExpanded: true,
                          value: _btnSelectVal,
                          onChanged: (String? newValue) {
                            setState(() {
                              _btnSelectVal = newValue;
                              _addresstypeController.text = newValue.toString();
                              _addresstypeController.text = newValue as String;
                            });
                          },
                          items: _dropDownButtonItems2)),
                ),
              ],
            ),
          ),
        ));
  }

  List? stateList;
  String? _myState;

  Future<String?> _getStatesList() async {
    await http.post(Uri.parse(Api.search.searchState)).then((res) {
      var data = json.decode(res.body);

      setState(() {
        stateList = data['states'];
      });
    });
  }

  List? districtList;
  String? _myDistrict;

  Future<String?> _getDistrictList() async {
    await http.post(Uri.parse(Api.search.searchDistrict)).then((res) {
      var data = json.decode(res.body);

      setState(() {
        districtList = data['districts'];
      });
    });
  }
}

class AddAddressTextfield extends StatelessWidget {
  final bool obscureText;
  final String hintText;
  final TextEditingController controller;
  const AddAddressTextfield(
      {Key? key,
      required this.controller,
      required this.hintText,
      this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextFormField(
        obscureText: obscureText,
        style: TextStyle(color: Colors.black),
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp),
          hintText: hintText,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade200)),
        ),
      ),
    );
  }
}
