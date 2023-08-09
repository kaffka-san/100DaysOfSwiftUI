//
//  DetailView.swift
//  Friends
//
//  Created by Anastasia Lenina on 08.08.2023.
//

import SwiftUI

struct DetailView: View {
  var user: UserCached

  var body: some View {
    Group {
      ScrollView {
        userCard
        detailCard
        tags
        //friendsGroup
      }
    }
    .background{
      Rectangle()
        .fill(.gray.opacity(0.15))
        .frame(width: UIScreen.main.bounds.width)
        .ignoresSafeArea()

    }
    .navigationTitle("\(user.wrappedName)")
    .navigationBarTitleDisplayMode(.inline)

  }
  var userCard: some View  {
    Group {
      VStack(alignment: .leading, spacing: 10) {
        Text(user.wrappedName)
          .font(.largeTitle)
          .padding(.vertical, 5)
        HStack {
          VStack(alignment: .leading, spacing: 10) {
            Label {
              Text("joined: \(user.wrappedRegistered.formatted(date: .numeric, time: .omitted))")
                .foregroundColor(.secondary)

            } icon: {
              Image(systemName: "calendar")
                .foregroundColor(.secondary)
            }
            Label {
              Text("age: \(user.age)")
                .foregroundColor(.secondary)

            } icon: {
              Image(systemName: "person")
                .foregroundColor(.secondary)
            }
            Label {
              Text("company: \(user.wrappedCompany)")
                .foregroundColor(.secondary)

            } icon: {
              Image(systemName: "building.columns")
                .foregroundColor(.secondary)
            }
            Label {
              Text(user.wrappedEmail)
                .foregroundColor(.secondary)

            } icon: {
              Image(systemName: "envelope")
                .foregroundColor(.secondary)
            }
            Label {
              Text(user.wrappedAddress)
                .foregroundColor(.secondary)

            } icon: {
              Image(systemName: "house")
                .foregroundColor(.secondary)
            }
          }

          Spacer()
        }
      }
    }
    .padding(20)
    .background(.background)
    .cornerRadius(20)
    .padding()
  }
  var detailCard: some View {
    Group {
      VStack(alignment: .leading) {
        Text("Detail")
          .font(.largeTitle)
          .padding(.vertical, 5)

        Text(user.wrappedAbout)
          .foregroundColor(.secondary)

      }
      .padding(20)
      .background(.background)
      .cornerRadius(20)
      .padding()
    }

  }

  var tags: some View {
    Group {
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          ForEach (user.wrappedTags, id: \.self){ tag in
            Text(tag)
              .padding(20)
              .background(.background)
              .cornerRadius(20)
              .foregroundColor(.secondary)
          }
        }
      }
      .padding()
    }
  }
 /* var friendsGroup: some View {
    Group {
      VStack(alignment: .leading) {
        Text("Friends:")
          .font(.largeTitle)
          .padding(.vertical, 5)
        ForEach(user.wrappedFriends) { friend in

          Text(friend.name)
            .foregroundColor(.secondary)
            .padding(10)

        }
        .frame(width: 320, alignment: .leading)
        .background(.gray.opacity(0.09))
        .cornerRadius(20)
      }
      .padding(20)
      .background(.background)
      .cornerRadius(20)
      .padding()
    }

  }*/



}

/*struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(user: User(
      id: "01",
      isActive: true,
      name: "Angela Smith",
      age: 32,
      company: "StarLight",
      email: "angela@gmail.com",
      address: "24 Boulevard, 23-43",
      about: "Laboris ut dolore ullamco officia mollit reprehenderit qui eiusmod anim cillum qui ipsum esse reprehenderit. Deserunt quis consequat ut ex officia aliqua nostrud fugiat Lorem voluptate sunt consequat. Sint exercitation Lorem irure aliquip duis eiusmod enim. Excepteur non deserunt id eiusmod quis ipsum et consequat proident nulla cupidatat tempor aute. Aliquip amet in ut ad ullamco. Eiusmod anim anim officia magna qui exercitation incididunt eu eiusmod irure officia aute enim.",
      registered: Date(),
      tags: [ "irure","labore","mollit","et", "sfe", "skdser"],
      friends: [
        Friend(id: "1c18ccf0-2647-497b-b7b4-119f982e6292", name: "Anastasia Maria Holland"),
        Friend(id: "1c18ccf0-2647-497b-b7b4-119f982e6293", name: "James Bond"),
        Friend(id: "1c18ccf0-2647-497b-b7b4-119f982e6294", name: "Lilly Bond"),
        Friend(id: "1c18ccf0-2647-497b-b7b4-119f982e6295", name: "Denisa Bond"),
        Friend(id: "1c18ccf0-2647-497b-b7b4-119f982e6296", name: "Sam Bond"),
        Friend(id: "1c18ccf0-2647-497b-b7b4-119f982e6297", name: "Anastasia Bonderas")
      ]))
  }
}*/

