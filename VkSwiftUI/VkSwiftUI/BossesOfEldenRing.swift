//
//  BossesOfEldenRing.swift
//  VkSwiftUI
//
//  Created by Sokolov on 22.02.2023.
//

import SwiftUI

struct BossesOfEldenRing: View {
    
    @EnvironmentObject var router: TabRouter
    
    private let bossList: [BossInfo] = [
        BossInfo(name: "Margit, the Fell Omen", imageName: "Margit", desription: "The first big boss you need to take down is surprisingly tough compared to your usual Souls game battles. You need to take down Margit in order to reach Godrick and claim his Great Rune. Margit is located in Stormveil Castle."),
        BossInfo(name: "Godrick the Grafted", imageName: "Godrick", desription: "Yes, then comes Godrick. Arguably much easier to take down than Margit, but even more necessary for completion of the game. Godrick is deeper within Stormveil castle than Margit."),
        BossInfo(name: "Red Wolf of Radagon", imageName: "RedWolf", desription: "Found with the Academy of Raya Lucaria, the Red Wolf of Radagon is fast and shoots a lot of spells around the battlefield. You can begin to predict its movements if you focus, but if you don’t have that patience, Spirit Ashes help too."),
        BossInfo(name: "Rennala, Queen of the Full Moon", imageName: "Rennala", desription: "Another boss required to earn a Great Rune, Rennala is the final boss of the Academy of Raya Lucaria. After defeating them, Rennala allows you to reset your stats and change your build."),
        BossInfo(name: "Rykard, Lord of Blasphemy", imageName: "Rykard", desription: "You only need two Great Runes to get an ending in Elden Ring, but Rykard has yet another, and can be found in Volcano Manor in the Northwestern portion of the Lands Between."),
        BossInfo(name: "Starscourge Radahn", imageName: "Radahn", desription: "Another Great Rune bearer, Radahn rules the wastelands of Caelid, and can only be fought after the start of the Radahn Festival in Redmane Castle. If you’ve already been to Redmane Castle, the event will start in the room where you beat the boss of the initial castle."),
        BossInfo(name: "Godfrey, First Elden Lord", imageName: "Godfrey", desription: "Godfrey is a mean and powerful boss, lurking in Leyndell. Except, this isn’t actually Godfrey, merely a shade – just a taste of his true power. "),
        BossInfo(name: "Maliketh, the Black Blade", imageName: "Malikeht", desription: "This is one of the coolest bosses in the game, and will devastate you with incredibly swift attacks if you’re not careful. "),
        BossInfo(name: "Sir Gideon Ofnir, the All-Knowing", imageName: "Gideon", desription: "While Gideon has been good to you in Roundtable Hold, he’s not so kind once you encounter him out in the open. He doesn’t believe a Tarnished can become Elden Lord, and won’t even allow you to try."),
        BossInfo(name: "Elden Beast", imageName: "EldenBest", desription: "Those are all of the big bosses you need to take down while playing Elden Ring, but there are many more bosses hiding away in dungeons, caves, catacombs, and just wandering the world at different times of day. Exploring the game world will reveal so much, so make sure to roam if you feel the need to level up."),
        BossInfo(name: "Radagon of the Golden Order", imageName: "Radagon", desription: "Another two-for-one boss battle, Radagon is the mysterious character you’ve been hearing about since the beginning of the game, and while he’s falling apart, he brims with the holy power of the Golden Order. But once he’s done, the true nature of the Elden Ring is revealed, and you must overcome the cosmic Elden Beast.")
    ]
//    let names = ["Margit, the Fell Omen",
//                 "Godrick the Grafted",
//                 "Red Wolf of Radagon",
//                 "Rennala, Queen of the Full Moon",
//                 "Rykard, Lord of Blasphemy",
//                 "Starscourge Radahn",
//                 "Godfrey, First Elden Lord",
//                 "Maliketh, the Black Blade",
//                 "Sir Gideon Ofnir, the All-Knowing",
//                 "Elden Beast",
//                 "Radagon of the Golden Order"]
    
    var body: some View {
        NavigationView {
            List(bossList) { bossInfo in
                NavigationLink(destination: BossInfoView(bossInfo: bossInfo)) {
                    Text(bossInfo.name)
                    }
                }
            .navigationTitle("Elden Ring bosses")
            }

        }
    }

struct BossInfoView: View {
    
    let bossInfo: BossInfo
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Image(bossInfo.imageName)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 330, trailing: 20))
            Text(bossInfo.desription)
                .padding(EdgeInsets(top: -290, leading: 20, bottom: 0, trailing: 20))
        }
        .navigationTitle(bossInfo.name).navigationBarTitleDisplayMode(.inline)
    }
}

struct BossInfo: Identifiable {
    
    var id = UUID()
    var name: String
    var imageName: String
    var desription: String
}

struct BossesOfEldenRing_Previews: PreviewProvider {
    static var previews: some View {
        BossesOfEldenRing()
    }
}
