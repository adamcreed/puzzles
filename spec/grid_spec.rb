require 'grid'

# :nodoc:
describe Grid do
  before do
    @klass = Grid
  end

  describe '#new' do
    context 'When no values are entered' do
      it 'creates an empty grid' do
        expect(@klass.new.empty?).to eq true
      end
    end

    context 'When valid arrays are given' do
      it 'creates a grid with the given values' do
        input = [
          %w(a b c d e),
          %w(f g h i j)
        ]

        expect(@klass.new(rows: input).empty?).to eq false
        expect(@klass.new(rows: input).rows).to eq input
      end
    end

    context 'When irregular arrays are given' do
      it 'raises an ArgumentError' do
        input = [
          %w(a b c d e),
          %w(f g h i)
        ]

        expect { @klass.new(rows: input) }.to raise_error(ArgumentError)
      end
    end

    context 'When one array is given' do
      it 'raises an ArgumentError' do
        input = %w(x y z)

        expect { @klass.new(rows: input) }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#rotate' do
    context 'when given no arguments' do
      it 'rotates clockwise' do
        input = [%w(a b c d e), %w(f g h i j)]
        expected = [%w(f a), %w(g b), %w(h c), %w(i d), %w(j e)]
        rotated = @klass.new(rows: input).rotate

        expect(rotated.rows).to eq expected
      end
    end

    context 'when given clockwise of false' do
      it 'rotates counter-clockwise' do
        input = [%w(a b c d e), %w(f g h i j)]
        expected = [%w(e j), %w(d i), %w(c h), %w(b g), %w(a f)]
        rotated = @klass.new(rows: input).rotate(clockwise: false)

        expect(rotated.rows).to eq expected
      end
    end

    context 'when rotating multiple times' do
      it 'returns the same result rotating three times clockwise as once counter-clockwise' do
        input = [%w(a b c d e), %w(f g h i j)]
        cw = @klass.new(rows: input).rotate.rotate.rotate
        ccw = @klass.new(rows: input).rotate(clockwise: false)

        expect(cw.rows).to eq ccw.rows
      end
    end
  end

  describe '#reflect' do
    context 'when given no arguments' do
      it 'reflects the rows vertically' do
        input = [%w(a b c d e), %w(f g h i j)]
        expected = [%w(f g h i j), %w(a b c d e)]

        expect(@klass.new(rows: input).reflect.rows).to eq expected
      end
    end

    context 'when given no a vertical of false' do
      it 'reflects the rows horizontally' do
        input = [%w(a b c d e), %w(f g h i j)]
        expected = [%w(e d c b a), %w(j i h g f)]

        expect(@klass.new(rows: input).reflect(vertical: false).rows).to eq expected
      end
    end
  end
end
