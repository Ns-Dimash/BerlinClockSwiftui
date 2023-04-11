//
//  ContentView.swift
//  BerlinClockUi
//
//  Created by Dimash Nsanbaev on 4/11/23.
//

import SwiftUI

struct ContentView: View {

    @State private var selectedDate = Date()
    @State var countRed = 0
    @State var countYellow = 0
    @State var currentTime = Date()

    
//    var seconds: Timer {
//
//        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//            currentTime = Date()
//        }
//        timer.fire()
//    }
//
    let firstYellow = Color(red: 255/255, green: 224/255, blue: 102/255,opacity: 1)
    let secondYellow = Color(red: 255/255, green: 204/255, blue: 0,opacity: 1)
    let firstRed = Color(red: 255/255, green: 137/255, blue: 131/255,opacity: 1)
    let secondRed = Color(red: 255/255, green: 59/255, blue: 48/255,opacity: 1)
    
    
    var body: some View {
        
        ZStack{
            Color(red: 233/255, green: 233/255, blue: 230/255)
                .ignoresSafeArea()
            VStack{
                time
                    .padding(.top,56)
                mainClock
                insertTime
                Spacer()
                
                
            }
            
        }
        
    }
    
    // MARK: -
    
    var time:some View{
        Text("Time is \(getTimeFromDate(date:selectedDate))")
            .font(.system(size: 17,weight: .semibold))
        
    }
    
    var mainClock:some View{
        ZStack{
            Color(red: 255/255, green: 255/255, blue: 255/255).opacity(1)
            VStack(spacing: 16){
                Circle()
                    .frame(width: 56,height: 56)
                    .foregroundColor(firstYellow)
                
                HStack{
                    ForEach(0..<4) { index in
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 74,height: 32)
                            .foregroundColor(index < getTimeFromPicker(date: selectedDate).0 / 5 ? secondRed : firstRed)
                    }
                }
                
                HStack{
                    ForEach(0..<4) { index in
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 74,height: 32)
                            .foregroundColor(index < getTimeFromPicker(date: selectedDate).0 % 5 ? secondRed : firstRed)
                    }
                }
                HStack(spacing: 10){
                    ForEach(0..<11) { index in
                        if (index + 1) % 3 == 0{
                            RoundedRectangle(cornerRadius: 4)
                                .frame(width: 20,height: 32)
                                .foregroundColor(index < getTimeFromPicker(date: selectedDate).1 / 5 ? secondRed : firstRed)
                            
                        }else{
                            RoundedRectangle(cornerRadius: 4)
                                .frame(width: 20,height: 32)
                                .foregroundColor(index < getTimeFromPicker(date: selectedDate).1 / 5 ? secondYellow : firstYellow)
                        }
                        
                        
                        
                    }
                }
                
                HStack{
                    ForEach(0..<4) { index in
                        RoundedRectangle(cornerRadius: 4)
                            .frame(width: 74,height: 32)
                            .foregroundColor(index < getTimeFromPicker(date: selectedDate).1 % 5  ? secondYellow : firstYellow)
                    }
                }
                
                
                
            }
            
        }
        .frame(width: 358,height: 312)
        .cornerRadius(12)
    }
    
    var insertTime:some View{
        ZStack{
            Color(red: 255/255, green: 255/255, blue: 255/255).opacity(1)
            HStack{
                Text("Insert Time")
                DatePicker("", selection: $selectedDate, displayedComponents: .hourAndMinute)
                
            }
            .padding(20)
        }
        .frame(width: 358,height: 54)
        .cornerRadius(12)
        .padding(.top,10)
    }
    func getTimeFromPicker(date:Date) -> (Int,Int){
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return (hour,minutes)
    }
    
    func getTimeFromDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
