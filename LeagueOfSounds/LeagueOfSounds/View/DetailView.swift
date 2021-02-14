//
//  DetailView.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/13/21.
//

import SwiftUI

struct DetailView: View {
    let champName: String
    let champChangedName: String
    let version: String
    
    var body: some View {
        Text(champName)
        Text(champChangedName)
        Text(version)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(champName: "TestChampName", champChangedName: "Test ChampName", version: "TestVersion")
    }
}
