//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Gonzalo Gamez on 6/4/20.
//  Copyright © 2020 Gamez. All rights reserved.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var sizeClass
    @EnvironmentObject var favorites: Favorites
    @State private var selectedFaciltiy: String?
    
    let resort: Resort
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                
                Text("Image Credit: \(resort.imageCredit)")                   
                
                Group {
                    HStack {
                        if sizeClass == .compact{
                        Spacer()
                            VStack{
                        ResortDetailsView(resort: resort)
                            }
                            VStack{
                        SkiDetailsView(resort: resort)
                            }
                        Spacer()
                            } else {
                                ResortDetailsView(resort: resort)
                                Spacer().frame(height: 0)
                                SkiDetailsView(resort: resort)
                            }
                        }
                    
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.top)
                }
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    HStack {
                        ForEach(resort.facilities) {facility in
                            Facility.icon(for: facility)
                                .font(.title)
                                .onTapGesture {
                                    self.selectedFaciltiy = facility
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                    if self.favorites.contains(self.resort) {
                        self.favorites.remove(self.resort)
                    } else {
                        self.favorites.add(self.resort)
                    }
                }
            }
        }
        .navigationBarTitle(Text("\(resort.name),\(resort.country)"), displayMode: .inline)
        .alert(item: $selectedFaciltiy) { facility in
            Facility.alert(for: facility)
        }
    }
}

extension String: Identifiable {
    public var id: String { self }
}
struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
        ResortView(resort: Resort.example)
    }
}
