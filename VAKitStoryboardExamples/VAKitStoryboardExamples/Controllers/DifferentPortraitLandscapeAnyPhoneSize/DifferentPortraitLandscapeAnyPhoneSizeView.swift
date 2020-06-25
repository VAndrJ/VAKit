//
//  DifferentPortraitLandscapeAnyPhoneSizeView.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 22.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

/*
 Example view how to use VAView to create a layout for different iPhones orientation.
 No constraints for the iPad.
 */
class DifferentPortraitLandscapeAnyPhoneSizeView: VAView {
    let exampleView = UIView().configured {
        $0.backgroundColor = .purple
    }
    
    convenience init() {
        self.init(frame: UIScreen.main.bounds)
        addElements()
        configure()
    }
    
    private func configure() {
        backgroundColor = .white
    }
    
    /*
     To add UI elements override this function and call super at the end.
     */
    override func addElements() {
        addAutolayoutSubview(exampleView)
        exampleView
            .toSuperCenter()
            .size(width: 50, height: 300, device: .iPhonePortrait)
            .size(width: 200, height: 200, device: .iPhoneSmallLandscape)
            .size(width: 400, height: 200, device: .iPhoneLargeLandscape)
        super.addElements()
    }
}

/*
 To preview on canvas.
 Before iOS 13 I used @IBDesignable, but Previews much better :)
 */
#if DEBUG
#if canImport(SwiftUI)
import SwiftUI

@available (iOS 13.0, *)
struct IPhoneAnySizeDifferentPortraitLandscapeSizeViewRepresentation: UIViewRepresentable {
    typealias UIViewType = DifferentPortraitLandscapeAnyPhoneSizeView
    
    func makeUIView(context: Context) -> DifferentPortraitLandscapeAnyPhoneSizeView {
        return DifferentPortraitLandscapeAnyPhoneSizeView()
    }
    
    func updateUIView(_ uiView: DifferentPortraitLandscapeAnyPhoneSizeView, context: Context) {
    }
}

@available (iOS 13.0, *)
struct IPhoneAnySizeDifferentPortraitLandscapeSizeViewRepresentation_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            IPhoneAnySizeDifferentPortraitLandscapeSizeViewRepresentation()
                .previewLayout(.fixed(width: 320, height: 568))
                .previewDisplayName("iPhone 5 Portrait")
            
            IPhoneAnySizeDifferentPortraitLandscapeSizeViewRepresentation()
                .environment(\.horizontalSizeClass, .compact)
                .environment(\.verticalSizeClass, .compact)
                .previewLayout(.fixed(width: 568, height: 320))
                .previewDisplayName("iPhone 5S Landscape")
            
            IPhoneAnySizeDifferentPortraitLandscapeSizeViewRepresentation()
                .environment(\.horizontalSizeClass, .regular)
                .environment(\.verticalSizeClass, .compact)
                .previewLayout(.fixed(width: 736, height: 414))
                .previewDisplayName("iPhone 8 Plus Landscape")
        }
    }
}
#endif
#endif
