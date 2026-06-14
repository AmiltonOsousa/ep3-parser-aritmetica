require_relative 'early'
require_relative 'gramatica'
require_relative 'lexer'

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

expressoes = [
  '(1 + 4) * 2^4',
  '7 / ( 1 - 3 )',
  '9^(1 * 6 / 2 + 4)',
  '2 + 4 ^ -4 / 4',
  '^ 2 + 4',
  '9 * 2 +',
  '9 + + 3',
  '( ) * 3',
  '( 3 + 3'
]

expressoes.each do |expressao|
  tokens = Lexer.new(expressao).tokens
  aceito = parser.parse(tokens)
  puts "#{expressao} => #{aceito ? 'Aceito' : 'Rejeitado'}"
end
