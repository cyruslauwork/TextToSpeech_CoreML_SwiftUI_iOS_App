//
//  ContentView.swift
//  TextToSpeechLauKaPui
//
//  Created by Cyrus on 28/2/2022.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @State private var speechText = "" // Create new store
    var languageCodes = ["en-US", "en-UK", "zh-HK", "zh-CN", "ja-JP", "ko-KR", "fr-FR", "it-IT", "es-ES"]
    var languageCode = "zh-HK"
    
    var body: some View {
        VStack{
            Text("Read the following message")
                .font(.system(.largeTitle, design: .rounded))
                .fontWeight(.black)
            
            TextEditor(text: $speechText) // $ = Changeable
                .font(.title2)
                .background(Color.gray)
                .opacity(0.9)
                .padding()
                .textFieldStyle(.roundedBorder)
            
            //            TextField("What to speak?", text: $speechText)
            //                .font(.title2)
            //                .background(Color.gray)
            //                .opacity(0.9)
            //                .padding()
            //                .textFieldStyle(.roundedBorder)
            
            //                for voice in AVSpeechSynthesisVoice.speechVoices(){
            //                    let language = NSLocale.init(localeIdentifier: Locale.current.languageCode!)
            //                    print(language.displayName(forKey: NSLocale.Key.identifier, value: voice.language)?.description as! String)
            //                    print(language.localeIdentifier)
            //                }
            
            HStack{
                ReadButton(speechText: $speechText, languageCode: languageCodes[2], buttonColor: .yellow, buttonText: "\(languageCodes[2])", pitch: 0.5, rate: 0.5)
                ReadButton(speechText: $speechText, languageCode: languageCodes[1], buttonColor: .red, buttonText: "\(languageCodes[1])", pitch: 0.5, rate: 0.5)
                ReadButton(speechText: $speechText, languageCode: languageCodes[4], buttonColor: .blue, buttonText: "\(languageCodes[4])", pitch: 0.5, rate: 0.5)
                ReadButton(speechText: $speechText, languageCode: languageCodes[5], buttonColor: .green, buttonText: "\(languageCodes[5])", pitch: 0.5, rate: 0.5)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ReadButton: View{ // As a view
    
    @Binding var speechText: String // @Binging = read only
    
    var languageCode: String
    var buttonColor: Color
    var buttonText: String
    var pitch: Float
    var rate: Float
    
    let speechSynthesizer = AVSpeechSynthesizer()
    
    func speak(language: String = "zh-HK", pitchMultipler: Float, rate: Float) {
        
        let utterance = AVSpeechUtterance(string: speechText)
        
        print(AVSpeechSynthesisVoice.speechVoices())
        print("Total voices: \(AVSpeechSynthesisVoice.speechVoices().count)")
        
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        utterance.pitchMultiplier = pitchMultipler
        utterance.rate = rate
        speechSynthesizer.speak(utterance)
        
        // Receive response
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
    }
    
    var body: some View{
        Button(action: {
            speak(language: languageCode, pitchMultipler: pitch, rate: rate)
        }){
            Text("\(buttonText)")
                .font(.system(.headline, design: .rounded))
                .padding(40)
                .foregroundColor(.white)
                .background(buttonColor)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*END_MENU_TOKEN@*/)
        }
    }
    
}
