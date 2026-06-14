require_relative "early"
require_relative "gramatica"

regras = [
  Regra.new('S', %w[N + S]),
  Regra.new('S', %w[N]),
  Regra.new('N', %w[1]),
  Regra.new('N', %w[2]),
  Regra.new('N', %w[3])
]

gramatica = Gramatica.new(regras, "S")

parser = EarleyParser.new(gramatica)
input = "1+2"
puts parser.parse(input) ? 'Aceito' : 'Rejeitado'
