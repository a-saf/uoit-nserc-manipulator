# Mortgage Calculator
# takes loan amount, Annual Percentage Rate (APR) and loan duration in months
# and calculated monthly payments

def prompt(message)
  Kernel.puts("=> #{message}")
end

prompt("Welcome to Mortgage Calculator!")

loop do
  prompt("Enter the loan amount:")

  loan_amount = ''
  loop do
    loan_amount = Kernel.gets().chomp()

    if loan_amount.empty?() || loan_amount.to_f() < 0
      prompt("Entered value is invalid. Make sure you enter a positive value.")
    else
      break
    end
  end

  prompt("Enter the Annual Percentage Rate in percent:")

  annual_percentage_rate = ''
  loop do
    annual_percentage_rate = Kernel.gets().chomp()

    if annual_percentage_rate.empty?() || annual_percentage_rate.to_f() < 0
      prompt("Entered value is invalid. Make sure your rate is a positive value between 0 and 100%")
    else
      break
    end
  end

  monthly_interest = annual_percentage_rate.to_f() / 12 / 100

  prompt("Enter the loan duration in months:")

  loan_duration = ''
  loop do
    loan_duration = Kernel.gets().chomp()

    if loan_duration.empty?() || loan_duration.to_i < 0
      prompt("Entered value is invalid. Make sure you enter a positive value.")
    else
      break
    end
  end

  monthly_payment = loan_amount.to_f() *
                    (monthly_interest /
                    (1 - (1 + monthly_interest)**-loan_duration.to_i()))

  prompt("Your monthly payment is $#{format('%02.2f', monthly_payment)}")

  prompt("Would you like to perform another calculation? y/n")
  answer = Kernel.gets().chomp()

  break unless answer.downcase().start_with?('y')
end

prompt("Thank you for using the Mortgage Calculator")
prompt("Good Bye!")
