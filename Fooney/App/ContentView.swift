//
//  ContentView.swift
//  Fooney
//
//  Created by Adryan Eka Vandra on 18/03/23.
//

import SwiftUI
import LinkPresentation

// construct enum to decide which sheet to present:
enum ActiveSheet: String, Identifiable { // <--- note that it's now Identifiable
    case photoLibrary, shareSheet
    var id: String {
        return self.rawValue
    }
}

struct ContentView: View {
    @ObservedObject var recogd: ModelObserable = .shared

    @Environment(\.displayScale) var displayScale
    @State private var shareCardAsImage: UIImage?

    @State var activeSheet: ActiveSheet? // <--- now an optional property

    var shareCard: some View {
        ZStack {
//            ShareHomeView()
            ARViewContainer().edgesIgnoringSafeArea(.all)
            Image("CameraShape")
            PopUpView()
                .offset(x: 0, y: -250)
                .hidden( recogd.recognizedExpression.isEmpty)
        }.environmentObject(recogd)
    }
    var body: some View {
        ZStack {
            shareCard
            VStack(alignment: .center, spacing: .zero) {
                Button(action: {
                    shareCardAsImage = UIApplication.shared.takeScreenshot(false)
                    activeSheet = .shareSheet
                }) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                            .font(.system(size: 20))
                            .padding(20)
                    }
                    .background(Color("AccentOrange"))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                }
                Image("FooneyLogo")
                    .resizable()
                    .frame(
                width: 150,
                height: 150
                )
            }
            .padding(.top, 600)
        }
        .sheet(item: $activeSheet) { [shareCardAsImage] sheet in // <--- sheet is of type ActiveSheet and lets you present the appropriate sheet based on which is active
            switch sheet {
            case .photoLibrary:
                Text("TODO")
            case .shareSheet:
                if let unwrappedImage = shareCardAsImage {
                    ShareSheet(photo: unwrappedImage)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func hidden(_ shouldHide: Bool) -> some View {
        opacity(shouldHide ? 0 : 1)
    }
    func asImage() -> UIImage {
        let controller = UIHostingController(rootView: self)

        // locate far out of screen
        controller.view.frame = CGRect(x: 0, y: CGFloat(Int.max), width: 1, height: 1)
        UIApplication.shared.windows.first!.rootViewController?.view.addSubview(controller.view)

        let size = controller.sizeThatFits(in: UIScreen.main.bounds.size)
        controller.view.bounds = CGRect(origin: .zero, size: size)
        controller.view.sizeToFit()

        let image = controller.view.asImage()
        controller.view.removeFromSuperview()
        return image
    }
}

extension UIView {
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            // [!!] Uncomment to clip resulting image
            //             rendererContext.cgContext.addPath(
            //                UIBezierPath(roundedRect: bounds, cornerRadius: 20).cgPath)
            //            rendererContext.cgContext.clip()

            // As commented by @MaxIsom below in some cases might be needed
            // to make this asynchronously, so uncomment below DispatchQueue
            // if you'd same met crash
            //            DispatchQueue.main.async {
            layer.render(in: rendererContext.cgContext)
            //            }
        }
    }
}

// This code is from https://gist.github.com/tsuzukihashi/d08fce005a8d892741f4cf965533bd56

struct ShareSheet: UIViewControllerRepresentable {
    let photo: UIImage

    func makeUIViewController(context: Context) -> UIActivityViewController {
        // let text = ""
        // let itemSource = ShareActivityItemSource(shareText: text, shareImage: photo)

        let activityItems: [Any] = [photo]

        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: nil)

        return controller
    }

    func updateUIViewController(_ viewController: UIActivityViewController, context: Context) {
    }
}

extension UIApplication {
    /// Takes the screenshot of the screen and returns the corresponding image
        ///
        /// - Parameter shouldSave: Boolean flag asking if the image needs to be saved to user's photo library. Default set to 'true'
        /// - Returns: (Optional)image captured as a screenshot
        func takeScreenshot(_ shouldSave: Bool = true) -> UIImage? {
            guard let window = keyWindow else { return nil }
                   let bounds = UIScreen.main.bounds
                   UIGraphicsBeginImageContextWithOptions(bounds.size, false, 0)
                   window.drawHierarchy(in: bounds, afterScreenUpdates: true)
                   guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
                   UIGraphicsEndImageContext()
                   return image
        }
}
