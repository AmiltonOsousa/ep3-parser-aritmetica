require_relative 'cyk'
require_relative 'gramatica_aritmetica'
require_relative 'gramatica'

gramatica = Gramatica.new('S')
GramaticaAritmetica.regras.each { |regra| gramatica.adiciona_regra(regra) }

parser = CYKParser.new(gramatica)

expressoes = if ARGV.empty?
  print "Expressao: "
  entrada = gets&.chomp
  entrada.nil? || entrada.strip.empty? ? [] : [entrada]
else
  ARGV
end

if expressoes.empty?
  puts 'Expressao invalida'
  exit 1
end

expressoes.each do |expressao|
  parser.parse(expressao)
  puts "#{expressao} => #{parser.aceito? ? 'Aceito' : 'Rejeitado'}"
end
