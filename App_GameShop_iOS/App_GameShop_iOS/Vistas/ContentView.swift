//
//  ContentView.swift
//  App_GameShop_iOS
//
//  Created by 周慧 on 13/2/25.
//

import SwiftUI

//Perfil
struct PerfilView: View {
    var body: some View{
        NavigationStack{
            Image(systemName: "person.circle")
            //...Añadimos código para editar aquí
            Text("Página de Perfil")
                .navigationTitle("Perfil")
        }
    }
}

//Tienda
struct TiendaView: View {
    @State private var productos = [Producto]()
    @State private var productoSeleccionado: Producto? = nil
    @State private var mostrarSheet = false
    var body: some View{
        NavigationView {
                        List(productos) { producto in
                            HStack {
                                Image(producto.imagen) // Asegúrate de tener las imágenes en tu proyecto
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .cornerRadius(10)
                                
                                VStack(alignment: .leading) {
                                    Text(producto.nombre)
                                        .font(.headline)
                                    Text("$\(producto.precio, specifier: "%.2f")")
                                        .font(.subheadline)
                                        .foregroundColor(.green)
                                }
                            }
                            .padding()
                            .onTapGesture {
                                productoSeleccionado = producto
                                mostrarSheet = true
                            }
                        }
                        .sheet(isPresented: $mostrarSheet) {
                            if let producto = productoSeleccionado {
                                DetalleProductoView(producto: producto, agregarAlCarrito: agregarAlCarrito)
                            } else {
                                Text("Cargando...")
                            }
                        }
                        .navigationTitle("Tienda")
                }
        .onAppear {
            loadProductos()
        }
    }
    func loadProductos() {
            guard let url = Bundle.main.url(forResource: "productos", withExtension: "json") else {
                print("No se pudo encontrar el archivo JSON.")
                return
            }
            
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let decodedProductos = try decoder.decode(ProductosResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self.productos = decodedProductos.Productos
                }
                
            } catch {
                print("Error al decodificar el JSON: \(error)")
            }
        }
    func agregarAlCarrito(producto: Producto) {
        guard let url = Bundle.main.url(forResource: "carrito", withExtension: "json") else {
            print("No se pudo encontrar el archivo carrito.json.")
            return
        }
        
        var carrito = [Producto]()

        do {
            let data = try Data(contentsOf: url)
            var carrito = try JSONDecoder().decode([Producto].self, from: data)
            carrito.append(producto)

            let updatedData = try JSONEncoder().encode(carrito)
            try updatedData.write(to: url)
            print("✅ Producto añadido al carrito.")
        } catch {
            print("❌ Error al añadir producto al carrito: \(error.localizedDescription)")
        }
    }
}

//Carrito
struct CarritoView: View {
    var body: some View{
        NavigationStack{
            Image(systemName: "person.circle")
            //...Añadimos código para editar aquí
            Text("Página de Carrito")
                .navigationTitle("Carrito")
        }
    }
}

//Pedidos
struct PedidosView: View {
    var body: some View{
        NavigationStack{
            Image(systemName: "person.circle")
            //...Añadimos código para editar aquí
            Text("Página de Pedidos")
                .navigationTitle("Pedidos")
        }
    }
}

// Esta es la vista principal de la aplicación que contiene el TabView
struct ContentView: View {
    var body: some View {
        //Barra de la parte inferior
        TabView {
            //Cuando hago click en perfil
            PerfilView()
                .tabItem{
                    Label("Perfil", systemImage: "person.circle")
                }
            // tag se utiliza para identificar cada tab de forma única
                .tag(1)
            
            TiendaView()
                .tabItem{
                    Label("Tienda", systemImage: "house")
                }
                .tag(2)
            
            CarritoView()
                .tabItem{
                    Label("Carrito", systemImage: "cart")
                }
                .tag(3)
            
            PedidosView()
                .tabItem{
                    Label("Pedidios", systemImage: "cube.box")
                }
                .tag(4)
        }
    }
}

#Preview {
    ContentView()
}
