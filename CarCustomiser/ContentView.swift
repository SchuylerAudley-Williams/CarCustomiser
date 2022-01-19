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
    
    var body: some View {
        let exhaustPackageBinding = Binding<Bool> (
            get : { self.exhaustPackage },
            set : { newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                }
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get : { self.tiresPackage },
            set : { newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                }
            }
        )
        
        let spoilerPackageBinding = Binding<Bool> (
            get : { self.spoilerPackage },
            set : { newValue in
                self.spoilerPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 1
                } else {
                    starterCars.cars[selectedCar].acceleration += 1
                }
            }
        )
        
        let steeringWheelPackageBinding = Binding<Bool> (
            get : { self.steeringWheelPackage },
            set : { newValue in
                self.steeringWheelPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 3
                } else {
                    starterCars.cars[selectedCar].handling -= 3
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
                    
                    selectedCar += 1
                })
            }
            Section{
                Toggle("Exhaust Package", isOn: exhaustPackageBinding)
                Toggle("Tires Package", isOn: tiresPackageBinding)
                Toggle("Spoiler Package", isOn: spoilerPackageBinding)
                Toggle("Steering Wheel Package", isOn: steeringWheelPackageBinding)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
