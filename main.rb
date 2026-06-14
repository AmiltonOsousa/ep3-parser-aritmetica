
puts "=== EP3 - Parser de Expressoes Aritmeticas ==="
puts
puts "1 - Executar testes Earley"
puts "2 - Executar testes CYK"
print "Opcao: "

opcao = gets.to_i

print "Expressao: "
expressao = gets&.chomp

if expressao.nil? || expressao.strip.empty?
  puts "Expressao invalida"
  exit 1
end

ARGV.replace([expressao])

case opcao
when 1
  Dir.chdir(File.join(__dir__, 'parser-early'))
  load 'main.rb'
when 2
  Dir.chdir(File.join(__dir__, 'parser-cyk'))
  load 'main.rb'
else
  puts "Opcao invalida"
end
