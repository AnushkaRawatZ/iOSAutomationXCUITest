//
//  DonationView.swift
//  Ahavat Yeshua
//
//  Created by Ilia Pavlov on 9/20/23.
//

import SwiftUI

struct DonationView: View {
    @State private var quantity: Int = 0
    @State private var totalAmount: Double = 0
    @State private var showCongratulations: Bool = false
    
    var body: some View {
        VStack {
            Text("Total Amount: $\(totalAmount, specifier: "%.2f")")
                .font(.headline).accessibilityIdentifier("totalAmountLabel")
            
            HStack {
                Button(action: {
                    self.totalAmount += 1.0
                }) {
                    Text("$1")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .accessibilityIdentifier("1DollarBtn")
                }
                
                Button(action: {
                    self.totalAmount += 5.0
                }) {
                    Text("$5")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .accessibilityIdentifier("5DollarBtn")

                }
            }
            
            Stepper(value: $quantity, in: 0...10) {
                Text("Quantity: \(quantity)").accessibilityIdentifier("quantityLabel")
            }
            .padding()
            
            Text("Total: $\(totalAmount * Double(quantity), specifier: "%.2f")")
                .font(.headline).accessibilityIdentifier("totalLabel")
            
            Button(action: {
                // Handle the donation action here
                // For example, you can show an alert or navigate to a donation screen.
                self.showCongratulations.toggle()
            }) {
                Text("Donate")
                    .padding()
                    .background(Color.orange)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .accessibilityIdentifier("donateBtn")
            }
        }
        .padding()
        .sheet(isPresented: $showCongratulations, content: {
            CongratulationsView(isPresented: $showCongratulations)
        })
    }

}

struct CongratulationsView: View {
    @Binding var isPresented: Bool
    @State private var fireworksVisible: Bool = false
    
    var body: some View {
        VStack {
            Text("Congratulations!")
                .font(.title)
                .fontWeight(.bold)
            
            if fireworksVisible {
                FireworksView()
            }
            
            Button(action: {
                withAnimation {
                    // Show fireworks when the "Close" button is tapped
                    fireworksVisible.toggle()
                }
                
                // Close the congratulations popup after a delay
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    isPresented = false
                }
            }) {
                Text("Thank you!")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear {
            // Automatically show fireworks when the view appears
            withAnimation {
                fireworksVisible.toggle()
            }
        }
    }
}


struct FireworksView: View {
    @State private var isAnimating = false
    var body: some View {
        Image(systemName: "sparkles")
                    .font(.largeTitle)
                    .foregroundColor(.yellow)
                    .rotationEffect(.degrees(isAnimating ? 15 : 0))
                    .scaleEffect(isAnimating ? 2 : 1)
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                            isAnimating = true
                        }
                    }
    }
}

#Preview {
    DonationView()
}
