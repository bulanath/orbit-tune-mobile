# Tugas PBP Ganjil 2023/2024

**Nama    : Bulan Athaillah Permata Wijaya**<br>
**NPM     : 2206032135**<br>
**Kelas   : PBP C**<br>

## Tugas 9
### Apakah bisa kita melakukan pengambilan data JSON tanpa membuat model terlebih dahulu? Jika iya, apakah hal tersebut lebih baik daripada membuat model sebelum melakukan pengambilan data JSON?
Ya bisa, akan tetapi hal tersebut tidak disarankan karena kita tidak dapat mengetahui tipe data yang diambil dari JSON sehingga kita harus mengaksesnya dengan cara yang berbeda-beda tergantung dengan tipe datanya. Kita juga tidak dapat melakukan validasi terhadap data yang kita ambil sehingga data yang diambil bersifat tidak valid. Membuat model terlebih dahulu akan memudahkan kita dalam mengubah data dari JSON menjadi objek dart.

### Jelaskan fungsi dari CookieRequest dan jelaskan mengapa _instance_ CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
`CookieRequest` merupakan salah satu class pada _package_ `pbp_django_auth.dart` yang berfungsi untuk mengambil cookie dari hasil _request_ autentikasi login dan logout ke server Django. `CookieRequest` perlu untuk dibagikan ke semua komponen dalam aplikasi Flutter agar dapat digunakan oleh semua _widget_ pada aplikasi untuk melakukan _request_ ke server Django serta agar status cookies pada aplikasi konsisten.

### Jelaskan mekanisme pengambilan data dari JSON hingga dapat ditampilkan pada Flutter.
1. Membuat model kustom dengan memanfaatkan _website_ Quicktype untuk membuat data JSON dari _endpoint_ JSON `/json` yang telah dibuat pada tugas Django.
2. Menambahkan dependensi HTTP dengan menambahkan _package_ `http` pada proyek Flutter dan menambhakan `<uses-permission android:name="android.permission.INTERNET" />` pada file `android/app/src/main/AndroidManifest.xml` agar dapat memiliki akses internet.
3. Melakukan _fetch_ data dengan mengimplementasikan fungsi _asyncrhonous_ dan mengirim _request_ HTTP ke server Django untuk mengambil data JSON.
4. Mengubah data JSON menjadi objek dart menggunakan _utility class_ yang sudah dibuat sehingga dapat menampilkan data pada _widget_ dengan memasukkannya sebagai _property_ dari _widget_.

### Jelaskan mekanisme autentikasi dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
1. Pengguna memasukkan _username_ dan _password_ mereka pada halaman `Login`.
2. Ketika tombol _login_ ditekan, fungsi `login` pada `CookieRequest` akan mengirimkan HTTP _request_ dengan _endpoint_ URL proyek Django.
3. Pada Django akan dilakukan autentikasi kemudian jika berhasil maka Django akan mengirimkan pesan sukses beserta _session cookie_ dari user.
4. Setelah server memberikan HTTP _response_, Flutter akan mengambil _session cookie_ dari respon tersebut dan menyimpannya pada `CookieRequest` lalu kemudian pengguna diarahkan ke `MyHomePage` dan muncul tampilan selamat datang.

### Sebutkan seluruh _widget_ yang kamu pakai pada tugas ini dan jelaskan fungsinya masing-masing.
- `InkWell` berfungsi untuk membuat _widget_ yang dapat diklik.
- `ElevatedButton` berfungsi untuk membuat _button_ dengan tampilan naik yang merespon sentuhan atau klik.
- `SizedBox` berfungsi untuk membuat _widget_ dengan ukuran yang sudah ditentukan.
-  `ListView` berfungsi untuk menampilkan sekumpulan data dalam bentuk _list_ yang dapat di-_scroll_.
- `ListItem` berfungsi untuk membuat item pada `ListView`.
- `FutureBuilder` berfungsi untuk membangun _widget_ secara _asynchronous_.
- `TextFormField` berfungsi untuk membuat input secara umum.
- `Column` berfungsi untuk menampilkan komponen secara vertikal.
- `Padding` berfungsi untuk memberikan jarak sekitar elemen atau _widget_.

