def string_operation(base_string, replacer)
  base_string.sub!(replacer, '')
  base_string.include?(replacer) ? string_operation(base_string, replacer) : base_string
end

base_string = gets.chomp
replacer = gets.chomp
p string_operation(base_string, replacer)
