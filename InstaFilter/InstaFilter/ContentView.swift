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
    @State private var radius = 20.0
    @State private var scale = 5.0
    @State private var angle = 0.5
    @State private var amount = 2.0

    @State private var isImagePickerShowing = false
    @State private var isShowingFilterSheet = false
    @State private var isShowingAlert = false
    @State private var alertTitle = Text("")
    @State  private var alertText = Text("")
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?

    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
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
                        .scaledToFill()
                }
                .onTapGesture {
                    isImagePickerShowing = true
                }
                VStack {
                    if(currentFilter.inputKeys.contains(kCIInputIntensityKey)) {
                        HStack(spacing: 15) {
                            Text("Itensity")
                            Slider(value: $intensity, in: 0...1)
                                .onChange(of: intensity) { _ in
                                    applyProcessing()
                                }
                        }
                    }
                    if(currentFilter.inputKeys.contains(kCIInputRadiusKey)) {
                        HStack(spacing: 15) {
                            Text("Radius")
                            Slider(value: $radius, in: 0...200)
                                .onChange(of: radius) { _ in
                                    applyProcessing()
                                }
                        }
                    }
                    if(currentFilter.inputKeys.contains(kCIInputAmountKey)) {
                        HStack(spacing: 15) {
                            Text("Amount")
                            Slider(value: $amount, in: 0...5)
                                .onChange(of: amount) { _ in
                                    applyProcessing()
                                }
                        }
                    }
                    if(currentFilter.inputKeys.contains(kCIInputAngleKey)) {
                        HStack(spacing: 15) {
                            Text("Angle")
                            Slider(value: $angle, in: 0...1)
                                .onChange(of: angle) { _ in
                                    applyProcessing()
                                }
                        }
                    }
                    if(currentFilter.inputKeys.contains(kCIInputScaleKey)) {
                        HStack(spacing: 15) {
                            Text("Scale")
                            Slider(value: $scale, in: 0...10)
                                .onChange(of: scale) { _ in
                                    applyProcessing()
                                }
                        }
                    }

                    HStack {
                        Button("Change Filter"){
                            isShowingFilterSheet = true
                        }
                        Spacer()
                        Button("Save", action: save)
                            .disabled(image == nil)
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
            .alert(isPresented: $isShowingAlert, content: {
                Alert(title: alertTitle, message: alertText, dismissButton: .default(Text("Ok")))
            })
            .confirmationDialog("Choose a filter", isPresented: $isShowingFilterSheet) {
                Group {
                    Button("Sepia tone"){ setFilter(CIFilter.sepiaTone()) }
                    Button("Gaussian Blur"){ setFilter(CIFilter.gaussianBlur())}
                    Button("Crystallize"){  setFilter(CIFilter.crystallize()) }
                    Button("Vignette"){ setFilter(CIFilter.vignette()) }
                    Button("Vibrance"){ setFilter(CIFilter.vibrance()) }
                    Button("Bloom"){ setFilter(CIFilter.bloom()) }
                    Button("Kaleidoscope"){ setFilter(CIFilter.kaleidoscope()) }
                    Button("Comic effect"){ setFilter(CIFilter.comicEffect()) }
                    Button("Photo Effect"){ setFilter(CIFilter.photoEffectInstant()) }
                    Button("Unsharp mask"){ setFilter(CIFilter.unsharpMask()) }
                }
                Group {
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
    }
    func setFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    func loadImage() {
        guard let inputImage else { return }

        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }

    func save() {
        guard let processedImage = processedImage else { return }
        let imageSaver = ImageSaver()
        imageSaver.writeToPhotoAlbum(image: processedImage)
        imageSaver.successHandler = {
            print("Success")
            self.alertTitle = Text("Success")
            self.alertText = Text("You are successfully saved an image")
        }
        imageSaver.errorHandler = {
            print("Oops \($0.localizedDescription)")
            self.alertTitle = Text("Error")
            self.alertText = Text("Oops \($0.localizedDescription)")
        }
        isShowingAlert = true
    }

    func applyProcessing() {

        if currentFilter.inputKeys.contains(kCIInputIntensityKey) {
            currentFilter.setValue(intensity, forKey: kCIInputIntensityKey)
            print("intensity \(intensity)")
        }
        if currentFilter.inputKeys.contains(kCIInputRadiusKey) {
            currentFilter.setValue(radius, forKey: kCIInputRadiusKey)
        }
        if currentFilter.inputKeys.contains(kCIInputScaleKey) {
            currentFilter.setValue(scale * 10, forKey: kCIInputScaleKey)
        }
        if currentFilter.inputKeys.contains(kCIInputAmountKey) {
            currentFilter.setValue(intensity * 5, forKey: kCIInputAmountKey)
        }
        if currentFilter.inputKeys.contains(kCIInputAngleKey) {
            currentFilter.setValue(angle * 1.0 , forKey: kCIInputAngleKey)
        }


        guard let outputImage = currentFilter.outputImage else { return }
        if let cgImg = context.createCGImage(outputImage, from: outputImage.extent) {
            let uiImage = UIImage(cgImage: cgImg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
