//
//  ContentView.swift
//  Moonshot
//
//  Created by Meitar Basson on 17/07/2022.
//

import SwiftUI

struct myButton: View {
    @State var color: Color
    
    let label: String
    let image: String
    
    var body: some View {
        Button {
            // Do something
        } label: {
            Label(label, systemImage: image)
                .foregroundColor(color)
        }

    }
}

struct GridLayout: View{
    let missions : [Mission]
    let astronauts: [String : Astronaut]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    
    ]
    
    var body: some View{

        ScrollView{
            LazyVGrid(columns: columns){
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack{
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            
                            VStack{
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                            
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10 ))
                        .overlay{
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        }
                        
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ListLayout: View {
    let missions : [Mission]
    let astronauts: [String : Astronaut]
    
    var body: some View{
        List{
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack(){
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .padding()
                        
                        VStack{
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .padding(.vertical)
                        .frame(maxWidth: .infinity)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10 ))
                    
                }
            }
            .listRowBackground(Color.darkBackground)
            
        }
    }
}


struct ContentView: View {
    @State private var showingGrid = true
        var body: some View {
            let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
            let missions: [Mission] = Bundle.main.decode("missions.json")
            
            NavigationView{
                Group{
                    if showingGrid {
                        GridLayout(missions: missions, astronauts: astronauts)
                    } else {
                        ListLayout(missions: missions, astronauts: astronauts)
                            .listStyle(.plain)
                    }
                    
                }
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .preferredColorScheme(.dark)
                .toolbar{
                    Button("Switch"){
                        showingGrid.toggle()
                    }
                }
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
