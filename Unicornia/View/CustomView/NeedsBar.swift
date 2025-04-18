import SwiftUI

struct OneNeedBar: View {
    let activeSegmentsCount: Int
    let imageName: String
    
    static let totalSegmentsCount = 4 // Число сегментов в баре
    
    var body: some View {
        GeometryReader { geometry in
            let segmentWidth = (geometry.size.width - CGFloat(OneNeedBar.totalSegmentsCount - 1) * 2) / CGFloat(OneNeedBar.totalSegmentsCount)
            
            HStack(spacing: -20) {
                HStack(spacing: 1) {
                    ForEach(0..<OneNeedBar.totalSegmentsCount, id: \.self) { index in
                        Rectangle()
                            .fill(index < activeSegmentsCount ? Color.init(hexString: "EE40D7") : Color.init(hexString: "FFFFFF"))
                            .frame(width: segmentWidth, height: 15)
                    }
                }
                .background(.black)
                .cornerRadius(20)
                
                Image(imageName)
                    .resizable()
                    .frame(width: 24, height: 24)
            }
        }
        .frame(height: 15)
    }
}

struct NeedsBar: View {
    @ObservedObject var tamagotchiService = TamagotchiService.shared

    var body: some View {
        VStack(spacing: 10) {
            OneNeedBar(activeSegmentsCount: tamagotchiService.needs["food"] ?? 0, imageName: "hungry_button")
            OneNeedBar(activeSegmentsCount: tamagotchiService.needs["care"] ?? 0, imageName: "grooming_button")
            OneNeedBar(activeSegmentsCount: tamagotchiService.needs["energy"] ?? 0, imageName: "sleep_button")
            OneNeedBar(activeSegmentsCount: tamagotchiService.needs["happiness"] ?? 0, imageName: "TV_button")
        }
        .padding(10)
    }
}
