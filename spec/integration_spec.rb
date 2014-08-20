require 'rspec'
require_relative '../location'
require_relative '../game'

describe 'how the game works' do
  it 'plays the game' do
    @see = []
    @enter = []
    treetrunks_location = Location.new(:description => "Bench, but no crumbs, but treetrunks is here!", :treetrunks => true)
    game = Game.new({
      [0,1] => Location.new(:description => "No crumbs, maybe to the east?"),
      [1,1] => treetrunks_location,
      [2,1] => Location.new(:description => "Crumbs!", :breadcrumbs => :true),
      [2,2] => Location.new(:description => "Apple Shop", :shop => true, :shop_inventory => [:apple]),
      [1,2] => treetrunks_location

    })

    see("You're a fancy looking duck, what is your name?")
    enter("Ellie")
    see("Hi Ellie")
    see(nil)

    see("What would you like to do?")
    enter("m E")
    see("You went E, good work Ellie.")
    see("You are at [0, 1].")
    see("No crumbs, maybe to the east?")
    see(nil)

    see("What would you like to do?")
    enter("m s")
    see("You went S, good work Ellie.")
    see("You are at [1, 1].")
    see("Bench, but no crumbs, but treetrunks is here!")
    see("say sorry you need an apple to trade for pie")
    see(nil)

    see("What would you like to do?")
    enter("m s")
    see("You went S, good work Ellie.")
    see("You are at [2, 1].")
    see("Crumbs!")
    see(nil)

    see("What would you like to do?")
    enter("i")
    see("Your health is currently 47.")
    see("+-------+")
    see("| b |   |\n|---+---|\n|   |   |")
    see("+-------+")
    see(nil)
    #
    #
    see("What would you like to do?")
    enter("m e")
    see("You went E, good work Ellie.")
    see("You are at [2, 2].")
    see("Apple Shop")
    see("We have:")
    see("  - apple (1)")
    see("Would you like to buy some? 1 breadcrumb per item. (Type 'buy [item]')")
    enter("buy apple")
    see("You have purchased apple")
    see(nil)

    see("What would you like to do?")
    enter("i")
    see("Your health is currently 46.")
    see("+-------+")
    see("| a |   |\n|---+---|\n|   |   |")
    see("+-------+")
    see(nil)

    see("What would you like to do?")
    enter("m n")
    see("You went N, good work Ellie.")
    see("You are at [1, 2].")
    see("make pie")
    see("Bench, but no crumbs, but treetrunks is here!")
    see(nil)

    see("What would you like to do?")
    enter("i")
    see("Your health is currently 45.")
    see("+-------+")
    see("| p |   |\n|---+---|\n|   |   |")
    see("+-------+")
    see(nil)

    see("What would you like to do?")
    enter("m n")
    see("You've strayed too far! A helpful human put you back in the park.")
    see("Bench, but no crumbs, but treetrunks is here!")
    see("You are at [1, 2].")
    see("say sorry you need an apple to trade for pie")
    see(nil)

    see("What would you like to do?")
    enter("wrong command")
    see("You're addled! That's not a vaild command.")
    see(nil)

    see("What would you like to do?")
    enter("exit")

    @see.reverse.each do |string|
      expect(game).to receive(:puts).with(string)
    end
    allow(game).to receive(:gets).and_return(*@enter)

    game.run
  end

  def see(string)
    @see << string
  end

  def enter(string)
    @enter << string
  end
end
