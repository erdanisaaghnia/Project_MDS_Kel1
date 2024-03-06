
<p align="center">
  <img width="500" height="300" src="https://github.com/erdanisaaghnia/Project_MDS_Kel1/blob/main/LOGO.png">
</p>

<div align="center">

# Database Penjualan Supermarket Istana Langit

## INFO
**Database Penjualan Supermarket Istana Langit**

[Tentang](#scroll-tentang)
•
[Screenshot](#rice_scene-screenshot)
•
[Demo](#dvd-demo)
•
[Dokumentasi](#blue_book-dokumentasi)

</div>

## :bookmark_tabs: Menu

- [Tentang](#scroll-tentang)
- [Screenshot](#rice_scene-screenshot)
- [Demo](#dvd-demo)
- [Dokumentasi](#blue_book-dokumentasi)
- [Requirements](#exclamation-requirements)
- [Skema Database](#floppy_disk-skema-database)
- [ERD](#rotating_light-erd)
- [Deskripsi Data](#heavy_check_mark-deskripsi-data)
- [Struktur Folder](#open_file_folder-struktur-folder)
- [Tim Pengembang](#smiley_cat-tim-pengembang)

## :scroll: Tentang

Project akhir mata kuliah Manajemen Data Statistika mengambil topik tentang Penjualan Supermarket Istana Langit. Project ini mengspesifikasikan cabang dan produk berkinerja tinggi, menganalisis pola penjualan berbagai produk, dan memahami perilaku pelanggan. Kumpulan data yang digunakan dalam proyek ini bersumber dari Kaggle Walmart Sales Forecasting Competition. Hasil yang diharapkan adalah terbentuknya sebuah platform manajemen database berupa web application yang dapat memudahkan user dalam menganalisis untuk meningkatkan dan mengoptimalkan strategi penjualan.

## :rice_scene: Screenshot

<p align="center">
  <img width="900" height="500" src="dashboard sementara.png">
</p>

## :dvd: Demo

Berikut merupakan link untuk shinnyapps atau dashboard dari project kami:
https://akmarinak98.shinyapps.io/database_publikasi_statistika/

## :blue_book: Dokumentasi 

Dokumentasi penggunaan aplikasi database. Anda dapat juga membuat dokumentasi lives menggunakan readthedocs.org (opsional).

## :exclamation: Requirements

- Scrapping data menggunakan package R yaitu `rvest` dengan pendukung package lainnya seperti `tidyverse`,`rio`,`kableExtra` dan `stingr`  
- RDBMS yang digunakan adalah PostgreSQL dan ElephantSQL
- Dashboard menggunakan `shinny`, `shinnythemes`, `bs4Dash`, `DT`, dan `dplyr` dari package R

## :floppy_disk: Skema Database

Menggambarkan struktur *primary key* **produk**, **invoice**, **pelanggan** dan **cabang** dengan masing-masing *foreign key* dalam membangun relasi antara tabel atau entitas.
<p align="center">
  <img width="600" height="400" src="Doc/SKEMA.png">
</p>

## :rotating_light: ERD

  ERD (Entity Relationship Diagram) menampilkan hubungan antara entitas dengan atribut. Pada project ini, entitas invoice terdapat tiga atribut yang berhubungan dengan atribut pada entitas lain, yaitu Id_Produk berhubungan dengan entitas produk, Id_Cabang berhubungan dengan entitas cabang, Tipe_Pelanggan berhubungan dengan entitas pelanggan. Selain itu, entitas produk dan entitas cabang saling berhubungan pada atribut Id_Produk.


<p align="center">
  <img width="800" height="400" src="Doc/ERD.png">
</p>

## :heavy_check_mark: Deskripsi Data
Data proyek ini diperoleh dari Kaggle Walmart Sales Forecasting Competition dan mencakup transaksi penjualan dari tiga cabang supermarket yang masing-masing berlokasi di Mandalay, Yangon, dan Naypyitaw. Berisi tentang tabel-tabel yang digunakan berikut dengan sintaks SQL DDL (CREATE).

### Create Database
Databse Penjualan Supermarket Istana Langit menyimpan informasi yang mewakili atribut data yang saling berhubungan untuk kemudian dianalisis.
```sql
CREATE DATABASE data_penjualan
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
```
### Create Table Produk
Table Produk memberikan informasi kepada user mengenai info produk yang ada di supermarket Istana Langit, sehingga user dapat mengetahui id produk, kategori produk, harga satuan dari produk tersebut, jumlah produk yang terjual, total penjualan produk tersebut dan id cabang dari produk tersebut. Berikut deskripsi untuk setiap tabel instansi.
| Attribute          | Type                  | Description                     |
|:-------------------|:----------------------|:--------------------------------|
| ID_Produk          | smallint              | Kode Produk                     |
| Kategori_Produk    | character varying(100)| Kategori Produk                 |
| Harga_Satuan       | DECIMAL(10,2)         | Harga Satuan Produk             |
| Kuantitas          | smallint	             | Jumlah Penjulan Produk          |
| Total_Harga        | DECIMAL(12,20)	     | Total Harga Penjualan           |
| ID_Cabang          | character varying(5)  | Kode Cabang                     |

dengan script SQL sebagai berikut:
```sql
CREATE TABLE IF NOT EXISTS public.Produk (
    ID_Produk int NOT NULL PRIMARY KEY,
	Kategori_Produk varchar (100),
    Harga_Satuan decimal(10,2) NOT NULL,
    Kuantitas int NOT NULL,
	Total_Harga decimal (12,2),
	ID_Cabang varchar(5)
);
```
### Create Table Cabang
Table cabang memberikan informasi yang memudahkan user mengetahui tempat cabang dari penjualan suatu produk melalui id cabang, id produk dan kota asal cabang tersebut berada. Id cabang adalah kode yang digunakan untuk membedakan nama cabang yang sama pada tiap produk yang terjual. Berikut deskripsi untuk setiap tabel cabang.
| Attribute          | Type                  | Description                     |
|:-------------------|:----------------------|:--------------------------------|
| ID_Cabang          | character varying(5)  | Kode Cabang                     |
| ID_Produk          | smallint              | Kode Produk                     |
| Kota               | character varying(30) | Kota Asal Cabang                |

dengan script SQL sebagai berikut:
```sql
CREATE TABLE IF NOT EXISTS public.Cabang (
    ID_Cabang varchar(30) NOT NULL,
	ID_Produk int NOT NULL,
    Kota varchar(30) NOT NULL,
    PRIMARY KEY (ID_Cabang)
);
```
### Create Table Invoice
Table invoice menyajikan informasi lengkap mengenai sebuah transaksi penjualan. Selain dapat mengetahui penjualan, user juga akan mendapatkan informasi tanggal dan waktu penjualan sebuah produk. Tipe pelanggan, produk yang terjual, cabang tempat transaksi terjadi, pembayaran hingga penilaian terhadap transaksi penjualan tersaji pada table ini. Lebih lanjut, informasi spesifik mengenai id invoice, id produk, id cabang dan tipe pelanggan dapat diketahui melalui table ini.  Berikut deskripsi untuk setiap tabel invoice.
| Attribute                  | Type                  | Description                     		       	|
|:---------------------------|:----------------------|:-------------------------------------------------|
| ID_Invoice                 | character varying(30) | Id Invoice                      		       	|
| ID_Produk                  | smallint              | Id Produk                 		       	|
| ID_Cabang                  | character varying(5)  | Id Cabang                  		       	|	
| Tipe_Pelanggan             | character varying(30) | Tipe pelanggan                	               	|
| Tanggal                    | datetime              | Tanggal Transaksi                               	|
| Waktu    	             | time                  | Waktu Transaksi                                 	|
| Pembayaran                 | character varying(30) | Jumlah Pembayaran    			       	|
| Penilaian		     | float(2,1)            | Penilaian terhadap penjualan produk		|	

dengan script SQL sebagai berikut:              
```sql
CREATE TABLE IF NOT EXISTS public.Invoice (
    ID_Invoice varchar(30) NOT NULL ,
    ID_Produk int NOT NULL,
	ID_Cabang varchar(5) NOT NULL,
    Tipe_Pelanggan varchar(30) NOT NULL,
	Total decimal (12,4) NOT NULL,
	Tanggal date Not NULL,
	Waktu time NOT NULL,
	Pembayaran varchar (30) NOT NULL,
	Penilaian float NOT NULL,
	PRIMARY KEY (ID_Invoice)
);
```
### Create Table Pelanggan
Table pelanggan memberikan informasi kepada user mengenai beberapa identitas pelanggan. User dapat mengetahui tipe pelanggan dan jenis kelamin pelanggan. Berikut deskripsi untuk setiap tabel penulis.
| Attribute                  | Type                  | Description                     		       	|
|:---------------------------|:----------------------|:-------------------------------------------------|
| Tipe_Pelanggan             | character varying(30) | Tipe Pelanggan (Member/non member)              	|
| Jenis_Kelamin              | character varying(10) | Jenis Kelamin Pelanggan               		|


dengan script SQL sebagai berikut:
```sql
CREATE TABLE IF NOT EXISTS public.Pelanggan (
    Tipe_Pelanggan varchar(30),
	Jenis_Kelamin varchar(30),
	PRIMARY KEY (Tipe_Pelanggan)
);
```
## :open_file_folder: Struktur Folder

```
.
├── app           # ShinyApps
│   ├── css
│   │   ├── **/*.css
│   ├── server.R
│   └── ui.R
├── data 
│   ├── csv
│   │   ├── **/*.css
│   └── sql
|       └── db.sql
├── src           # Project source code
├── doc           # Doc for the project
├── .gitignore
├── LICENSE
└── README.md
```

## :smiley_cat: Tim Pengembang
+ Database Manager : [Nabila Tri Amanda](https://github.com/nbltriamanda) (G1501231068)
+ Frontend Developer : [Erdanisa Aghnia Ilmani](https://github.com/) (G1501231032)
+ Backend Developer : [Fajar Athallah Yusuf](https://github.com/) (G1501231038)
+ Technical Writer : [Anwar Fajar Rizki](https://github.com/) (G1501231003)
 

 
