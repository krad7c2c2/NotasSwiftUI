//
//  ViewModel.swift
//  Notas
//
//  Created by Jorge Maldonado Borbón on 21/12/20.
//

import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject {
      
    @Published var search = ""
    @Published var nota = ""
    @Published var fecha = Date()
    @Published var show = false
    @Published var updateItem : Notas!
    @Published var tipo = ""
    @Published var lista: [Notas] = []
    
    
    func searchI(context: NSManagedObjectContext) {
        do {
               lista = []
               let fetchRequest : NSFetchRequest<Notas> = Notas.fetchRequest()
            if search == "" {
                print("s")
            } else {
                fetchRequest.predicate = NSPredicate(format: "nota CONTAINS[c] '\(search)'")
            }
               let fetchedResults = try context.fetch(fetchRequest)
               fetchedResults.forEach { (item) in
                    let newNota = Notas(context: context)
                    newNota.nota = item.nota
                    newNota.fecha = item.fecha
                    lista.append(newNota)
               }
               print("______")
               print(lista)
        } catch {
               print ("fetch task failed", error)
        }
    }
    
    func saveData(context: NSManagedObjectContext){
        let newNota = Notas(context: context)
        newNota.nota = nota
        newNota.fecha = fecha

        do {
            try context.save()
            print("guardo")
            show.toggle()
            nota = ""
            fecha = Date()            
        } catch let error as NSError {
            // alerta al usario
            print("No guardo", error.localizedDescription)
        }
    }
    
    func deleteData(item:Notas,context: NSManagedObjectContext){
        context.delete(item)
        //try! context.save()
        do {
            try context.save()
            print("Elimino")
        } catch let error as NSError {
            // alerta al usario
            print("No elimino", error.localizedDescription)
        }
    }
    
    func sendData(item: Notas){
        updateItem = item
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        show.toggle()
    }
    
    func editData(context: NSManagedObjectContext){
        updateItem.fecha = fecha
        updateItem.nota = nota
        do {
            try context.save()
            print("edito")
            show.toggle()
        } catch let error as NSError {
            print("No edito", error.localizedDescription)
        }
    }
    
}
