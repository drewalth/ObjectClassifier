//
//  ContentView.swift
//  ObjectClassifier
//
//  Created by Andrew Althage on 10/5/23.
//

import SwiftUI
struct ContentView: View {
    @State var isPresenting: Bool = false
    @State var uiImage: UIImage?
    @State var sourceType: UIImagePickerController.SourceType = .photoLibrary

    @ObservedObject var classifier = ImageClassifier()

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isPresenting = true
                    sourceType = .photoLibrary
                }, label: {
                    Image(systemName: "photo")
                        .foregroundColor(.white)
                }).buttonStyle(.borderedProminent)

                Button(action: {
                    isPresenting = true
                    sourceType = .camera
                }, label: {
                    Image(systemName: "camera")
                        .foregroundColor(.white)
                }).buttonStyle(.borderedProminent)
            }
            .font(.headline)
            .foregroundColor(.blue)

            Rectangle()
                .strokeBorder()
                .foregroundColor(.yellow)
                .overlay(
                    Group {
                        if uiImage != nil {
                            Image(uiImage: uiImage!)
                                .resizable()
                                .scaledToFit()
                        }
                    }.padding(.horizontal, 8)
                )

            VStack {
                Button(action: {
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                    }
                }) {
                    Image(systemName: "bolt.fill")
                        .foregroundColor(.orange)
                        .font(.title)
                }

                Group {
                    if let imageClass = classifier.imageClass {
                        HStack {
                            Text("Image categories:")
                                .font(.caption)
                            Text(imageClass)
                                .bold()
                        }
                    } else {
                        HStack {
                            Text("Image categories: NA")
                                .font(.caption)
                        }.font(.caption)
                    }
                }
                .font(.subheadline)
                .padding()
            }
        }

        .sheet(isPresented: $isPresenting) {
            ImagePicker(uiImage: $uiImage, isPresenting: $isPresenting, sourceType: $sourceType)
                .onDisappear {
                    if uiImage != nil {
                        classifier.detect(uiImage: uiImage!)
                    }
                }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
