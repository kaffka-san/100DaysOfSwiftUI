//
//  ContentView.swift
//  Friends
//
//  Created by Anastasia Lenina on 08.08.2023.
//

import SwiftUI

enum UserStatus {
  case online, offline
}

struct UserInfo: View {
  let name: String
  let company: String
  let userStatus: UserStatus

  var body: some View {
    HStack{
      VStack(alignment: .leading) {
        Text(name)
          .foregroundColor(.primary)
          .font(.headline)
        Text(company)
          .font(.subheadline)
          .foregroundColor(.secondary)
      }
      Spacer()
      Text(userStatus == .online ? "online" : "offline")
        .font(.callout)
        .foregroundColor(.secondary)

    }
  }
}

struct UsersListView: View {
  @StateObject var userListViewModel = UserListViewModel()
    var body: some View {
      NavigationStack{
        List {
          Section {
            ForEach(userListViewModel.friendsOnline) { user in
              NavigationLink {
                DetailView(user: user)
              } label: {
                UserInfo(name: user.name, company: user.company, userStatus: user.isActive ? .online : .offline)

              }
            }
          }
          Section{
            ForEach(userListViewModel.friendsOffline) { user in
              NavigationLink {
                DetailView(user: user)
              } label: {
                UserInfo(name: user.name, company: user.company, userStatus: user.isActive ? .online : .offline)
              }
            }
          }

        }

        .onAppear{
          Task{
            await userListViewModel.fetchUsers()
          }
        }
        .navigationTitle("Friends")
      }

    }
}

struct friendsListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }
}
