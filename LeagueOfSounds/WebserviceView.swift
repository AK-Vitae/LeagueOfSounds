//
//  WebserviceView.swift
//  LeagueOfSounds
//
//  Created by AK on 7/25/20.
//  Copyright © 2020 AK-Vitae. All rights reserved.
//

import SwiftUI

struct WebserviceView: View {
    
    init() {
        Webservice().getVersion {
            print($0.patch)
        }
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct WebserviceView_Previews: PreviewProvider {
    static var previews: some View {
        WebserviceView()
    }
}
