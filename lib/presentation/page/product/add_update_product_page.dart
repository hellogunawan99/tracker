import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/model/product.dart';
import '../../../data/source/source_product.dart';

class AddUpdateProductPage extends StatefulWidget {
  const AddUpdateProductPage({Key? key, this.product}) : super(key: key);
  final Product? product;

  @override
  State<AddUpdateProductPage> createState() => _AddUpdateProductPageState();
}

class _AddUpdateProductPageState extends State<AddUpdateProductPage> {
  final controllerCode = TextEditingController();
  final controllerSn = TextEditingController();
  final controllerName = TextEditingController();
  final controllerLokasi = TextEditingController();
  final controllerPrice = TextEditingController();
  final controllerStock = TextEditingController();
  final controllerUnit = TextEditingController();
  final controllerkondisi = TextEditingController();
  final formKey = GlobalKey<FormState>();

  addProduct() async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Tambah Barang', 'Yakin Tambah Barang Baru?');
    if (yes ?? false) {
      bool success = await SourceProduct.add(Product(
        code: controllerCode.text,
        sn: controllerSn.text,
        name: controllerName.text,
        lokasi: controllerLokasi.text,
        price: controllerPrice.text,
        stock: int.parse(controllerStock.text),
        unit: controllerUnit.text,
        kondisi: controllerkondisi.text,
      ));
      if (success) {
        DInfo.dialogSuccess('Sukses Menambahkan Barang Baru');
        DInfo.closeDialog(actionAfterClose: () {
          Get.back(result: true);
        });
      } else {
        DInfo.dialogError('Gagal Menambahkan Barang Baru');
        DInfo.closeDialog();
      }
    }
  }

  updateProduct() async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Update barang', 'Yakin Update Barang?');
    if (yes ?? false) {
      bool success = await SourceProduct.update(
          widget.product!.code!, // as old code
          Product(
            code: controllerCode.text, // as new code
            sn: controllerSn.text,
            name: controllerName.text,
            lokasi: controllerLokasi.text,
            price: controllerPrice.text,
            stock: int.parse(controllerStock.text),
            unit: controllerUnit.text,
            kondisi: controllerkondisi.text,
          ));
      if (success) {
        DInfo.dialogSuccess('Sukses Update Barang');
        DInfo.closeDialog(actionAfterClose: () {
          Get.back(result: true);
        });
      } else {
        DInfo.dialogError('Gagal Update Barang');
        DInfo.closeDialog();
      }
    }
  }

  @override
  void initState() {
    if (widget.product != null) {
      controllerCode.text = widget.product!.code!;
      controllerSn.text = widget.product!.sn!;
      controllerName.text = widget.product!.name!;
      controllerLokasi.text = widget.product!.lokasi!;
      controllerStock.text = widget.product!.stock.toString();
      controllerUnit.text = widget.product!.unit!;
      controllerkondisi.text = widget.product!.kondisi!;
      controllerPrice.text = widget.product!.price!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft(
          widget.product == null ? 'Tambah Barang' : 'Update Barang'),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // DInput(
            //   controller: controllerName,
            //   hint: 'CORELP',
            //   title: 'Nama Barang',
            //   validator: (value) => value == '' ? "Don't Empty" : null,
            //   isRequired: true,
            //   fillColor: Colors.blue[100],
            // ),
            TextField(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              controller: controllerName,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.view_in_ar_sharp,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                labelText: 'Nama Barang',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                hintText: 'Barang',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 9,
                ),
              ),
            ),
            DView.spaceHeight(),
            // DInput(
            //   controller: controllerCode,
            //   hint: 'JGWMIA4',
            //   title: 'Material Number',
            //   validator: (value) => value == '' ? "Don't Empty" : null,
            //   isRequired: true,
            // ),
            TextField(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              controller: controllerCode,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.abc_rounded,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                labelText: 'Material No',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                hintText: 'Material Number',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 9,
                ),
              ),
            ),
            DView.spaceHeight(),
            // DInput(
            //   controller: controllerSn,
            //   maxLine: 20,
            //   minLine: 10,
            //   hint: '8752178-71268',
            //   label: 'S/N',
            //   validator: (value) => value == '' ? "Don't Empty" : null,
            //   isRequired: true,
            // ),
            TextField(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              controller: controllerSn,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.qr_code,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                labelText: 'SN',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                hintText: 'Serial Number',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 9,
                ),
              ),
            ),
            DView.spaceHeight(),
            // DInput(
            //   controller: controllerLokasi,
            //   hint: 'Lokasi Barang',
            //   title: 'Lokasi',
            //   validator: (value) => value == '' ? "Don't Empty" : null,
            //   isRequired: true,
            // ),
            TextField(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              controller: controllerLokasi,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.location_on_outlined,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                labelText: 'Lokasi',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                hintText: 'Lokasi Barang',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 9,
                ),
              ),
            ),
            DView.spaceHeight(),
            // DInput(
            //   controller: controllerPrice,
            //   hint: '50000',
            //   title: 'Harga',
            //   validator: (value) => value == '' ? "Don't Empty" : null,
            //   isRequired: true,
            //   inputType: TextInputType.number,
            // ),
            TextField(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              controller: controllerPrice,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.attach_money_outlined,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                labelText: 'Harga',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                hintText: 'Harga Jika Menggunakan Budget',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 9,
                ),
              ),
            ),
            DView.spaceHeight(),
            // DInput(
            //   controller: controllerStock,
            //   hint: '18',
            //   title: 'Stock',
            //   validator: (value) => value == '' ? "Don't Empty" : null,
            //   isRequired: true,
            //   inputType: TextInputType.number,
            // ),
            TextField(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              controller: controllerStock,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.money,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                labelText: 'Stock',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                hintText: 'Stock Barang',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 9,
                ),
              ),
            ),
            DView.spaceHeight(),
            // DInput(
            //   controller: controllerUnit,
            //   hint: 'Satuan',
            //   title: 'Satuan',
            //   validator: (value) => value == '' ? "Don't Empty" : null,
            //   isRequired: true,
            // ),
            TextField(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              controller: controllerUnit,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.edit_location_outlined,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                labelText: 'Satuan',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                hintText: 'EA / PACK / PCS',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 9,
                ),
              ),
            ),
            DView.spaceHeight(),
            // DInput(
            //   controller: controllerkondisi,
            //   hint: 'Kondisi',
            //   title: 'Kondisi',
            //   validator: (value) => value == '' ? "Don't Empty" : null,
            //   isRequired: true,
            // ),
            TextField(
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              controller: controllerkondisi,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.eco_outlined,
                  color: Colors.black,
                ),
                border: OutlineInputBorder(),
                labelText: 'Kondisi',
                labelStyle: TextStyle(
                  color: Colors.black38,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
                hintText: 'Kondisi Barang',
                hintStyle: TextStyle(
                  color: Colors.black38,
                  fontSize: 9,
                ),
              ),
            ),
            DView.spaceHeight(),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  if (widget.product == null) {
                    addProduct();
                  } else {
                    updateProduct();
                  }
                }
              },
              child: Text(
                  widget.product == null ? 'Add Product' : 'Update Product'),
            ),
          ],
        ),
      ),
    );
  }
}
