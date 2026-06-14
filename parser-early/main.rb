require_relative 'early'
require_relative 'gramatica'
require_relative 'lexer'
require_relative 'saida_operacoes'

regras = [
  Regra.new('E', %w[E + T]),
  Regra.new('E', %w[E - T]),
  Regra.new('E', %w[T]),

  Regra.new('T', %w[T * P]),
  Regra.new('T', %w[T / P]),
  Regra.new('T', %w[P]),

  Regra.new('P', %w[F ^ P]),
  Regra.new('P', %w[F]),

  Regra.new('F', %w[- F]),
  Regra.new('F', %w[A]),

  Regra.new('A', %w[num]),
  Regra.new('A', %w[( E )])
]

gramatica = Gramatica.new(regras, 'E')
parser = EarleyParser.new(gramatica)

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
  tokens = Lexer.new(expressao).tokens
  aceito = parser.parse(tokens)
  puts "#{expressao} => #{aceito ? 'Aceito' : 'Rejeitado'}"
  p SaidaOperacoes.new(expressao).montar if aceito
end
