require 'enum'

class BitflagEnum < Enum

  private

  def populate(*members)
    options = members.extract_options!
    start = Math.log(options.fetch(:start) { 1 }, 2).to_i

    update Hash[members.zip((start..members.count + start).map{|i| 2**i})]
  end
end