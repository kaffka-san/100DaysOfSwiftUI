//
//  ContentView.swift
//  Friends
//
//  Created by Anastasia Lenina on 08.08.2023.
//

import SwiftUI
import CoreData

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
            ForEach(userListViewModel.storedUsers) { user in
              NavigationLink {
                DetailView(user: user)
              } label: {
                UserInfo(name: user.wrappedName, company: user.wrappedCompany, userStatus: user.isActive ? .online : .offline)

              }
            }
          }
//          Section{
//            ForEach(userListViewModel.usersOffline) { user in
//              NavigationLink {
//                DetailView(user: user)
//              } label: {
//                UserInfo(name: user.wrappedName, company: user.wrappedCompany, userStatus: user.isActive ? .online : .offline)
//              }
//            }
//          }

        }
      }
      .task {
        await userListViewModel.fetchUsers()
      }
      .onAppear{
        whereIsMySQLite()
      }
      .navigationTitle("Friends")
    }
  func whereIsMySQLite() {
      let path = NSPersistentContainer
          .defaultDirectoryURL()
          .absoluteString
          .replacingOccurrences(of: "file://", with: "")
          .removingPercentEncoding

      print(path ?? "Not found")
  }
}

struct friendsListView_Previews: PreviewProvider {
    static var previews: some View {
        UsersListView()
    }

}
