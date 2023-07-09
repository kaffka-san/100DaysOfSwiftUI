//
//  DetailView.swift
//  Habbit Tracker
//
//  Created by Anastasia Lenina on 09.07.2023.
//

import SwiftUI
import Liquid
struct DetailView: View {
    @State var selectedActivity: Activity
    @ObservedObject var activities: Activities
    var body: some View {
        VStack() {
            Spacer()
            VStack(spacing: 40){

                Text(selectedActivity.nameTitie)
                    .font(.system(size: 50, weight: .bold))
                Text(selectedActivity.description)
                    .font(.system(size: 20, weight: .regular))
                ZStack {
                    Circle()
                        .fill(.indigo)
                        .frame(width: 100)
                    Text(String(selectedActivity.completionCount))
                       // .foregroundColor(.white)
                        .font(.title)

                }
            }
            .frame(width: 300)
            .padding(20)
            .background(Color.indigo.opacity(0.4))
            .backgroundBlur(radius: 30, opaque: true)
            .clipShape(RoundedRectangle(cornerRadius: 30))
            Spacer()
            Spacer()
            Spacer()
            Button {
                increment(activity: selectedActivity)
            } label: {
                Text("Increment")
                    .font(.system(size: 15, weight: .bold))
            }
            .padding(.horizontal, 80)
            .padding(.vertical, 20)
            .background(Color.mainColor)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: 30))
        }
        .tint(.mainColor)
        .accentColor(.mainColor)
        .backgroundAnimation()
    }
    func increment(activity: Activity) {
        let newActivity = Activity(nameTitie: activity.nameTitie, description: activity.description, completionCount: activity.completionCount + 1 )
        if let index = activities.activities.firstIndex(of: activity) {
            activities.activities[index] = newActivity
            selectedActivity = newActivity
        }

    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(selectedActivity: Activity(nameTitie: "tit", description: "Activity description", completionCount: 0), activities: Activities()).preferredColorScheme(.dark)
    }
}
