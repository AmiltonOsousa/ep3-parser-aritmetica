require_relative 'cyk'
require_relative 'gramatica'

regras = [
  Regra.new('S', ['E']),

  Regra.new('E', ['E_ADD_T']),
  Regra.new('E', ['E_SUB_T']),
  Regra.new('E', ['T']),
  Regra.new('E_ADD_T', ['E', 'PLUS_T']),
  Regra.new('E_SUB_T', ['E', 'MINUS_T']),
  Regra.new('PLUS_T', ['+']),
  Regra.new('MINUS_T', ['-']),

  Regra.new('T', ['T_MUL_P']),
  Regra.new('T', ['T_DIV_P']),
  Regra.new('T', ['P']),
  Regra.new('T_MUL_P', ['T', 'MUL_P']),
  Regra.new('T_DIV_P', ['T', 'DIV_P']),
  Regra.new('MUL_P', ['*']),
  Regra.new('DIV_P', ['/']),

  Regra.new('P', ['F_POW']),
  Regra.new('P', ['F']),
  Regra.new('F_POW', ['F', 'POW_P']),
  Regra.new('POW_P', ['^', 'P']),

  Regra.new('F', ['NEG_F']),
  Regra.new('F', ['A']),
  Regra.new('NEG_F', ['-', 'F']),

  Regra.new('A', ['num']),
  Regra.new('A', ['LP', 'E_RP']),
  Regra.new('LP', ['(']),
  Regra.new('E_RP', ['E', 'RP']),
  Regra.new('RP', [')'])
]

gramatica = Gramatica.new('S')
regras.each { |regra| gramatica.adiciona_regra(regra) }

parser = CYKParser.new(gramatica)

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
  parser.parse(expressao)
  puts "#{expressao} => #{parser.aceito? ? 'Aceito' : 'Rejeitado'}"
end
