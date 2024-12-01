//
//  FavoritesTableView.swift
//  EventHub
//
//  Created by apple on 11/24/24.
//

import UIKit
import RealmSwift

class FavoritesTableView: UITableView {
    
    private var favorites: Results<FavoriteEvent>!
    private let favoritesService = FavoritesService()
    private var notificationToken: NotificationToken?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
        setDelegates()
        register(FavoritesTableViewCell.self, forCellReuseIdentifier: EventsUITableViewCell.idTableViewCell)
        
        loadFavorites()
        observeFavoritesChanges()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor = .white
        separatorStyle = .none
        //bounces = false
        showsVerticalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setDelegates() {
        dataSource = self
        delegate = self
    }
    
    private func loadFavorites() {
            favorites = favoritesService.getFavorites()
        }
        
        private func observeFavoritesChanges() {
            notificationToken = favorites.observe { [weak self] _ in
                self?.reloadData()
            }
        }
        
        deinit {
            notificationToken?.invalidate()
    }
}

extension FavoritesTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.idTableViewCell,
                                                       for: indexPath) as? FavoritesTableViewCell  else {
            return UITableViewCell()
        }
        
        let favorite = favorites[indexPath.row]
        cell.configure(with: favorite)
        return cell
    }
}

extension FavoritesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        110
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] _, _, completionHandler in
                    guard let self = self else { return }
                    
                    // Получаем объект события из списка
                    let favoriteEvent = self.favorites[indexPath.row]
                    
                    // Удаляем из базы данных
                    let favoritesService = FavoritesService()
                    favoritesService.removeFromFavorites(eventID: favoriteEvent.id)
                    
                    // Обновляем таблицу (удаляем строку)
                    // Вызываем метод `deleteRows(at:with:)`
                    self.deleteRows(at: [indexPath], with: .automatic)
                    
                    completionHandler(true)  // Завершаем действие
                }
                
                // Настройка внешнего вида действия
                deleteAction.backgroundColor = .red  // Цвет фона для кнопки
                deleteAction.image = UIImage(named: "delete")  // Иконка для удаления
                
                // Возвращаем конфигурацию для действия
                return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}