### Jelaskan bagaimana cara kamu mengimplementasikan _checklist_ di atas secara _step-by-step_
1. Pertama, saya membuat halaman `Login` dan mengintegrasikan aplikasi Flutter dengan sistem autentikasi Django. Pada tugas Django sebelumnya, saya membuat aplikasi baru `authetication` dengan menjalankan `python manage.py startapp authentication` pada terminal. Setelah itu, saya membuat fungsi `login` pada `views.py` untuk menangani proses autentikasi login.

2. Melakukan instalasi _dependencies_ `provider` dan `pbp_django_auth` dan memodifikasi _root widget_ untuk menyediakan _instance_ `CookieRequest` ke semua _child widgets_ pada `main.dart`. Kemudian saya membuat halaman `Login` dengan membuat berkas baru `lib/screens/login.dart`.

3. Membuat model kustom dan _utility function_ untuk data yang akan diambil dari JSON seperti yang telah dijelaskan pada pertanyaan sebelumnya terkait mekanisme pengambilan data JSON.

4. Menambahkan fungsi view baru `create_product_flutter` pada `main/views.py` di proyek tugas Django agar form Flutter dapat terintegrasi dengan layanan Django serta menambahkan `CookieRequest` dan mengubah status `onPressed: ()` menjadi _async_ serta menambahkan kode sesuai dengan apa yang telah diajarkan pada tutorial 8 ke kode Flutter.

5. Mengimplementasikan fitur logout pada aplikasi dengan menambahkan fungsi view baru pada `authentication/views.py` serta melakukan _routing_ URL. Kemudian menambahkan `CookieRequest` dan mengubah status `onTap: ()` menjadi _async_ serta menambahkan kode sesuai dengan apa yang telah diajarkan pada tutorial 8 pada `lib/widgets/item_card.dart`.

6. Membuat halaman `ItemDetailPage` agar jika setiap item pada `ItemPage` diklik dapat memunculkan halaman baru yang menunjukkan detail setiap item. Pertama, saya melakukan _routing_ pada `list_item.dart` dengan kode berikut.
```
...
itemCount: snapshot.data!.length,
itemBuilder: (_, index) => InkWell(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemDetailPage(item: snapshot.data![index]),
      ),
    );
  },
),
```
Kemudian saya menambahkan file baru `lib/screens/item_detail.dart` dengan kode sebagai berikut.
```
class ItemDetailPage extends StatelessWidget {
  final Item item;

  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.fields.name),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${item.fields.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Brand: ${item.fields.brand}'),
            SizedBox(height: 10),
            Text('Type: ${item.fields.type}'),
            SizedBox(height: 10),
            Text('Amount: ${item.fields.amount}'),
            SizedBox(height: 10),
            Text('Description: ${item.fields.description}'),
          ],
        ),
      ),
    );
  }
}
```

## Tugas 8
###  Jelaskan perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()`, disertai dengan contoh mengenai penggunaan kedua metode tersebut yang tepat!
Pada `Navigator.push()`, ditambahkan _route_ baru di atas _route_ yang sudah ada ke _navigation stack_. Halaman sebelumnya tetap ada di dalam _stack_ sehingga pengguna dapat kembali ke halaman tersebut. Contoh `Navigator.push()` pada program adalah
```
if (item.name == "Tambah Item") {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ItemFormPage(),
    ),
  );
}
```

Sedangkan pada `Navigator.pushReplacement()`, digantikan _route_ baru di atas _route_ yang sudah ada ke _navigation stack_ sehingga halaman sebelumnya dihapus dari _stack_ dan pengguna tidak dapat kembali ke halaman sebelumnya. Contoh `Navigator.pushReplacement()` pada program adalah
```
ListTile(
  leading: const Icon(Icons.home_outlined),
  title: const Text('Main Page'),
  // Bagian redirection ke MyHomePage
  onTap: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
  },
),
```

