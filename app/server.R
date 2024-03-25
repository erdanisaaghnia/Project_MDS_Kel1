#==========================SERVER(BACK-END)===============================#
##connect elephant
connectDB <- function() {
  driver <- dbDriver('PostgreSQL')
  DB <- dbConnect(
    driver,
    dbname = "uiwnwnsx", 
    host = "topsy.db.elephantsql.com",
    user = "uiwnwnsx",
    password = "kbudHoamm5hp1Uwz-v67SfLxWvdMvcgy"
  )
}

#----------------------Query1--------------------------#
q1 <- paste0("
     select i.id_invoice, i.id_produk, i.id_cabang, i.id_pelanggan, i.total, i.tanggal, i.pembayaran, 
       c.kota
       from invoice i
       join cabang c on i.id_cabang = c.id_cabang;"
)
#----------------------Query2--------------------------#
q2<-paste0("
      SELECT p.id_produk, p.kategori_produk, p.harga_satuan, p.kuantitas, p.total_harga,
       c.kota FROM produk p
       JOIN cabang c ON p.id_cabang = c.id_cabang;
"
)

#----------------------Query3--------------------------#
q3<-paste0("
   SELECT p.tipe_pelanggan, p.jenis_kelamin, i.pembayaran, c.kota
   FROM pelanggan p
   JOIN invoice i ON p.id_pelanggan = i.id_pelanggan
   JOIN cabang c ON i.id_cabang = c.id_cabang;

"
)

DB <- connectDB()
tabel01 <- data.frame(dbGetQuery(DB, q1))
tabel02 <- data.frame(dbGetQuery(DB, q2))
tabel03 <- data.frame(dbGetQuery(DB, q3))
dbDisconnect(DB)
server <- function(input, output) {
  
  #----------------Tab Cari Invoice-----------------#
  output$filter_1 <- renderUI({
    dateInput(
      inputId = "Invoice_filter",
      label = "Pilih Tanggal",
      value = "2019-01-01",  # Nilai default untuk tanggal
      min = "2019-01-01",     # Tanggal minimum yang dapat dipilih
      max = "2019-03-30"      # Tanggal maksimum yang dapat dipilih
      
    )
  })
  
  output$filter_2 <- renderUI({
    selectInput(
      inputId = "cabang_filter",
      label = "Pilih Cabang (bisa pilih lebih dari 1)",
      multiple = TRUE,
      choices = tabel01$kota)
  })
  
  output$filter_3 <- renderUI({
    selectInput(
      inputId = "pembayaran_filter",
      label = "Silakan Pilih Metode Pembayaran (bisa pilih lebih dari 1)",
      multiple = TRUE,
      choices = tabel01$pembayaran)
  })
  
  data1 <- reactive({
    if (!is.null(input$Invoice_filter)) {
      if (!is.null(input$cabang_filter) && is.null(input$pembayaran_filter)) {
        # Jika hanya tanggal dan filter 2 yang dipilih
        tabel01 %>% 
          filter(tanggal %in% input$Invoice_filter,
                 kota %in% input$cabang_filter)
      } else if (is.null(input$cabang_filter) && !is.null(input$pembayaran_filter)) {
        # Jika hanya tanggal dan filter 3 yang dipilih
        tabel01 %>% 
          filter(tanggal %in% input$Invoice_filter,
                 pembayaran %in% input$pembayaran_filter)
      } else if (!is.null(input$cabang_filter) && !is.null(input$pembayaran_filter)) {
        # Jika tanggal, filter 2, dan filter 3 dipilih
        tabel01 %>% 
          filter(tanggal %in% input$Invoice_filter,
                 kota %in% input$cabang_filter,
                 pembayaran %in% input$pembayaran_filter)
      } else {
        # Jika hanya tanggal yang dipilih tanpa memilih filter 2 dan 3
        tabel01 %>% 
          filter(tanggal %in% input$Invoice_filter)
      }
    } else {
      # Jika tanggal tidak dipilih, kembalikan semua data tanpa filter
      tabel01
    }
  })
  
  
  output$out_tbl1 <- renderDataTable({
    data1()
  })
  
  #----------------Tab Cari Produk------------------#
  output$filter_4 <- renderUI({
    selectInput(
      inputId = "Produk_filter",
      label = "Pilih Kategori Produk (Bisa lebih dari 1)",
      multiple = TRUE,
      choices =  tabel02$kategori_produk)
  })
  
  output$filter_5 <- renderUI({
    selectInput(
      inputId = "cabang_filter",
      label = "Pilih Cabang (Bisa lebih dari 1)",
      multiple = TRUE,
      choices = tabel02$kota)
  })
  data2 <- reactive({
    if (!is.null(input$Produk_filter) && is.null(input$cabang_filter)) {
      # Jika hanya filter produk yang dipilih
      tabel02 %>% 
        filter(kategori_produk %in% input$Produk_filter)
    } else if (is.null(input$Produk_filter) && !is.null(input$cabang_filter)) {
      # Jika hanya cabang yang dipilih
      tabel02 %>% 
        filter(kota %in% input$cabang_filter)
    } else if (!is.null(input$Produk_filter) && !is.null(input$cabang_filter)) {
      # Jika kedua filter dipilih
      tabel02 %>% 
        filter(kategori_produk %in% input$Produk_filter,
               kota %in% input$cabang_filter)
    } else {
      # Jika tidak ada filter yang dipilih, tampilkan semua data
      tabel02
    }
  })
  
  output$out_tbl2 <- renderDataTable({
    data2()
  })
  
  #--------------------Tab Pelanggan------------------#
  output$filter_6 <- renderUI({
    selectInput(
      inputId = "pelanggan_filter",
      label = "Pilih Tipe Pelanggan (Bisa pilih lebih dari 1)",
      multiple = TRUE,
      choices =  tabel03$tipe_pelanggan)
  })
  
  output$filter_7 <- renderUI({
    selectInput(
      inputId = "JK_filter",
      label = "Pilih Jenis Kelamin (Bisa pilih lebih dari 1)",
      multiple = TRUE,
      choices = tabel03$jenis_kelamin)
  })
  
  library(DBI)
  
  data3 <- reactive({
    if (!is.null(input$pelanggan_filter) && is.null(input$JK_filter)) {
      # Jika hanya filter pelanggan yang dipilih
      tabel03 %>% 
        filter(tipe_pelanggan %in% input$pelanggan_filter)
    } else if (is.null(input$pelanggan_filter) && !is.null(input$JK_filter)) {
      # Jika hanya jenis kelamin yang dipilih
      tabel03 %>% 
        filter(jenis_kelamin %in% input$JK_filter)
    } else if (!is.null(input$pelanggan_filter) && !is.null(input$JK_filter)) {
      # Jika kedua filter dipilih
      tabel03 %>% 
        filter(tipe_pelanggan %in% input$pelanggan_filter,
               jenis_kelamin %in% input$JK_filter)
    } else {
      # Jika tidak ada filter yang dipilih, tampilkan semua data
      tabel03
    }
  })
  
  
  output$out_tbl3 <- renderDataTable({
    data3()
  })
  
}