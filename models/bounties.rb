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

    def delete
      db = PG.connect( { dbname: 'bounties_database', host: 'localhost'} )
      sql = "DELETE FROM bounties_table WHERE id = $1"
      values = [@id]
      db.prepare("delete", sql)
      db.exec_prepared("delete", values)
      db.close
    end

    def self.find(id)
      db = PG.connect( { dbname: 'bounties_database', host: 'localhost'} )
      sql = "SELECT * FROM bounties_table WHERE id = $1"
      values = [id]
      db.prepare('find', sql)
      found_row = db.exec_prepared('find', values)
      return found_row.map {|hash| Bounties.new(hash)}
      db.close
    end

    # def Bounty.find(id) # ANSWER FROM TUTORS
    #   db = PG.connect({dbname: 'bounty_hunter', host: 'localhost'})
    #   sql = "SELECT * FROM bounties
    #   WHERE id = $1"
    #   values = [id]
    #   db.prepare("find", sql)
    #   results_array = db.exec_prepared("find", values)
    #   bounty_hash = results_array[0]
    #   bounty = Bounty.new(bounty_hash)
    #   return bounty
    # end


    def self.update_name_by_id(id, updated_name)
      db = PG.connect( {dbname: 'bounties_database', host: 'localhost'} )
      sql = "UPDATE bounties_table SET (
      name,
      favourite_weapon,
      bounty_value,
      cashed_in
      )
      =
      ($1, $2, $3, $4)
      WHERE id = $5"
      values = [updated_name, @favourite_weapon, @bounty_value, @cashed_in, id]
      db.prepare("update_by_id", sql)
      db.exec_prepared("update_by_id", values)
    end

    def self.delete_all
      db = PG.connect( {dbname: 'bounties_database', host: 'localhost'} )
      sql = "DELETE FROM bounties_table"
      values = []
      db.prepare("delete_all", sql)
      db.exec_prepared("delete_all", values)
    end
end
