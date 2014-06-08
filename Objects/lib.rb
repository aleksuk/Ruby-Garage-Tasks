class Book

  attr_reader :name

  def initialize name
    @name = name
  end

end

class Order

  attr_reader :name, :order_date, :issue_date

  def initialize name, book, order_date, issue_date = 0
    @name, @order_date, @issue_date, @book = name, order_date, issue_date, book
  end

  def book
    @book.name
  end

end

class Library
  Top_visitor = 3

  def initialize
    @orders = []
  end

  public

  def new_order order
    @orders << order
  end

  def not_satisfied_order_count
    count = 0

    @orders.each do |order|
      count += 1 if order.issue_date == 0
    end

    count
  end

  def min_library_search
    min = 999

    @orders.each do |order|
      library_search_time = order.issue_date - order.order_date
      min = library_search_time if library_search_time > 0 && library_search_time < min
    end

    min
  end

  def get_top_visitors
    top_visitors = []
    visitors = get_unique :name

    visitors.each do |uniq_order|
      current = 0

      @orders.each do |order|
        current += 1 if order.name == uniq_order.name
      end

      top_visitors << uniq_order.name if current > 3
    end

    top_visitors
  end

  def get_top_book
    get_top_books[0]
  end

  def count_people_who_ordered_one_of_the_three_most_popular_books
    count = 0
    top_books = get_top_books

    top_books.each do |book|
      count += @orders.select do |order|
        order.book == book
      end.size
    end

    count
  end

  private

  def get_unique param
    @orders.uniq do |el|
      el.method(param).call
    end
  end

  def get_top_books
    top_books = []
    books = get_unique :book

    books.each.with_index do |book, index|
      count = @orders.count do |order|
        order.book == book.book
      end

      top_books << [count, book.book]
    end

    top_books.sort! do |a, b|
      a[0] <=> b[0]
    end

    top_books.take(3).map do |book|
      book[1]
    end
  end

end

a = Library.new
a.new_order(Order.new('Name', Book.new('Some book'), 10, 42))
a.new_order(Order.new('Name', Book.new('Some book2'), 10, 22))
a.new_order(Order.new('Name', Book.new('Some book5'), 10, 32))
a.new_order(Order.new('Name2', Book.new('Some book'), 10, 52))
a.new_order(Order.new('sme2', Book.new('Some book'), 10, 52))
a.new_order(Order.new('Name2', Book.new('Some book2'), 10, 22))
a.new_order(Order.new('Name2', Book.new('Some book2'), 10, 22))
a.new_order(Order.new('Name2', Book.new('Some book2'), 10, 0))
a.new_order(Order.new('Name', Book.new('Some book2'), 10, 22))
a.new_order(Order.new('Name', Book.new('Some book2'), 10, 22))
a.new_order(Order.new('Name', Book.new('Some book3'), 10, 22))
a.new_order(Order.new('Name', Book.new('Some book3'), 10, 22))
a.new_order(Order.new('Name', Book.new('Some book2'), 10, 22))
a.new_order(Order.new('Name', Book.new('Some book2'), 10, 22))
a.new_order(Order.new('Name4', Book.new('Some book4'), 10, 22))
a.new_order(Order.new('Name4', Book.new('Some book4'), 10, 22))
a.new_order(Order.new('Name4', Book.new('Some book4'), 10, 22))
a.new_order(Order.new('Name4', Book.new('Some book4'), 10, 22))

p a.get_top_book
p a.get_top_visitors
p a.not_satisfied_order_count
p a.min_library_search
p a.count_people_who_ordered_one_of_the_three_most_popular_books
