Game = Struct.new :id, :turnsRemaining, :hidingSpots do
  def self.go
    q = File.read "tmp/query"
    BlogSchema.execute q
  end
end
