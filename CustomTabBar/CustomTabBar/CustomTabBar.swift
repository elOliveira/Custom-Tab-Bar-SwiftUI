//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by cit on 11/09/22.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: String
    // Storing Each Tab Midpoints to animate it in future...
    @State var tabPoints: [CGFloat] = []

    var body: some View {
        HStack(spacing:0){
            TabBarButton(image: "magnifyingglass.circle", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "bubble.left.and.bubble.right", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "pawprint", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "globe.americas", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "bell", selectedTab: $selectedTab, tabPoints: $tabPoints)
        }
        .padding()
        .background(
            Color.white
                .clipShape(TabCurve(tabPoint: getCurvePoint() - 15))
        )
        .overlay(
            Circle()
                .fill(Color.yellow)
                .frame(width: 10, height: 10)
                .offset(x: getCurvePoint() - 20)
            
            ,alignment: .bottomLeading
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    // extracting point...
    func getCurvePoint() -> CGFloat {
        //IF tabpoint is empty...
        if tabPoints.isEmpty {
            return 10
        }else{
            switch selectedTab{
            case "magnifyingglass.circle":
                return tabPoints[0]
            case "bubble.left.and.bubble.right":
                return tabPoints[1]
            case "pawprint":
                return tabPoints[2]
            case "globe.americas":
                return tabPoints[3]
            default:
                return tabPoints[4]
            }
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

struct TabBarButton: View {
    
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    
    var body: some View {
        GeometryReader{ reader -> AnyView in
            // extracting MidPoint and Storing...
            let midX = reader.frame(in:.global).midX
            
            DispatchQueue.main.async {
                // avoiding junk data...
                if tabPoints.count <= 5 {
                    tabPoints.append(midX)
                }
            }

            return AnyView (
                Button(action: {
                    //changing tab...
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.5, blendDuration: 0.5)){
                        selectedTab = image
                    }
                }, label: {
                    // filling the color if it selected...
                    Image(systemName: "\(image)\(selectedTab == image ? ".fill" : "")")
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(Color("colorBackgroundTabBar"))// COLOR IS SELECTED
                    //Lifting View ...
                    // if its selected...
                        .offset(y: selectedTab == image ? -10 : 0)
                })
                // MAX FRAME
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        // MAX Height
        .frame(height: 50)
    }

}
