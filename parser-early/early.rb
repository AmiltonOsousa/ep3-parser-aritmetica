require 'set'
require_relative 'gramatica'
require_relative 'estado'

class EarleyParser
  attr_reader :gramatica

  def initialize(gramatica)
    @gramatica = gramatica
    @simbolo_inicial_real = 'INICIO'
    @gramatica.regras.unshift(Regra.new(@simbolo_inicial_real, [gramatica.simbolo_inicial]))
  end

  def parse(tokens, mostrar_tabela: false)
    @tabela = Array.new(tokens.length + 1) { |indice| S.new(indice, tokens) }

    @tabela[0] << Estado.new(@gramatica.regras.first, 0, 0, 'Regra inicial')

    (0..tokens.length).each do |index|
      if mostrar_tabela
        token_atual = tokens[index] || 'fim'
        puts "\n==== Token: #{token_atual}, Posicao: #{index} ===="
      end

      until @tabela[index].empty?
        estado = @tabela[index].take!

        if estado.completo?
          complete(estado, index)
        elsif estado.next_symbol == tokens[index]
          scan(estado, index)
        else
          predict(estado, index)
        end
      end
    end

    puts @tabela if mostrar_tabela
    final_is_valid?(@tabela[tokens.length])
  end

  private

  def final_is_valid?(estado_final)
    estado_final.estados.any? do |estado|
      estado.regra.esquerda == @simbolo_inicial_real &&
        estado.completo? &&
        estado.inicio == 0
    end
  end

  def predict(estado, index)
    @gramatica.regras.each do |regra|
      next unless regra.esquerda == estado.next_symbol

      @tabela[index] << Estado.new(regra, 0, index, "Predito de #{estado}")
    end
  end

  def scan(estado, index)
    @tabela[index + 1] << estado.advance(index, estado)
  end

  def complete(estado, index)
    @tabela[estado.inicio].estados.each do |candidato|
      next unless candidato.next_symbol == estado.regra.esquerda

      @tabela[index] << candidato.complete(index - 1, estado, candidato)
    end
  end
end
