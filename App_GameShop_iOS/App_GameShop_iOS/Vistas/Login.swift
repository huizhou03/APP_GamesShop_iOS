//
//  Login.swift
//  App_GameShop_iOS
//
//  Created by 周慧 on 24/2/25.
//
import SwiftUI

//Usuarios
struct Usuarios: Codable {
    let usuario: String
    let password: String
}

struct Login: View {
    
    //@Binding var usr: String
    @State var usr: String = ""
    @State var pwd: String = ""
    @State var sesionFallida: Bool = false
    @State var autenticado: Bool = false // Controla si el usuario inició sesión correctamente
    @State var usuariosArray: [Usuarios] = []
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Login")
                    .font(.system(size: 70, weight: .bold, design: .rounded))
                
                TextField ("Username", text: $usr)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .font(.headline)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(6)
                    .padding(.horizontal, 60)
                    .foregroundStyle(Color.black)
                /*.onChange(of: usr) { oldValue, newValue in
                 print("Username nuevo valor: \(newValue)")
                 } Esto es para perfil*/
                
                SecureField ("Password", text: $pwd)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .font(.headline)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(6)
                    .padding(.horizontal, 60)
                    .foregroundStyle(Color.black)
                /*.onChange(of: pwd) { oldValue, newValue in
                 print("Contraseña nuevo valor: \(newValue)")
                 } Esto es para perfil*/
                
                if sesionFallida {
                    Text("Usuario o contraseña incorrecto.")
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: autenticar){
                    Text("Iniciar Sesión")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(8)
                        .padding(.horizontal, 60)
                }
                
                /*Button ("Autenticar ✅") {
                 print("**********")
                 print(" 👤 \(usr)")
                 print("🔑 \(pwd)")
                 }*/
                
                Button ("Limpiar campos 🧹") {
                    usr = ""
                    pwd = ""
                    print("Borraste todo")
                }
                
                Spacer()
                
                // Navegación a la pantalla principal si autenticado es `true`
                NavigationLink(destination: ContentView(), isActive: $autenticado) {
                }
                
                // Botón de registro
                NavigationLink(destination: Registro(usuariosArray: $usuariosArray)) {
                    Text("Registrarse")
                        .font(.headline)
                        .foregroundColor(.blue)
                        .padding()
                }
            }
            .padding()
            .onAppear {
                cargarUsuarios()
            }
        }
    }
    // Método de autenticación (se puede conectar con Firebase en el futuro)
    private func autenticar() {
        if let user = usuariosArray.first(where: { $0.usuario == usr && $0.password == pwd }) {
            usr = ""
            pwd = ""
            autenticado = true
             sesionFallida = false
             print("Login successful for user: \(user.usuario)")
        } else {
            sesionFallida = true
            print("Login failed: Invalid username or password")
        }
    }
    
    // Cargar usuarios guardados en UserDefaults
        private func cargarUsuarios() {
            if let data = UserDefaults.standard.data(forKey: "usuarios"),
               let usuariosGuardados = try? JSONDecoder().decode([Usuarios].self, from: data) {
                usuariosArray = usuariosGuardados
            } else {
                //Array de Usuarios
                usuariosArray = [
                    Usuarios(usuario: "antonluo15@gmail.com", password: "contraAnton"),
                    Usuarios(usuario: "huizhou.universidad@gmail.com", password: "contraHui")
                ]
            }
        }
}

#Preview {
    // Para que la variable @Binding funcione hay que inicializarla en el ContentView:
    //ContentView(usr: .constant(""))
    Login()
}
//Array()
