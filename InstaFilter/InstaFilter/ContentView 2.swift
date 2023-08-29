//
//  ContentView.swift
//  InstaFilter
//
//  Created by Anastasia Lenina on 16.08.2023.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    @State private var image: Image?
    @State private var intensity = 0.5

    @State private var isImagePickerShowing = false
    @State private var inputImage: UIImage?

    @State private var currentFilter = CIFilter.sepiaTone()
    let context = CIContext()

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Rectangle()
                        .fill(.gray)
                    Text("Select an image")
                        .foregroundColor(.white)
                        .font(.headline)
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    isImagePickerShowing = true
                }
                VStack {
                    HStack(spacing: 15) {
                        Text("Itensity")
                        Slider(value: $intensity, in: 0...1)
                            .onChange(of: intensity) { _ in
                                applyProcessing()
                            }
                    }
                    HStack {
                        Text("Change Filter")
                        Spacer()
                        Button("Save", action: save)
                    }
                }
            }
            .padding()
            .navigationTitle("Insta Filter")
            .onChange(of: inputImage) { _ in
               loadImage()
            }
            .sheet(isPresented: $isImagePickerShowing) {
                ImagePicker(image: $inputImage)
            }
        }
    }
    func loadImage() {
        guard let inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func save() {
    }

    func applyProcessing() {
        currentFilter.intensity = Float(intensity)

        guard let outputImage = currentFilter.outputImage else { return }
        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImg)
            image = Image(uiImage: uiImage)
        }
    }
}
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
