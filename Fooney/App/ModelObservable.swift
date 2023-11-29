//
//  ModelObservable.swift
//  Fooney
//
//  Created by Adryan Eka Vandra on 21/03/23.
//

import SwiftUI
import RealityKit
import CoreML
import Vision
import ARKit
import SceneKit

public class ModelObserable: ObservableObject {
    private init() {}
    @Published var emojiMap = [
        "happy": ["😄", "😂", "😝", "😆", "🥳"],
        "sad": ["😢", "🥹", "🥺", "🥹", "🤠"],
        "angry": ["😠", "🤡", "😤", "😡", "😳"],
        "disgust": ["😒", "😖", "🧐", "😕", "😤"],
        "fear": ["😨", "😱", "😰", "🫠", "🫣"],
        "neutral": ["😐", "😶", "🙂", "😉", "😃"],
        "surprise": ["🤯", "🤩", "😮", "🤭", "🥴"]
    ]
    static let shared = ModelObserable()

    @Published var arView = ARView()
    @Published var recognizedExpression = ""
    @Published var showedQuote = ""
    @Published var showedEmoji = ""

    // Define the model
    @Published var model = try! VNCoreMLModel(for: EnetModel().model)

    // call update via debounce function
    var timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        updateContinuously()
    }

    func setRecognizedObject(newExpression: String) {
        let randomNumber = Int.random(in: 0...4)

        recognizedExpression = newExpression
        switch newExpression.lowercased() {
        case "happy":
            self.showedEmoji = self.emojiMap["happy"]?[randomNumber] ?? ""
            self.showedQuote = QuoteMessage.happy[randomNumber]
        case "sad":
            self.showedEmoji = self.emojiMap["sad"]?[randomNumber] ?? ""
            self.showedQuote = QuoteMessage.sads[randomNumber]
        case "angry":
            self.showedEmoji = self.emojiMap["angry"]?[randomNumber] ?? ""
            self.showedQuote = QuoteMessage.angry[randomNumber]
        case "disgust":
            self.showedEmoji = self.emojiMap["disgust"]?[randomNumber] ?? ""
            self.showedQuote = QuoteMessage.disgust[randomNumber]
        case "fear":
            self.showedEmoji = self.emojiMap["fear"]?[randomNumber] ?? ""
            self.showedQuote = QuoteMessage.fear[randomNumber]
        case "neutral":
            self.showedEmoji = self.emojiMap["neutral"]?[randomNumber] ?? ""
            self.showedQuote = QuoteMessage.neutral[randomNumber]
        case "surprise":
            self.showedEmoji = self.emojiMap["surprise"]?[randomNumber] ?? ""
            self.showedQuote = QuoteMessage.surprise[randomNumber]
        default:
            self.showedQuote = ""
            self.showedEmoji = ""
        }
    }
}

func updateContinuously() {
    @ObservedObject var recognized: ModelObserable = .shared

    let arView = recognized.arView
    let session = arView.session
    let model = recognized.model

    // access current frame as image
    let temporaryPixelBuffer: CVPixelBuffer? = session.currentFrame?.capturedImage

    // get current camera frame from the live ar session

    if temporaryPixelBuffer == nil {
        return
    }

    let temporaryCIImage = CIImage(cvPixelBuffer: temporaryPixelBuffer!)

    // create request to vision core ML model
    let request = VNCoreMLRequest(model: model) { _, _ in }

    // crop just center of frame
    request.imageCropAndScaleOption = .centerCrop

    let handler = VNImageRequestHandler(ciImage: temporaryCIImage, orientation: .right)

    do {
        try handler.perform([request])
    } catch {
        print(error)
    }

    guard let observation = request.results as? [VNClassificationObservation] else { return }

    // only proceed if confidence level is more than 50%
    if observation[0].confidence < 0.9 { return }

    // the model return descending order of confidence, so get the first identifier
    let topLabelObservation = observation[0].identifier

    if recognized.recognizedExpression != topLabelObservation {
        DispatchQueue.main.async {
            recognized.setRecognizedObject(newExpression: topLabelObservation)
        }
    }
}