### Jelaskan masing-masing _layout_ widget pada Flutter dan konteks penggunaannya masing-masing!
- `Scaffold` digunakan untuk menyediakan struktur dasar untuk sebuah halaman dalam aplikasi Flutter. Pada tugas ini `Scaffold` digunakan sebagai kerangka kerja untuk membangun tata letak halaman `MyHomePage`, `ItemFormPage`, dan `ItemListPage`.
- `Column` digunakan untuk mengatur posisi _child widget_ secara vertikal. Contoh penggunaan `Column` pada tugas ini adalah untuk menyusun elemen form pada halaman `ItemFormPage` secara vertikal.
- `Row` digunakan untuk mengature posisi _child widget_ secara hortizontal.
- `Align` digunakan untuk menempatkan _child widget_ pada posisi tertentu di sebuah halaman. Contoh penggunaan `Align` pada tugas ini adalah untuk menempatkan button `save` pada halaman `ItemFormPage` menggunakan `Alignment.bottomCenter`.
- `Drawer` digunakan untuk menampilkan menu sisi dalam aplikasi. Contoh penggunaan `Drawer` pada tugas ini adalah untuk menampilkan `LeftDrawer` sebagai menu navigasi di sebelah kiri layar.
- `ListView` digunakan untuk menyusun _child element_ dalam satu arah, baik vertikal maupun horizontal. Contoh penggunaan `ListView` pada tugas ini adalah untuk menampilkan elemen `ListTile` dan `DrawerHeader` pada halaman `ItemFormPage`.
- `Container` digunakan sebagai wadah untuk menyusun dan memposisikan _child widget_.
- `Stack` digunakan untuk menumpuk _child widget_ di atas satu sama lain, misalnya untuk menempatkan _widget_ teks dan gambar secara bersamaan.
- `Wrap` berfungsi untuk menyusun _child widget_ dalam sebuah baris atau kolom dan memindahkannya ke baris atau kolom baru jika sudah tidak cukup. Intinya, _widget_ ini digunakan untuk menyusun _widget_ dalam ruang terbatas tanpa menyebabkan _overflow_.

### Sebutkan apa saja elemen input pada form yang kamu pakai pada tugas kali ini dan jelaskan mengapa kamu menggunakan elemen input tersebut!
Untuk menerima elemen input pada form, saya menggunakan _widget_ `TextFormField`. `TextFormField` digunakan karena dapat menerima jawaban bebas sesuai dengan apa yang pengguna ketik dan secara otomatis menyediakan validasi input. Elemen input yang digunakan pada tugas ini adalah:
- `Name`, untuk menerima nama instrumen dari pengguna.
- `Brand`, untuk menerima merek instrumen dari pengguna.
- `Type`, untuk menerima tipe instrumen dari pengguna.
- `Amount`, untuk menerima jumlah instrumen dari pengguna.
- `Description`, untuk menerima deskrpsi kondisi instrumen dari pengguna.

### Bagaimana penerapan _clean architecture_ pada aplikasi Flutter?
_Clean architecture_ merupakan sebuah prinsip dalam pengembangan aplikasi yang melakukan pemisahan kepentingan (_separation of concerns_) sehingga menciptakan kode yang modular. _Clean architecture_ terbagi menjadi beberapa _layer_, yaitu:
- `Screens` berisi komponen UI seperti _widget_, layar, dan tampilan. Lapisan ini befungsi untuk menangani interaksi pengguna dan me-_render_ antarmuka pengguna.
- `Domain` berfungsi untuk mengatur logika terkait bagaimana elemen-elemen pada aplikasi berinteraksi.
- `Data` berfungsi untuk mengambil dan menyimpan data.

