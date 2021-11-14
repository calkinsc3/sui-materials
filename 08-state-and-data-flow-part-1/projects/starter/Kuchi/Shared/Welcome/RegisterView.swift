/// Copyright (c) 2021 Razeware LLC

import SwiftUI


//struct RegisterView: View {
//
//    @State private var name: String = ""
//
//    var body: some View {
//        VStack {
//            TextField("Type you name...", text: $name)
//                .bordered()
//            Text(name)
//        }
//        .padding()
//        .background(WelcomeBackgroundImage())
//    }
//
//}
//
//struct RegisterView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        RegisterView()
//    }
//}

struct RegisterView: View {
    @EnvironmentObject var userManager: UserManager
    @FocusState var nameFieldFocused: Bool

    var body: some View {
        VStack {
            Spacer()

            WelcomeMessageView()

            TextField("Type your name...", text: $userManager.profile.name)
                .focused($nameFieldFocused)
                .submitLabel(.done)
                .onSubmit(registerUser)
                .bordered()

            HStack {
                Spacer()
                Text("\(userManager.profile.name.count)")
                    .font(.caption)
                    .foregroundColor(
                        userManager.isUserNameValid() ? .green : .red)
                    .padding(.trailing)
            }
            .padding(.bottom)

            HStack {
                Spacer()

                Toggle(isOn: $userManager.settings.rememberUser) {
                    Text("Remember me")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .fixedSize()
            }

            Button(action: self.registerUser) {
                HStack {
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 16, height: 16, alignment: .center)
                    Text("OK")
                        .font(.body)
                        .bold()
                }
            }
            .bordered()
            .disabled(!userManager.isUserNameValid())

            Spacer()
        }
        .padding()
        .background(WelcomeBackgroundImage())
    }
}

// MARK: - Event Handlers
extension RegisterView {
    func registerUser() {
        nameFieldFocused = false

        if userManager.settings.rememberUser {
            userManager.persistProfile()
        } else {
            userManager.clear()
        }

        userManager.persistSettings()
        userManager.setRegistered()
    }
}

struct RegisterView_Previews: PreviewProvider {
    static let user = UserManager(name: "Ray")

    static var previews: some View {
        RegisterView()
            .environmentObject(user)
    }
}
