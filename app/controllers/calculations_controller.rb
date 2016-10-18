class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(/\s+/, "").length

    word_array = @text.split(' ')

    @word_count = word_array.length

    @occurrences = 0

    word_array.each do |word|
      if @special_word.downcase == word.downcase
        @occurrences += 1
      end
    end

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    rate = @apr/12/100
    months = @years*12
    if rate == 0
      @monthly_payment = (@principal/months)
    else
      @monthly_payment = ((rate*@principal*(1+rate)**months)/((1+rate)**months - 1))
    end
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = (@seconds / 60)
    @hours = (@minutes / 60)
    @days = (@hours / 24)
    @weeks = (@days / 7)
    @years = (@days / 365.25)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @sorted_numbers.length

    @minimum = @sorted_numbers[0]

    @maximum = @sorted_numbers[@count-1]

    @range = @maximum - @minimum

    if @count.even?
      @median = (@sorted_numbers[@count/2] + @sorted_numbers[@count/2 - 1])/2
    else
      @median = @sorted_numbers[@count/2 - 0.5]
    end

    @sum = 0
    @sorted_numbers.each do |num|
      @sum += num
    end


    @mean = @sum / @count

    varsum = 0
    @sorted_numbers.each do |num|
      varsum += (num - @mean)**2
    end
    @variance = varsum / @count

    @standard_deviation = Math.sqrt(@variance)

    num_counts = Hash.new(0)

    @sorted_numbers.each do |num|
      num_counts[num] += 1
    end

    @mode = @sorted_numbers[0]
    @sorted_numbers.each do |num|
      if num_counts[@mode] < num_counts[num]
        @mode = num
      end
    end

    # num_counts = @sorted_numbers.map { |count|
    #   count = 0
    #
    # }

    # num_counts = Array.new
    #
    # i = 0
    # @sorted_numbers.each do |num|
    #   num_counts[i] = {number: num, count: 0}
    #   i += 1
    # end
    #
    # i = 0
    # j = 0
    # @sorted_numbers.each do |num|
    #   num_counts.each do
    #     if num_counts.keys[j] == num
    #       num_counts.values[j] += 1
    #     end
    #     j += 1
    #   end
    # end
    #
    # sorted_num_counts = num_counts.sort {|numwithcount| numwithcoun[:count]}
    #
    # @mode = sorted_num_counts[sorted_num_counts.length-1][:number]

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
