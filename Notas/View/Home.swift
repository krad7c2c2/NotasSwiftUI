//
//  Home.swift
//  Notas
//
//  Created by Jorge Maldonado Borbón on 21/12/20.
//

import SwiftUI

struct Home: View {
    
    @StateObject var model = ViewModel()
    @Environment(\.managedObjectContext) var context
    //@FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring()) var results : FetchedResults<Notas>
    //@FetchRequest(entity: Notas.entity(), sortDescriptors: [],
    //              predicate: NSPredicate(format: "nota CONTAINS[c] 'IMPORTANTE'"),
    //              animation: .spring()) var results : FetchedResults<Notas>
    let buttonSize: CGFloat = 50
    var body: some View {
        VStack(alignment: .leading) {
            HStack() {
                Spacer()
                TextField("Buscar...", text: $model.search).padding(.leading, 15).textFieldStyle(.roundedBorder)
                Button {
                    model.searchI(context: context)
                } label: {
                    Image(systemName: "pencil")
                }.frame(width: buttonSize, height: buttonSize, alignment: .leading).padding(.leading, 15)
                Spacer()
            }
        NavigationView {
            List{
                ForEach(model.lista){ item in
                    VStack(alignment: .leading){
                        Text(item.nota ?? "Sin nota")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }.contextMenu(ContextMenu(menuItems: {
                        Button(action:{
                            model.sendData(item: item)
                        }){
                            Label(title:{
                                Text("Editar")
                            }, icon:{
                                Image(systemName: "pencil")
                            })
                        }
                        Button(action:{
                            model.deleteData(item: item, context: context)
                        }){
                            Label(title:{
                                Text("Eliminar")
                            }, icon:{
                                Image(systemName: "trash")
                            })
                        }
                    }))
                }
            }.onAppear{
                model.searchI(context: context)
            }
            .navigationBarTitle("Notas")
            .navigationBarItems(trailing:
                                    Button(action:{
                                        model.show.toggle()
                                    }){
                                        Image(systemName: "plus")
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                    }
            ).sheet(isPresented: $model.show, content: {
                addView(model: model)
            })
        }
    }
    }
}


