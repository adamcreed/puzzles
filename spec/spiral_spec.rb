require 'spiral'
# Normally, we'd use a test double for the "RotatingFlippingArray" role
# fulfiled by this Grid class.
require 'grid'

describe Spiral do
  before do
    @klass = Spiral

    def grid_for(rows = [])
      Grid.new(rows: rows)
    end
  end

  describe '#to_a' do
    context 'when given an empty grid' do
      it 'returns itself' do
        expect(@klass.new(grid: grid_for).to_a).to eq grid_for.rows
      end
    end

    context 'when given a 1x1 grid' do
      it 'returns a flattened array' do
        grid = grid_for [%w(tiny)]

        expect(@klass.new(grid: grid).to_a).to eq grid.rows.flatten
      end
    end

    context 'with a 3x3 grid' do
      it 'transforms the grid in a spiral pattern' do
        grid = grid_for [
          %w(a b c),
          %w(d e f),
          %w(g h i)
        ]

        expected = %w(a b c f i h g d e)
        expect(@klass.new(grid: grid).to_a).to eq expected
      end
    end

    context 'with a 4x3 grid' do
      it 'transforms the grid in a spiral pattern' do
        grid = grid_for [
          %w(a b c d),
          %w(e f g h),
          %w(i j k l)
        ]
        expected = %w(a b c d h l k j i e f g)
        expect(@klass.new(grid: grid).to_a).to eq expected
      end
    end

    context 'with a 3x4 grid' do
      it 'transforms the grid in a spiral pattern' do
        grid = grid_for [
          %w(a b c),
          %w(d e f),
          %w(g h i),
          %w(j k l)
        ]
        expected = %w(a b c f i l k j g d e h)
        expect(@klass.new(grid: grid).to_a).to eq expected
      end
    end

    context 'with a 7x5 grid' do
      it 'transforms the grid in a spiral pattern' do
        grid = grid_for [
          %w(a b c d e f g),
          %w(h i j k l m n),
          %w(o p q r s t u),
          %w(v w x y z 0 1),
          %w(2 3 4 5 6 7 8)
        ]
        expected = %w(a b c d e f g n u 1 8 7 6 5 4 3 2 v o h i j k l m t 0 z y x w p q r s)
        expect(@klass.new(grid: grid).to_a).to eq expected
      end
    end

    context 'with a 7x5 grid and clockwise of false' do
      it 'transforms the grid in a counter-clockwise spiral pattern' do
        grid = grid_for [
          %w(a b c d e f g),
          %w(h i j k l m n),
          %w(o p q r s t u),
          %w(v w x y z 0 1),
          %w(2 3 4 5 6 7 8)
        ]
        expected = %w(a h o v 2 3 4 5 6 7 8 1 u n g f e d c b i p w x y z 0 t m l k j q r s)
        expect(@klass.new(grid: grid).to_a(clockwise: false)).to eq expected
      end
    end

    context 'with origin set to top right' do
      it 'starts from the top right corner' do
        grid = grid_for [
          %w(a b c d e),
          %w(f g h i j),
          %w(k l m n o),
          %w(p q r s t)
        ]
        expected = %w(e j o t s r q p k f a b c d i n m l g h)
        expect(@klass.new(grid: grid, origin: :top_right).to_a).to eq expected
      end
    end

    context 'with origin set to bottom right' do
      it 'starts from the bottom right corner' do
        grid = grid_for [
          %w(a b c d e),
          %w(f g h i j),
          %w(k l m n o),
          %w(p q r s t)
        ]
        expected = %w(t s r q p k f a b c d e j o n m l g h i)
        expect(@klass.new(grid: grid, origin: :bottom_right).to_a).to eq expected
      end
    end

    context 'with origin set to bottom left' do
      it 'starts from the bottom left corner' do
        grid = grid_for [
          %w(a b c d e),
          %w(f g h i j),
          %w(k l m n o),
          %w(p q r s t)
        ]
        expected = %w(p k f a b c d e j o t s r q l g h i n m)
        expect(@klass.new(grid: grid, origin: :bottom_left).to_a).to eq expected
      end
    end

    context 'with origin set to bottom left and counter-clockwise' do
      it 'starts from the bottom left corner and goes counter-clockwise' do
        grid = grid_for [
          %w(a b c d e),
          %w(f g h i j),
          %w(k l m n o),
          %w(p q r s t)
        ]
        expected = %w(p q r s t o j e d c b a f k l m n i h g)
        expect(@klass.new(grid: grid, origin: :bottom_left).to_a(clockwise: false)).to eq expected
      end
    end
  end
end
