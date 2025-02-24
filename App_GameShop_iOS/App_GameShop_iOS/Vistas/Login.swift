//
//  Login.swift
//  App_GameShop_iOS
//
//  Created by 周慧 on 24/2/25.
//
import SwiftUI

struct Login: View {
    
    //@Binding var usr: String
    @State var usr: String = ""
    @State var pwd: String = ""

    var body: some View {
        VStack {
            Text("Login")
                .font(.system(size: 70, weight: .bold, design: .rounded))
                
            TextField ("Username", text: $usr)
                .keyboardType(.emailAddress)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.headline)
                .background(Color.red.opacity(0.8))
                .cornerRadius(6)
                .padding(.horizontal, 60)
                .foregroundStyle(Color.black)
                .onChange(of: usr) { oldValue, newValue in
                    print("Username nuevo valor: \(newValue)")
                }
            
            SecureField ("Password", text: $pwd)
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .font(.headline)
                .background(Color.red.opacity(0.8))
                .cornerRadius(6)
                .padding(.horizontal, 60)
                .foregroundStyle(Color.black)
                .onChange(of: pwd) { oldValue, newValue in
                    print("Contraseña nuevo valor: \(newValue)")
                }
            
            Button ("Autenticar ✅") {
                print("**********")
                print(" 👤 \(usr)")
                print("🔑 \(pwd)")
            }
            
            Button ("Limpiar campos 🧹") {
                usr = ""
                pwd = ""
                print("Borraste todo")
            }
            
            Spacer()
        }
        .padding()
    }
}

#Preview {
    // Para que la variable @Binding funcione hay que inicializarla en el ContentView:
    //ContentView(usr: .constant(""))
    Login()
}
