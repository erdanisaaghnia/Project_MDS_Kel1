library(shiny)
library(shinyWidgets)
library(shinydashboard)
library(shinydashboardPlus)
library(RPostgreSQL)
library(DBI)
library(DT)
library(bs4Dash)
library(dplyr)
library(plotly)
library(tidyverse)
library(rvest)
library(shinythemes)

ui <- dashboardPage(
  dashboardHeader(
    title = div(
      img(src = "https://github.com/erdanisaaghnia/Project_MDS_Kel1/blob/main/Doc/Logo_Back.png?raw=true", height = 60, width = 100),
      style = "font-size:25px; color:#000000; font-weight:bold; text-align:center;"
    )
  ),
  dashboardSidebar(
    collapsed = FALSE,
    width = 200,
    style = "background-color: #8FBC8F; font-size:15px; font-weight:bold; padding: 10px; border-radius: 8px;",
    sidebarMenu(
      menuItem(
        text = "Beranda",
        tabName = "beranda",
        icon = icon("home")
      ),
      menuItem(
        text = "Cari Invoice",
        tabName = "invoice",
        icon = icon("file-text")
      ),
      menuItem(
        text = "Cari Produk",
        tabName = "produk",
        icon = icon("box")
      ),
      menuItem(
        text = "Cari Pelanggan",
        tabName = "pelanggan",
        icon = icon("users")
      ),
      menuItem(
        text = "The Team",
        tabName = "info",
        icon = icon("info-circle")
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "beranda",
        div(
          img(src = "https://raw.githubusercontent.com/erdanisaaghnia/Project_MDS_Kel1/main/Doc/Header_bar.png", 
              style = "width: 100%; max-width: 1150px; margin: auto; display: block;"),
          lead = span("Hai, selamat datang di tempat di mana setiap angka memiliki arti. Bersiaplah untuk menghadirkan dampak besar melalui keputusan yang didukung oleh data!", 
                      style = "font-size:20px; font-weight:bold; display: flex; align-items: center; background-color: #4876FF; color: #ffffFF; padding: 15px; border-radius: 5px;"),
          solidHeader = TRUE,
          status = NULL,
          style = "background-color: #ffffff;"
        ),
        tags$head(
          tags$style(HTML(".jumbotron .btn {display: none;  /* Menghapus tombol more */}"))
        ),
        box(
          title = "Langkah Pertama Menuju Keberhasilan!",
          solidHeader = TRUE,
          status = "olive",
          tags$p("Mulai Telusuri Data Anda! Klik tab 'Invoice', 'Produk', atau 'Pelanggan' di bagian atas layar untuk memulai penjelajahan data Anda dengan mudah dan cepat!",
                 style = "background-color: #8FBC8F;color: black;font-size:15px;display: flex;align-items: center;text-align: justify; padding: 10px; border-radius: 5px;"
          ),
          width = 12,
          collapsible = TRUE,
          collapsed = TRUE 
        ),
        tags$h2("Selamat Datang di Istana Langit Mart: Navigasi Penjualan Anda yang Magis!"),
        tags$p("Di sini, setiap klik membuka gerbang menuju dunia yang penuh dengan keajaiban penjualan. Dari lorong produk hingga pelangi pelanggan, sambutlah pengalaman penjualan yang mengesankan di dashboard istana kami."),
        tags$ol(
          tags$li("Cari Invoice: Menemukan Kekayaan dalam Transaksi"),
          tags$p("Gali ke dalam harta karun transaksi Anda dengan lebih dalam. Dengan analisis yang tajam, ungkap rahasia di balik tanggal, cabang, dan metode pembayaran."),
          tags$br(),
          tags$li("Cari Produk: Menemukan Permata di Puncak Langit"),
          tags$p("Telusuri produk dengan mudah dan saksikan penjualan Anda mengudara tinggi. Temukan ceruk yang tersembunyi dan lepaskan potensi terbesar dari inventaris Anda."),
          tags$br(),
          tags$li("Cari Pelanggan: Terbang ke Pelukan Kesetiaan"),
          tags$p("Bergabunglah dengan pelanggan Anda dalam perjalanan yang tak terlupakan. Filter berdasarkan jenis kelamin dan keanggotaan untuk membangun hubungan yang kokoh dengan mereka."),
          tags$br()
        )
      ),
      tabItem(
        tabName = "invoice",
        fluidRow(
          tags$h1("Jelajahi Kekayaan Data: Database Invoice dari Istana Langit Mart", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #8FBC8F; padding: 15px; border-radius: 8px;")
        ),
        fluidRow(
          box(
            tags$h3("Tanggal"),
            tags$p("Pilih Tanggal yang ingin ditampilkan"),
            tags$br(),
            uiOutput("filter_1"),
            width = 4
          ),
          box(
            tags$h3("Filter Cabang"),
            tags$p("Pilih Cabang yang ingin ditampilkan"),
            tags$br(),
            uiOutput("filter_2"),
            width = 4
          ),
          box(
            tags$h3("Filter Pembayaran"),
            tags$p("Pilih Pembayaran yang ingin ditampilkan"),
            tags$br(),
            uiOutput("filter_3"),
            width = 4
          )
        ),
        fluidRow(
          box(
            tags$h3("Tabel"),
            dataTableOutput("out_tbl1"),
            width = 12
          )
        )
      ),
      tabItem(
        tabName = "produk",
        fluidRow(
          tags$h1("Telusuri Harta Karun Produk: Database Istana Langit Supermarket", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #8FBC8F; padding: 15px; border-radius: 8px;")
        ),
        fluidRow(
          box(
            tags$h3("Filter Kategori Produk"),
            tags$p("Pilih Kategori Produk yang ingin ditampilkan"),
            tags$br(),
            uiOutput("filter_4"),
            width = 6
          ),
          box(
            tags$h3("Filter Cabang"),
            tags$p("Pilih Cabang yang ingin ditampilkan"),
            tags$br(),
            uiOutput("filter_5"),
            width = 6
          )
        ),
        fluidRow(
          box(
            tags$h3("Tabel"),
            dataTableOutput("out_tbl2"),
            width = 12
          )
        )
      ),
      tabItem(
        tabName = "pelanggan",
        fluidRow(
          tags$h1("Temukan Jaringan Emas: Database Pelanggan dari Surga Belanja Langit Supermarket", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color: #8FBC8F; padding: 15px; border-radius: 8px;")
        ),
        fluidRow(
          box(
            tags$h3("Tipe_Pelanggan"),
            tags$p("Pilih Tipe pelanggan yang ingin ditampilkan"),
            tags$br(),
            uiOutput("filter_6"),
            width = 6
          ),
          box(
            tags$h3("Filter Jenis Kelamin"),
            tags$p("Pilih Jenis Kelamin yang ingin ditampilkan"),
            tags$br(),
            uiOutput("filter_7"),
            width = 6
          )
        ),
        fluidRow(
          box(
            tags$h3("Tabel"),
            dataTableOutput("out_tbl3"),
            width = 12
          )
        )
      ),
      tabItem(
        tabName = "info",
        fluidRow(
          tags$h1("The Team", style = "font-size:40px;font-weight:bold;display: inline;align-items: center;background-color:#8FBC8F; padding: 15px; border-radius: 8px;")
        ),
        fluidRow(
          box(
            title = "Bergabunglah dalam Kebersamaan: Kenali Keistimewaan Kelompok 1 Sekarang!",
            solidHeader = TRUE,
            status = NULL,
            width = 12,
            collapsible = TRUE,
            collapsed = TRUE,
            tags$p("Tembus Langit dengan Data: Proyek Unggulan Kelompok 1 dari Mata Kuliah Manajemen Data Statistika (STA1582) di IPB University, Menghadirkan Dashboard Penjualan Istana Langit Mart."),  
            tags$h3("Anggota :"),
            fluidRow(
              box(
                title = p(HTML("Nabila Tri Amanda As Database Manager")),
                solidHeader = TRUE,
                status = "olive",
                background = "olive",
                width = 12,
                collapsible = TRUE,
                collapsed = TRUE,
                img(src = "https://raw.githubusercontent.com/erdanisaaghnia/Project_MDS_Kel1/main/Doc/Nabilu.png", width = "100%", style = "margin-bottom: 20px;")
              )
            ),
            fluidRow(
              box(
                title = p(HTML("Fajar Athallah Yusuf sebagai Back-end Shiny Developer")),
                solidHeader = TRUE,
                status = "olive",
                background = "olive",
                width = 12,
                collapsible = TRUE,
                collapsed = TRUE,
                img(src = "https://raw.githubusercontent.com/erdanisaaghnia/Project_MDS_Kel1/main/Doc/Fajar.png", width = "100%", style = "margin-bottom: 20px;")
              )
            ),
            fluidRow(
              box(
                title = p(HTML("Erdanisa Aghnia Ilmani Front-end Shiny Developer")),
                solidHeader = TRUE,
                status = "olive",
                background = "olive",
                width = 12,
                collapsible = TRUE,
                collapsed = TRUE,
                img(src = "https://raw.githubusercontent.com/erdanisaaghnia/Project_MDS_Kel1/main/Doc/Erda.png", width = "100%", style = "margin-bottom: 20px;")
              )
            ),
            fluidRow(
              box(
                title = p(HTML("Anwar Fajar Rizki sebagai Technical Writer")),
                solidHeader = TRUE,
                status = "olive",
                background = "olive",
                width = 12,
                collapsible = TRUE,
                collapsed = TRUE,
                img(src = "https://raw.githubusercontent.com/erdanisaaghnia/Project_MDS_Kel1/main/Doc/Anwar.png", width = "100%", style = "margin-bottom: 20px;")
              )
            ),
            tags$p("Info lebih lanjut mengenai projek database ini dapat diakses di github pengembang."),
            tags$a(href="https://github.com/erdanisaaghnia/Project_MDS_Kel1/", "link github")
          )
        )
      )
    )
  ),
  controlbar = dashboardControlbar(
    skin = "light",
    width = "300px"
  ),
  title = "Istana Langit Mart",
  footer = dashboardFooter(right = "© 2024 Kelompok 1")
)

