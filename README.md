# Tugas PBP Ganjil 2023/2024

**Nama    : Bulan Athaillah Permata Wijaya**<br>
**NPM     : 2206032135**<br>
**Kelas   : PBP C**<br>

## Tugas 7
### Apa perbedaan utama antara _stateless_ dan _stateful widget_ dalam konteks pengembangan aplikasi Flutter?
_Stateless widget_ merupakan _widget_ yang tidak dapat berubah dan tidak dapat melakukan _rebuild_ selama aplikasi sedang dieksekusi. _Widget_ ini bersifat _immutable_ dan statis sehingga tidak dapat merespon peristiwa eksternal. _Stateless widget_ biasanya digunakan untuk menampilkan konten statis seperti _widget_ Text, Icon, IconButton, dan Image.

_Stateful widget_ merupakan _widget_ yang dapat berubah secara dinamis dan dapat melakukan _rebuild_ selama aplikasi sedang dieksekusi. _Widget_ ini bersifat _mutable_ dan dinamis sehingga dapat mengubah atributnya berdasarkan interaksi yang dilakukan oleh _user_. _Stateful widget_ biasanya digunakan untuk menampilkan elemen UI yang interaktif seperti _widget_ Checkbox, _TextField_, _Slider_, dan Radio Button

### Sebutkan seluruh _widget_ yang kamu gunakan untuk menyelesaikan tugas ini dan jelaskan fungsinya masing-masing.
- `MyHomePage` merupakan _stateless widget_ yang berfungsi untuk mewakili halaman utama aplikasi.
- `MyApp` merupakan _stateless widget_ yang berfungsi untuk mengatur aplikasi secara global dan menentukan tema serta halaman beranda.
- `Scaffold` berfungsi untuk mengatur kerangka dasar halaman dalam aplikasi.
- `Item` merupakan kelas data yang berfungsi untuk merepresentasikan item dengan dua properti, yakni `name` dan `icon`.
- `AppBar` berfungsi untuk menampilkan bagian atas aplikasi yaitu judul "OrbitTune".
- `SingleChildScrollView` berfungsi untuk mengatur konten aplikasi agar dapat di-_scroll_ jika kontennya lebih dari panjang layar.
- `Padding` berfungsi untuk memberikan jarak antara konten dengan tepi layar.
- `Column` berfungsi untuk mengatur widget children secara vertikal.
- `Text` berfungsi untuk menampilkan teks "OrbitTune Instrument Inventory" dengan _style_ yang sesuai.
- `GridView.count` berfungsi untuk menampilakn item dalam bentuk grid dengan jumlah kolom yang sudah ditentukan.
- `ItemCard` merupakan _stateless widget_ yang berfungsi untuk menampilkan setiap item dalam grid.
- `InkWell` berfungsi dalam membuat area yang responsif terhadap sentuhan, yakni mendeteksi tindakan ketika item di-klik.
- `Material` berfungsi dalam memberikan warna latar belakang dan efek responsif saat item di-klik.
- `Icon` berfungsi dalam menampilkan ikon yang sesuai dengan item.
- `SnackBar` berfungsi dalam menampilkan pesan sementara yang muncul di bagian bawah layar ketika item di-klik.

### Jelaskan bagaimana cara kamu mengimplementasikan _checklist_ di atas secara _step-by-step_
1. Pertama, saya memulai proyek Flutter baru dengan menjalankan perintah berikut pada direktori yang sesuai.
```
flutter create orbit_tune
cd orbit_tune
```

2. Selanjutnya saya merapikan struktur pada proyek dengan membuat file baru `menu.dart` pada direktori `orbit_tune/lib` dan menambahkan kode berikut.
```
import 'package:flutter/material.dart';
```

Setelah itu, saya memindahkan `class MyHomePage ...` dari `main.dart` ke `menu.dart` serta menghapus `class _MyHomePage State ...` di `main.dart`.

Karena saya sudah memindahkan class `MyHomePage` ke `menu.dart`, saya menambahkan potongan kode berikut untuk meng-_import_ `menu.dart` ke dalam `main.dart`.
```
import 'package:orbit_tune/menu.dart';
```

3. Kemudian saya membuat _widget_ sederhana pada aplikasi. Saya mengubah terlebih dahulu sifat _widget_ halaman dari _stateful_ menjadi _stateless_ dengan melakukan perubahan seperti berikut pada `menu.dart`.
```
class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            ...
        );
    }
}
```

4. Untuk menambahkan Teks dan Card, saya mendefinisikan suatu tombol pada _class_ baru seperti berikut.
```
class Item {
  final String name;
  final IconData icon;
  final Color color;

  Item(this.name, this.icon, this.color);
}

```

Setelah itu, saya menambahkan kode berikut di bawah `MyHomePage({Key? key}) : super(key: key);` untuk menambahkan tombol-tombol sederhana pada aplikasi.
```
final List<Item> items = [
    Item("Lihat Item", Icons.checklist, Colors.yellow.shade700),
    Item("Tambah Item", Icons.add, Colors.orange.shade600),
    Item("Logout", Icons.logout, Colors.blue.shade600),
];
```

Kemudian saya membuat _class_ `ItemCard` pada `menu.dart` sebagai custom _stateless widget_ untuk menampilkan _card_ setiap menu dan `SnackBar` ketika menu di-klik oleh user.
```
class ItemCard extends StatelessWidget {
  final Item item;

  const ItemCard(this.item, {super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color, // Memberi warna pada card sesuai dengan Item
      child: InkWell(
        // Area responsive terhadap sentuhan
        onTap: () {
          // Memunculkan SnackBar ketika diklik
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
                content: Text("Kamu telah menekan tombol ${item.name}!")));
        },
        child: Container(
          // Container untuk menyimpan Icon dan Text
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

5. Terakhir, saya menambahkan kode berikut pada class `MyHomePage` untuk menampilkan halaman utama aplikasi.
```
@override
Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
        title: const Text(
        'OrbitTune',
        ),
    ),
    body: SingleChildScrollView(
        // Widget wrapper yang dapat discroll
        child: Padding(
        padding: const EdgeInsets.all(10.0), // Set padding dari halaman
        child: Column(
            // Widget untuk menampilkan children secara vertikal
            children: <Widget>[
            const Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                child: Text(
                'OrbitTune Instrument Inventory', // Text yang menandakan toko
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                ),
                ),
            ),
            // Grid layout
            GridView.count(
                // Container pada card kita.
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((Item item) {
                // Iterasi untuk setiap item
                return ItemCard(item);
                }).toList(),
            ),
            ],
        ),
        ),
    ),
);
}
```

6. Untuk melihat tampilan aplikasi yang telah dibuat, jalankan aplikasi dengan perintah `flutter run` pada terminal proyek.