require_relative "cyk"
require_relative "gramatica"

# linguagem a^n b c^n
gramatica = Gramatica.new("S")
gramatica.adiciona_regra(Regra.new('S', ["A", "X"]))
gramatica.adiciona_regra(Regra.new('S', ["b"]))
gramatica.adiciona_regra(Regra.new('A', ["a"]))
gramatica.adiciona_regra(Regra.new('B', ["b"]))
gramatica.adiciona_regra(Regra.new('C', ["c"]))
gramatica.adiciona_regra(Regra.new('X', ["S", "C"]))

# linguagem a^n b^m, n != m
# gramatica.adiciona_regra(Regra.new('S', ["A", "X"]))
# gramatica.adiciona_regra(Regra.new('S', ["X", "B"]))
# gramatica.adiciona_regra(Regra.new('A', ["a"]))
# gramatica.adiciona_regra(Regra.new('B', ["b"]))
# gramatica.adiciona_regra(Regra.new('A', ["A", "A"]))
# gramatica.adiciona_regra(Regra.new('B', ["B", "B"]))
# gramatica.adiciona_regra(Regra.new('X', ["A", "B"]))
# gramatica.adiciona_regra(Regra.new('X', ["A", "Y"]))
# gramatica.adiciona_regra(Regra.new('Y', ["X", "B"]))

parser = CYKParser.new(gramatica)
entrada = 'aaabccc'
parser.parse(entrada)

puts parser.aceito? ? "Aceito" : "Não aceito"