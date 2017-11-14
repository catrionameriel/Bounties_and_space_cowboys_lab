require('pry-byebug')
require('pp')
require_relative('models/bounties.rb')

bountie_01 = Bounties.new(
  {
  'name' => 'Randy',
  'favourite_weapon' => 'block of cheese',
  'bounty_value' => '20',
  'cashed_in' => 'true'
}
)

bountie_01.save

bountie_01.name = 'Joe'
bountie_01.update


binding.pry
nil
