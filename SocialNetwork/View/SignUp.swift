import SwiftUI

struct SignUp: View {

    @StateObject private var signUpVM = SignInViewModel()
    @Binding var isPresented : Bool

    
    var body: some View {

        NavigationView {

            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("First time?")
                        .fontWeight(.bold)
                        .font(Font.custom("Space Grotesk", size: 35))

                    Text("Wellcome!!")
                        .fontWeight(.bold)
                        .font(Font.custom("Space Grotesk", size: 30))

                    InputTextField(textBinding: $signUpVM.name, label: "Name", placeholder: "Example", secureTextField: false)
                        .padding()
                    InputTextField(textBinding: $signUpVM.email, label: "Email", placeholder: "Example@example.com", secureTextField: false)
                        .padding()
                    InputTextField(textBinding: $signUpVM.password, label: "Password", placeholder: "pAssW0rd", secureTextField: false)
                        .padding()
                }

                Spacer(minLength: 50)

                VStack(alignment: .center){

                    Button(action:{
                        signUpVM.getNewUser()
                        self.isPresented = false
                    }){
                        HStack{
                            Spacer()
                            Text("Sign In")
                                .font(Font.custom("Space Grotesk", size: 17))
                                .foregroundColor(.white)
                                .frame(width: 159, height: 41)
                            Spacer()
                        }
                    }
                    .background(Color.black)
                    .cornerRadius(15)
                    .padding(.vertical, 10)
                    .padding(.horizontal, 40)


                    Text("Already have an account?")
                        .font(Font.custom("Space Grotesk", size: 18))
                        .bold()

                    Button(action: {
                        self.isPresented = false
                    }) {
                        HStack{
                            Text("Login  here")
                                .underline()
                                .font(Font.custom("Space Grotesk", size: 18))
                                .bold()
                                .foregroundColor(.black)
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(15)

                }
                Spacer(minLength: 100)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 40)

        }
        .accentColor(.black)
    }
}