Untuk tugas ini, penerapan _clean architecture_ dilakukan saat melakukan _refactoring file_ untuk melakukan pemisahan lapisan `Screens` untuk tampilan UI saja.

### Jelaskan bagaimana cara kamu mengimplementasikan _checklist_ di atas secara _step-by-step_
1. Pertama, saya menambahkan halaman formulir dengan membuat `itemlist_form.dart` pada `lib/screens`. Kode yang ditambahkan adalah sebagai berikut.
```
import 'package:flutter/material.dart';
import 'package:orbit_tune/screens/menu.dart';
import 'package:orbit_tune/screens/itemlist_form.dart';
import 'package:orbit_tune/screens/list_item.dart';
import 'package:orbit_tune/models/item.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  'OrbitTune',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("Track All of Your Instruments Here!",
                    // Menambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Main Page'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('Lihat Item'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              /*
              Routing ke ShopFormPage di sini, setelah halaman ShopFormPage sudah dibuat.
              */
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => ItemListPage(items: items))
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Tambah Item'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              /*
              Routing ke ShopFormPage di sini, setelah halaman ShopFormPage sudah dibuat.
              */
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => ItemFormPage())
              );
            },
          ),
        ],
      ),
    );
  }
}
```

2. Agar halaman tambah item dapat diakses melalui halaman utama, saya menambahkan kode berikut pada `item_card.dart` di direktori `lib/screens`.
```
if (item.name == "Tambah Item") {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ItemFormPage(),
    ),
  );
}
```

3. Kemudian saya membuat `list_item.dart` pada `lib/screens` untuk menambah halaman Lihat Item. Kode yang ditambahkan adalah sebagai berikut.
```
import 'package:flutter/material.dart';
import 'package:orbit_tune/widgets/left_drawer.dart';
import 'package:orbit_tune/models/item.dart';

class ItemListPage extends StatelessWidget {
  final List<Item> items;

  const ItemListPage({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daftar Album',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0), // Jarak kiri kanan
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return Card(
              color: Colors.white, // Warna putih
              elevation: 4.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          items[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Brand: ${items[index].brand}"),
                        Text("Type: ${items[index].type}"),
                        Text("Amount: ${items[index].amount}"),
                        Text("Description: ${items[index].description}"),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
```

4. Agar halaman lihat item dapat diakses melalui halaman utama, saya menambahkan kode berikut pada `item_card.dart` di direktori `lib/screens`.
```
if (item.name == "Lihat Item") {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ItemListPage(items: items),
    ),
  );
}
```

5. Terakhir, saya menambahkan Drawer pada aplikasi dengan membuat `left_drawer.dart` pada `lib/widgets` agar menu aplikasi dapat diakses dari Drawer pada sebelah kiri aplikasi. Kode yang ditambahkan adalah sebagai berikut.
```
import 'package:flutter/material.dart';
import 'package:orbit_tune/screens/menu.dart';
import 'package:orbit_tune/screens/itemlist_form.dart';
import 'package:orbit_tune/screens/list_item.dart';
import 'package:orbit_tune/models/item.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              children: [
                Text(
                  'OrbitTune',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Padding(padding: EdgeInsets.all(10)),
                Text("Track All of Your Instruments Here!",
                    // Menambahkan gaya teks dengan center alignment, font ukuran 15, warna putih, dan weight biasa
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w100,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Main Page'),
            // Bagian redirection ke MyHomePage
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(),
                  ));
            },
          ),
          ListTile(
            leading: const Icon(Icons.checklist),
            title: const Text('Lihat Item'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              /*
              Routing ke ShopFormPage di sini, setelah halaman ShopFormPage sudah dibuat.
              */
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => ItemListPage(items: items))
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('Tambah Item'),
            // Bagian redirection ke ShopFormPage
            onTap: () {
              /*
              Routing ke ShopFormPage di sini, setelah halaman ShopFormPage sudah dibuat.
              */
              Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => ItemFormPage())
              );
            },
          ),
        ],
      ),
    );
  }
}
```

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