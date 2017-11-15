require('pry-byebug')
require('pp')
require_relative('models/bounties.rb')

bounty_01 = Bounties.new(
  {
  'name' => 'Randy',
  'favourite_weapon' => 'block of cheese',
  'bounty_value' => '20',
  'cashed_in' => 'true'
  }
)

bounty_02 = Bounties.new(
  {
  'name' => 'Des',
  'favourite_weapon' => 'ray gun',
  'bounty_value' => '50',
  'cashed_in' => 'false'
  }
)

# Bounties.delete_all

bounty_01.save
bounty_02.save
# bounty_01.delete
#
# bounty_01.name = 'Jemima'
Bounties.update_by_id(11, 'John')


Bounties.delete_by_id(1)
pp Bounties.find(11)

binding.pry
nil
