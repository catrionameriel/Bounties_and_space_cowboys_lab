require('pg')

class Bounties

  attr_accessor :name, :favourite_weapon, :bounty_value, :cashed_in
  attr_reader :id

    def initialize(information)

      @name = information['name']
      @favourite_weapon = information['favourite_weapon']
      @bounty_value = information['bounty_value'].to_i
      @cashed_in = information['cashed_in']
      @id = information['id'].to_i if information['id']

    end

    def save
      db = PG.connect({dbname:'bounties_database', host:'localhost'})
      sql = "INSERT INTO bounties_table
      ( name,
        favourite_weapon,
        bounty_value,
        cashed_in
      ) VALUES
      ($1, $2, $3, $4)
      RETURNING * "
      values = [@name, @favourite_weapon, @bounty_value, @cashed_in]
      db.prepare("save", sql)
      @id = db.exec_prepared("save", values)[0]["id"].to_i
      db.close
    end

    def update
      db = PG.connect( {dbname: 'bounties_database', host: 'localhost'} )
      sql = "UPDATE bounties_table SET (
      name,
      favourite_weapon,
      bounty_value,
      cashed_in
      ) = (
      $1, $2, $3, $4
      )
      WHERE id = $5"
      values = [@name, @favourite_weapon, @bounty_value, @cashed_in, @id]
      db.prepare("update", sql)
      db.exec_prepared("update", values)
      db.close
    end

    def self.delete_by_id(id)
      db = PG.connect( { dbname: 'bounties_database', host: 'localhost'} )
      sql = "DELETE FROM bounties_table WHERE id = $1"
      values = [id]
      db.prepare("delete_by_id", sql)
      db.exec_prepared("delete_by_id", values)
      db.close
    end

end
