# ask the user for two number
# ask the user for an operation to perform
# perform the operation on the two numbers
# output the result

# answer = Kernel.get()
# Kernel.puts(answer)
LANGUAGE = 'en'

require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def messages(message, lang = 'en')
  MESSAGES[lang][message]
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def integer?(num)
  num.to_i.to_s == num
end

def float?(num)
  num.to_f.to_s == num
end

def number?(num)
  integer?(num) || float?(num)
end

def op_to_message(op)
  case op
  when '1'
    'Adding'
  when '2'
    'Subtracting'
  when '3'
    'Multiplying'
  when '4'
    'Dividing'
  end
end

prompt(messages('welcome', LANGUAGE))

name = ''
loop do
  name = Kernel.gets().chomp()

  if name.empty?()
    prompt(messages('valid_name', LANGUAGE))
  else
    break
  end
end

prompt("Hi #{name}")

loop do # main loop
  number1 = ''
  loop do
    prompt(messages('first_num', LANGUAGE))
    number1 = Kernel.gets().chomp()

    if number?(number1)
      break
    else
      prompt(messages('not_valid', LANGUAGE))
    end
  end

  number2 = ''
  loop do
    prompt(messages('second_num', LANGUAGE))
    number2 = Kernel.gets().chomp()

    if number?(number2)
      break
    else
      prompt(messages('not_valid', LANGUAGE))
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add
    2) subtract
    3) multiply
    4) divide
MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(messages('choose_op', LANGUAGE))
    end
  end

  prompt("#{op_to_message(operator)} the two number..")

  result = case operator
           when '1'
             number1.to_f() + number2.to_f()
           when '2'
             number1.to_f() - number2.to_f()
           when '3'
             number1.to_f() * number2.to_f()
           when '4'
             number1.to_f() / number2.to_f()
           end

  prompt("The result is #{result}")

  prompt(messages('next_calc', LANGUAGE))
  answer = Kernel.gets().chomp()
  break unless answer.downcase().start_with?('y')
end

prompt(messages('bye', LANGUAGE))
