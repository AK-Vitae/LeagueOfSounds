//
//  VersionView.swift
//  LeagueOfSounds
//
//  Created by AK on 7/25/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import SwiftUI

struct VersionView: View {
    @EnvironmentObject var fetch : FetchVersion
    
    var body: some View {
        VStack{
            Text("Patch: \(fetch.version)")
        }.onAppear()
    }
}

struct VersionView_Previews: PreviewProvider {
    static var previews: some View {
        VersionView()
    }
}
