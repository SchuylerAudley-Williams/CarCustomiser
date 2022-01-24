//
//  ContentView.swift
//  CarCustomiser
//
//  Created by Audley-Williams, Schuyler (SPH) on 17/01/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var starterCars = StarterCars()
    @State private var selectedCar: Int = 0 {
        didSet {
            if selectedCar >= starterCars.cars.count {
                selectedCar = 0
            }
        }
    }
    @State private var exhaustPackage = false
    @State private var tiresPackage = false
    @State private var spoilerPackage = false
    @State private var steeringWheelPackage = false
    @State private var remainingFunds = 1000
    
    var exhaustPackageEnabled: Bool {
        return exhaustPackage ? true : remainingFunds >= 500 ? true : false
    }
    
    var tiresPackageEnabled: Bool {
        return tiresPackage ? true : remainingFunds >= 500 ? true : false
    }
    
    var spoilerPackageEnabled: Bool {
        return spoilerPackage ? true : remainingFunds >= 500 ? true : false
    }
    
    var steeringWheelPackageEnabled: Bool {
        return steeringWheelPackage ? true : remainingFunds >= 250 ? true : false
    }
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get : { self.exhaustPackage },
            set : { newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    remainingFunds += 500
                }
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get : { self.tiresPackage },
            set : { newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                    remainingFunds += 500
                }
            }
        )
        
        let spoilerPackageBinding = Binding<Bool> (
            get : { self.spoilerPackage },
            set : { newValue in
                self.spoilerPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 1
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].acceleration += 1
                    remainingFunds += 500
                }
            }
        )
        
        let steeringWheelPackageBinding = Binding<Bool> (
            get : { self.steeringWheelPackage },
            set : { newValue in
                self.steeringWheelPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 3
                    remainingFunds -= 250
                } else {
                    starterCars.cars[selectedCar].handling -= 3
                    remainingFunds += 250
                }
            }
        )
        
        Form{
            VStack(alignment: .leading, spacing: 20){
                Text(starterCars.cars[selectedCar].displayStats())
                Button("Next Car", action: {
                    exhaustPackage = false
                    tiresPackage = false
                    spoilerPackage = false
                    steeringWheelPackage = false
                    remainingFunds = 1000
                    
                    selectedCar += 1
                })
            }
            Section{
                Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding).disabled(!exhaustPackageEnabled)
                Toggle("Tires Package (Cost: 500)", isOn: tiresPackageBinding).disabled(!tiresPackageEnabled)
                Toggle("Spoiler Package (Cost: 500)", isOn: spoilerPackageBinding).disabled(!spoilerPackageEnabled)
                Toggle("Steering Wheel Package (Cost: 250)", isOn: steeringWheelPackageBinding).disabled(!steeringWheelPackageEnabled)
            }
        }
        Text("Remaining Funds: \(remainingFunds)")
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
