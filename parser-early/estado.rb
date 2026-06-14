require 'set'

class Estado
  attr_accessor :regra, :ponto, :inicio, :comentario

  def initialize(regra, ponto, inicio, comentario = '')
    @regra = regra
    @ponto = ponto
    @inicio = inicio
    @comentario = comentario
  end

  def completo?
    ponto == regra.direita.length
  end

  def next_symbol
    regra.direita[ponto]
  end

  def advance(k, regra_anterior)
    Estado.new(regra, ponto + 1, inicio, "Scan de S(#{k})(#{regra_anterior})")
  end

  def complete(k, regra1, regra2)
    Estado.new(regra, ponto + 1, inicio, "Completo de #{regra1} e S(#{k})(#{regra2})")
  end

  def ==(other)
    regra.to_s == other.regra.to_s && ponto == other.ponto && inicio == other.inicio
  end

  def eql?(other)
    self == other
  end

  def hash
    [regra.to_s, ponto, inicio].hash
  end

  def to_s
    direita = regra.direita.dup
    direita.insert(ponto, '.')
    "#{regra.esquerda} -> #{direita.join(' ')}"
  end
end

class S
  attr_reader :estados, :estados_visitados

  def initialize(index, entrada)
    @index = index
    @entrada = entrada
    @estados = Set.new
    @estados_visitados = Set.new
  end

  def <<(element)
    estados << element unless estados_visitados.include?(element)
  end

  def take!
    estado = (estados - estados_visitados).first
    estados_visitados << estado
    estado
  end

  def empty?
    (estados - estados_visitados).empty?
  end

  def to_s
    expressao = @entrada.dup
    expressao.insert(@index, '.')
    linhas = ["==== S(#{@index}): #{expressao.join(' ')} ===="]

    estados.each do |estado|
      linhas << "#{estado} | origem: #{estado.inicio} | #{estado.comentario}"
    end

    "#{linhas.join("\n")}\n"
  end
end
