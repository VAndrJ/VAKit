//
//  IPhoneAnySizeDifferentPortraitLandscapeSizeView.swift
//  VAKitStoryboardExamples
//
//  Created by Vladimir Andrienko on 22.06.2020.
//  Copyright © 2020 VAndrJ. All rights reserved.
//

import UIKit

/*
 Example view how to use VAView to create layout for different iPhones orientation.
 No constraints for iPad.
 */
class IPhoneAnySizeDifferentPortraitLandscapeSizeView: VAView {
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

#if DEBUG
#if canImport(SwiftUI)
import SwiftUI

@available (iOS 13.0, *)
struct IPhoneAnySizeDifferentPortraitLandscapeSizeViewRepresentation: UIViewRepresentable {
    typealias UIViewType = IPhoneAnySizeDifferentPortraitLandscapeSizeView
    
    func makeUIView(context: Context) -> IPhoneAnySizeDifferentPortraitLandscapeSizeView {
        return IPhoneAnySizeDifferentPortraitLandscapeSizeView()
    }
    
    func updateUIView(_ uiView: IPhoneAnySizeDifferentPortraitLandscapeSizeView, context: Context) {
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
