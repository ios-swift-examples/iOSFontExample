//
//  ContentView.swift
//  iOSFontExample
//
//  Created by 영준 이 on 2023/12/21.
//

import SwiftUI

struct ContentView: View {
    @State var fonts: [UIFont] = []
    @State var fontSize: CGFloat = 12
    @State var selectedFont: UIFont?
    
    var body: some View {
        let text = Text("Hello, world!\n안녕하세요!")
        Stepper("Size: \(Int(fontSize))", value: $fontSize).padding()
        selectedFont == nil ? text : text.font(.init(selectedFont!.withSize(fontSize)))
        
        List(fonts, id: \.fontName) { font in
            HStack {
                Text("\(font.fontName)")
                    .font(.init(font))
                Spacer()
            }
            .contentShape(Rectangle())
            .listRowBackground(selectedFont == font ? Color.cyan.opacity(0.5) : Color.clear)
            .onTapGesture {
                selectedFont = font
            }
        }
        .onAppear {
            let fontFamilyNames = UIFont.familyNames
//            fontFamilyNames.forEach{ debugPrint($0) }
            let fontNames = fontFamilyNames
                .flatMap{ UIFont.fontNames(forFamilyName: $0) }
//            fontNames.forEach{ debugPrint($0) }
            fonts = fontNames
                .compactMap{ UIFont(name: $0, size: fontSize) }
            self.selectedFont = fonts.first
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
