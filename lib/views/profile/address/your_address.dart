import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:foodle_mart/models/address_model.dart';
import 'package:foodle_mart/repository/customer_repo.dart';
import 'package:foodle_mart/views/profile/address/add_new_address.dart';

class YourAddress extends StatefulWidget {
  static const routeName = '/your-address';
  const YourAddress({Key? key}) : super(key: key);

  @override
  State<YourAddress> createState() => _YourAddressState();
}

class _YourAddressState extends State<YourAddress> {
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
                  Color.fromARGB(255, 246, 227, 59)
                ]))),
            // automaticallyImplyLeading: false,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.black)),
            title:
                Text("Manage Address", style: TextStyle(color: Colors.black)),
            bottom: PreferredSize(
                child: Container(
                  padding: const EdgeInsets.only(
                      left: 40, top: 5, bottom: 5, right: 30),
                  width: double.infinity,
                  color: Color.fromARGB(255, 252, 235, 82),
                  child: Text(
                    "Manage Address",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
                preferredSize: Size.fromHeight(40.h))),
        body: AddressBody());
  }
}

class AddressBody extends HookWidget {
  const AddressBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = useState(0);
    return Stack(clipBehavior: Clip.none, children: [
      SizedBox(
          height: MediaQuery.of(context).size.height * .78,
          child: FutureBuilder(
              future: AddressApi.addressList(),
              builder: ((context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  List<AddressListModel> data = snapshot.data;
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: ((context, index) {
                        AddressListModel addressList = data[index];
                        return GestureDetector(
                          onTap: () async {
                            await AddressApi.defualtAddress(
                                addressList.id.toString());
                            state.value = index;
                          },
                          child: SelectableAddressWidget(
                            defaultAddr: addressList.addressDefault,
                            id: addressList.id.toString(),
                            addresstype: addressList.type.toString(),
                            address: addressList.address.toString(),
                            phone: addressList.mobile.toString(),
                            pincode: addressList.pincode.toString(),
                          ),
                        );
                      }));
                } else {
                  return const Center(
                      child: Text('No Address yet!!',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)));
                }
              }))),
      Positioned(
        right: 30,
        bottom: -10,
        child: GestureDetector(
          onTap: () {
            print('add');
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNewAddress()));
          },
          child: Container(
              height: 45.h,
              width: 115.w,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color.fromRGBO(246, 219, 59, 1),
                        Color.fromARGB(255, 246, 227, 59),
                      ]),
                  borderRadius: BorderRadius.circular(8)),
              child: Center(child: Text("Add Address"))),
        ),
      )
    ]);
  }
}

class SelectableAddressWidget extends StatelessWidget {
  dynamic defaultAddr;
  String? id;
  String addresstype;
  String address;
  String phone;
  String pincode;

  SelectableAddressWidget(
      {Key? key,
      this.defaultAddr,
      this.id,
      this.addresstype = 'Address type',
      this.address = 'address',
      this.phone = "phone",
      this.pincode = "pincode"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 15, left: 20, right: 20),
        width: 300.w,
        height: 100.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey.shade200, width: 2.w)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                flex: 2,
                child: int.parse(defaultAddr) == 1
                    ? Icon(Icons.radio_button_checked)
                    : Icon(Icons.radio_button_unchecked)),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(addresstype,
                      style: TextStyle(
                          fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 5.h),
                  Text(address, style: TextStyle(fontSize: 12.sp)),
                  SizedBox(height: 5.h),
                  Text(phone, style: TextStyle(fontSize: 12.sp)),
                  SizedBox(height: 5.h),
                  Text(pincode, style: TextStyle(fontSize: 12.sp)),
                ],
              ),
            ),
            Expanded(
                flex: 2,
                child: GestureDetector(
                  onTap: () {
                    print('edit');
                  },
                  child: Container(
                      height: 25,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: Colors.grey.shade400),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text("Edit",
                          style: TextStyle(
                              fontSize: 12.sp, fontWeight: FontWeight.w600))),
                )),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () async {
                        var response = await AddressApi.removeAddress(id);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/your-address');
                        print("remove");
                      },
                      icon: Icon(Icons.cancel_rounded,
                          size: 20, color: Colors.grey.shade800)),
                ],
              ),
            )
          ],
        ));
  }
}
