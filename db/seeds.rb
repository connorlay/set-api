user1 = FactoryGirl.create :user
user2 = FactoryGirl.create :user

lobby = FactoryGirl.create :lobby
lobby.add_user(user1)
lobby.add_user(user2)

game = lobby.create_game deck: CardsTableFactory.create_cards_table.ids
game.setup!
