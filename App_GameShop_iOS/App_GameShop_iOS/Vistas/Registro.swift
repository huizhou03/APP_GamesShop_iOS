//
//  Registro.swift
//  App_GameShop_iOS
//
//  Created by 周慧 on 26/2/25.
//
import SwiftUI

// Nueva vista de Registro
struct Registro: View {
    @Binding var usuariosArray: [Usuarios]
    @State var nuevoUsuario: String = ""
    @State var nuevaContraseña: String = ""
    @State var registroExitoso: Bool = false

    var body: some View {
        VStack {
            Text("Registro")
                .font(.system(size: 50, weight: .bold, design: .rounded))
            
            TextField("Nuevo Usuario", text: $nuevoUsuario)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.headline)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)
                .padding(.horizontal, 60)
            
            SecureField("Nueva Contraseña", text: $nuevaContraseña)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.headline)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(6)
                .padding(.horizontal, 60)
            
            if registroExitoso {
                Text("Registro exitoso")
                    .foregroundColor(.green)
                    .padding()
            }
            
            Button("Registrar") {
                print("Usuario registrado: \(nuevoUsuario)")
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .cornerRadius(8)
            .padding(.horizontal, 60)
            
            Spacer()
        }
        .padding()
    }
    
    private func registrarUsuario() {
        guard !nuevoUsuario.isEmpty, !nuevaContraseña.isEmpty else {
            return
        }

        let nuevo = Usuarios(usuario: nuevoUsuario, password: nuevaContraseña)
        usuariosArray.append(nuevo) // Agrega al array
        
        // Guarda en UserDefaults
        if let data = try? JSONEncoder().encode(usuariosArray) {
            UserDefaults.standard.set(data, forKey: "usuarios")
        }

        registroExitoso = true
        nuevoUsuario = ""
        nuevaContraseña = ""
    }
}
