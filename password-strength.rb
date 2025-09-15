CAPS_CASE   = /[A-Z]/
DOWN_CASE   = /[a-z]/
NUMBERS     = /[0-9]/
SPCL_CHARS  = /[!@#$%^&*]/

def length_score(password)
  return 4 if password.length >= 12
  return 2 if password.length >= 8
  0
end

def strength(score)
  return "Strong" if score >= 7 
  return "Medium" if score >= 4
  "Weak"
end

password = gets.chomp

score = 0
score += length_score(password)
score += 1 if password.match?(CAPS_CASE)
score += 1 if password.match?(DOWN_CASE)
score += 1 if password.match?(NUMBERS)
score += 2 if password.match?(SPCL_CHARS)

p strength(score)
