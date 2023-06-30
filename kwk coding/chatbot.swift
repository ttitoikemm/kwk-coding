//
//  chatbot.swift
//  kwk coding
//
//  Created by Otitodilichukwu Ikem on 6/30/23.
//

import SwiftUI
import OpenAISwift

final class ViewModel: ObservableObject{
  init(){}
  private var client: OpenAISwift?
  func setup(){
    client = OpenAISwift(authToken: "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")
  }
  func send(text:String, completion: @escaping (String) -> Void){
    client?.sendCompletion(with: text,
                           maxTokens:500,
                           completionHandler: {result in
                                               switch result{
                                                 case.success(let model):
                                                    let moutput = model.choices.first?.text ?? ""
                                                    completion(output)
                                                 case.failure:
                                                    break
                                               }
                                              
  }
}

struct ContentView: View{
  @ObservedObject var viewModel = ViewModel()
  @State var text = ""
  @State var models = [String]()
  
  var body: some View{
    VStack(alignment: .leading){
      ForEach(models, id: \.self) { string in
                                  Text(string)
                                  }
      Spacer()
      HStack{
        TextField("Type here", text: $text)
        Button("Send"){
          send()
        }
      }
    }
    .onAppear{
      viewModel.setup()
    }
    .padding()
  }
  func send(){
    guard !text.trimmingCharacters(in: .whitespaces)isEmpty else{
      return
    }
    models.append("Me: \(text)")
    viewModel.send(text: text) {response in
        DispatchQueue.main.async {
          self.models.append("Hungri Chat: " +response)
          self.text = ""
        }}
  }
}


struct ContentView_Previews: PreviewProvider{
  static var previews: some View{
    ContentView()
  }
}

