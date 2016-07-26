# nth_prime.rb

require 'pry'

class Prime
  def self.nth(nth_prime)
    fail ArgumentError if nth_prime <= 0

    @primes = [2]
    next_prime_test = 3
    
    until @primes.size >= nth_prime
      @primes.each do |prime|
        break if next_prime_test % prime == 0
        if prime**2 > next_prime_test
          @primes << next_prime_test
          break
        end
      end

      next_prime_test += 2
    end

    @primes.last
  end
end

# a = Time.now
# Prime.nth(1000000)
# puts Time.now - a
# binding.pry