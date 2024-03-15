//
//  ContentView.swift
//  Calculator
//
//  Created by Garrett Ostrander on 3/14/24.
//

import SwiftUI
enum CalcButton: String {
    case one = "1"
    case two = "2"
    case three = "3"
    case four = "4"
    case five = "5"
    case six = "6"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case zero = "0"
    case plus = "+"
    case subtract = "-"
    case divide = "÷"
    case negative = "-/+"
    case multiply = "x"
    case equal = "="
    case clear = "AC"
    case decimal = "."
    case percent = "%"
    

    var buttonColor: Color {
        switch self {
        case .plus, .subtract, .multiply, .divide, .equal:
            return .blue
        case .clear, .negative, .percent:
            return Color(UIColor(red: 3/255.0, green: 150/255.0, blue: 252/252.0, alpha: 1))
        default:
            return Color(UIColor(red: 55/255.0, green: 55/255.0, blue: 55/255.0, alpha: 1))
        }
    }
}

enum Operation {
    case plus, subtract, multiply, divide, none
}


struct ContentView: View {
    @State var value = "0"
    @State var runningNumber = 0
    @State var currentOperation: Operation = .none
    
    let buttons: [[CalcButton]] = [
        [.clear, .negative, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .subtract],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal],
    ]
    var body: some View {
        ZStack{
            Color.black.edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                //text display
                HStack{
                    Spacer()
                    Text(value)
                        .bold()
                        .font(.system(size: 52))
                        .foregroundColor(.white)
                }.padding()
                ForEach(buttons, id: \.self){ row in
                    HStack(spacing: 12){
                        ForEach(row, id: \.self){ item in
                            Button(action: {
                                self.didTap(button: item)
                            }, label: {
                                Text(item.rawValue)
                                    .frame(width: self.buttonWidth(item: item), height: self.buttonHeigh())
                                    .background(item.buttonColor)
                                    .foregroundColor(.white)
                                    .cornerRadius(35)
                                    .font(.system(size: 30))
                                    .fontWeight(.bold)
                            })
                        }
                    }
                    .padding(.bottom, 3)
                }
            }
        }
    }
     func didTap(button: CalcButton){
        switch button{
        case .plus, .subtract, .divide, .multiply, .equal:
            
            if button == .plus{
                self.currentOperation = .plus
                self.runningNumber += Int(self.value) ?? 0
            }
            else if button == .subtract{
                self.currentOperation = .subtract
                self.runningNumber += Int(self.value) ?? 0
            }
            else if button == .divide{
                self.currentOperation = .divide
                self.runningNumber += Int(self.value) ?? 0
            }
            else if button == .multiply{
                self.currentOperation = .multiply
                self.runningNumber += Int(self.value) ?? 0
            }
            else if button == .equal{
                let runningValue = self.runningNumber
                let currentValue = Int(self.value) ?? 0
                switch self.currentOperation {
                case .plus:
                    self.value = "\(runningValue + currentValue)"
                case .subtract:
                    self.value = "\(runningValue - currentValue) "
                case .multiply:
                    self.value = "\(runningValue * currentValue) "
                case .divide:
                    self.value = "\(runningValue / currentValue) "
                case .none:
                    break
                }
            }
            if button != .equal{
                self.value = "0"
            }
            
        case .clear:
            self.value = "0"
            break
        case .decimal, .negative, .percent:
           
            break
        default:
            let number = button.rawValue
            if self.value == "0"{
                value = number
            }
            else{
                self.value = "\(self.value)\(number)"
            }
            
        }
    }
    func buttonWidth(item: CalcButton) -> CGFloat{
        if item == .zero{
            return ((UIScreen.main.bounds.width - (4*12)) / 4) * 2
        }
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
    func buttonHeigh() -> CGFloat{
        return (UIScreen.main.bounds.width - (5*12)) / 4
    }
}

#Preview {
    ContentView()
}
