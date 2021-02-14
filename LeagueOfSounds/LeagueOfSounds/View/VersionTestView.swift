//
//  VersionTestView.swift
//  LeagueOfSounds
//
//  Created by Akshith Ramadugu on 2/13/21.
//

import SwiftUI

struct VersionTestView: View {
    @ObservedObject var versionManager = VersionDataManager()
    
    var body: some View {
        ContentView(version: self.versionManager.versionsFromData[0])
            .onAppear {
                self.versionManager.fetchVersion()
            }
    }
}

struct VersionTestView_Previews: PreviewProvider {
    static var previews: some View {
        VersionTestView()
    }
}
