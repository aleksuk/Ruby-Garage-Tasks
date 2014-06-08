class Mail
  attr_reader :city, :street, :house, :apartment, :destination, :value

  def initialize city, street, house, apartment, destination, value
    @city, @street, @house, @apartment, @destination, @value = city, street, house, apartment, destination, value
  end

  def get_address
    "#{@city} #{@street} #{@house} #{@apartment}"
  end

end

class Mail_Sorter

  def initialize
    @mails = []
  end

  public

  def add_mail mail
    @mails << mail
  end

  def get_mails_count_for_cities
    count_mails_for_cities = {}

    @mails.each do |mail|
      count_mails_for_cities[mail.city] ||= 0
      count_mails_for_cities[mail.city] += 1
    end

    count_mails_for_cities
  end

  def get_popular_address
    uniq_adress = {}
    count_of_mails = 0
    top_address = ''

    @mails.each do |mail|
      uniq_adress[mail.get_address] ||= 0
      uniq_adress[mail.get_address] += 1
    end

    uniq_adress.each do |key, value|
      top_address, count_of_mails = key, value if value > count_of_mails
    end

    top_address
  end

  def get_count_mails_with_value_higher_than_ten
    count = 0

    @mails.each do |mail|
      count += 1 if mail.value > 10
    end

    count
  end

end

mail = Mail_Sorter.new
mail.add_mail Mail.new('City', 'SomeStreet', 'house', 12, 'destination', 55)
mail.add_mail Mail.new('City', 'SomeStreet', 'house', 12, 'destination', 1)
mail.add_mail Mail.new('City', 'SomeStreet', 'house', 12, 'destination', 2)
mail.add_mail Mail.new('City2', 'SomeStreet', 'house', 13, 'destination', 33)
mail.add_mail Mail.new('City1', 'SomeStreet', 'house', 12, 'destination', 4)
p mail.get_mails_count_for_cities
p mail.get_popular_address
p mail.get_count_mails_with_value_higher_than_ten