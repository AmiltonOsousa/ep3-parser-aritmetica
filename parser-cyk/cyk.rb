require 'set'
require_relative 'lexer'
require_relative 'gramatica'

class CYKParser
  attr_reader :tabela, :gramatica

  def initialize(gramatica)
    @gramatica = gramatica
    separar_regras
  end

  def parse(entrada)
    tokens = entrada.is_a?(String) ? Lexer.new(entrada).tokens : entrada
    n = tokens.length
    @tabela = Array.new(n) { Array.new(n) { Set.new } }

    return @tabela if n.zero?

    tokens.each_with_index do |token, i|
      adicionar_terminais(@tabela[i][i], token)
      fechar_unitarias(@tabela[i][i])
    end

    (2..n).each do |tamanho|
      (0..n - tamanho).each do |inicio|
        fim = inicio + tamanho - 1

        (inicio...fim).each do |meio|
          combinar_celulas(@tabela[inicio][fim], @tabela[inicio][meio], @tabela[meio + 1][fim])
        end

        fechar_unitarias(@tabela[inicio][fim])
      end
    end

    @tabela
  end

  def aceito?
    return false if @tabela.nil? || @tabela.empty?

    @tabela[0][-1].include?(@gramatica.simbolo_inicial)
  end

  private

  def separar_regras
    @terminais = Hash.new { |hash, chave| hash[chave] = Set.new }
    @binarias = Hash.new { |hash, chave| hash[chave] = Set.new }
    @unitarias = Hash.new { |hash, chave| hash[chave] = Set.new }

    @gramatica.regras.each do |regra|
      case regra.direita.length
      when 1
        simbolo = regra.direita.first
        if terminal?(simbolo)
          @terminais[simbolo] << regra.esquerda
        else
          @unitarias[simbolo] << regra.esquerda
        end
      when 2
        @binarias[[regra.direita[0], regra.direita[1]]] << regra.esquerda
      end
    end
  end

  def adicionar_terminais(celula, token)
    @terminais[token].each do |simbolo|
      celula << simbolo
    end
  end

  def combinar_celulas(destino, esquerda, direita)
    esquerda.each do |simbolo_esquerda|
      direita.each do |simbolo_direita|
        @binarias[[simbolo_esquerda, simbolo_direita]].each do |resultado|
          destino << resultado
        end
      end
    end
  end

  def fechar_unitarias(celula)
    fila = celula.to_a

    until fila.empty?
      simbolo = fila.pop
      @unitarias[simbolo].each do |pai|
        next if celula.include?(pai)

        celula << pai
        fila << pai
      end
    end
  end

  def terminal?(simbolo)
    %w[num + - * / ^ ( )].include?(simbolo)
  end
end
