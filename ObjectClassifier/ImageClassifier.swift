//
//  ImageClassifier.swift
//  ObjectClassifier
//
//  Created by Andrew Althage on 10/5/23.
//

import SwiftUI

class ImageClassifier: ObservableObject {
    @Published var imageClass: String?

    private(set) var classifier = Classifier()

    // MARK: Intent(s)

    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage(image: uiImage) else { return }
        imageClass = classifier.detect(ciImage: ciImage)
    }
}
