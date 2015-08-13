class Base
  def name=(name)
    @name = name
  end
end
base = Base.new
p base.name = "josh"
