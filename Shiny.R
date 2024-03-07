library(shiny)
library(shinydashboard)

# Membuat aplikasi Shiny
ui <- dashboardPage(
  dashboardHeader(
    title = "Dashboard Supermarket",
    tags$li(class = "dropdown",
            tags$img(src = "https://github.com/erdanisaaghnia/Project_MDS_Kel1/blob/main/LOGO.png",
                     style = "max-height: 50px; padding-top: 10px;")
    )
  ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Beranda", tabName = "beranda", icon = icon("home")),
      menuItem("Produk", tabName = "produk", icon = icon("box")),
      menuItem("Pelanggan", tabName = "pelanggan", icon = icon("users")),
      menuItem("Invoice", tabName = "invoice", icon = icon("file-text")),
      menuItem("Cabang", tabName = "cabang", icon = icon("map-marker"))
    )
  ),
  dashboardBody(
    tabItems(
      # Tab Beranda
      tabItem(tabName = "beranda",
              fluidRow(
                box(title = "Selamat Datang", "Ini adalah dashboard supermarket.")
              )
      ),
      
      # Tab Produk
      tabItem(tabName = "produk",
              fluidRow(
                # Tambahkan konten di sini untuk menampilkan informasi produk
              )
      ),
      
      # Tab Pelanggan
      tabItem(tabName = "pelanggan",
              fluidRow(
                # Tambahkan konten di sini untuk menampilkan informasi pelanggan
              )
      ),
      
      # Tab Invoice
      tabItem(tabName = "invoice",
              fluidRow(
                # Tambahkan konten di sini untuk menampilkan informasi invoice
              )
      ),
      
      # Tab Cabang
      tabItem(tabName = "cabang",
              fluidRow(
                # Tambahkan konten di sini untuk menampilkan informasi cabang
              )
      )
    )
  )
)

server <- function(input, output) {
  # Tambahkan logika server di sini
}

shinyApp(ui = ui, server = server)