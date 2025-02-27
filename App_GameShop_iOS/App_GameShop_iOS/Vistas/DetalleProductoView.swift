//
//  DetalleProducto.swift
//  App_GameShop_iOS
//
//  Created by Usuario invitado on 25/2/25.
//

import SwiftUICore
import SwiftUI
struct DetalleProductoView: View {
    var producto: Producto
    var agregarAlCarrito: (Producto) -> Void
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Image(producto.imagen)
                .resizable()
                .scaledToFit()
                .frame(height: 250)
                .cornerRadius(10)

            Text(producto.nombre)
                .font(.title)
                .bold()

            Text(producto.descripcion)
                .font(.body)
                .padding()

            Text("Precio: $\(producto.precio, specifier: "%.2f")")
                .font(.headline)
                .foregroundColor(.green)

            Button("Añadir al carrito") {
                agregarAlCarrito(producto)
                dismiss()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .padding()
    }
}

