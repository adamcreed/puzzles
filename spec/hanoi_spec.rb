require 'hanoi'

describe '#play_game' do
  context 'with three discs and a goal turn of 6' do
    it 'draws the game one move from solved' do
      result = play_game(number_of_discs: 3, goal_turn: 6)

      expect(result).to eq "   |       |       |\n" \
                           "   |       |     #####\n" \
                           "  ###      |    #######\n" \
                           "7"
    end
  end

  context 'with four discs and a goal turn of 15' do
    it 'draws a complete game' do
      result = play_game(number_of_discs: 4, goal_turn: 15)

      expect(result).to eq "    |         |        ###\n" \
                           "    |         |       #####\n" \
                           "    |         |      #######\n" \
                           "    |         |     #########\n" \
                           "15"
    end
  end

  context 'with six discs and a goal turn of 17' do
    it 'draws stacks of [1, 6], [5], [2, 3, 4]' do
      result = play_game(number_of_discs: 6, goal_turn: 17)

      expect(result).to eq "      |             |             |\n" \
                           "      |             |             |\n" \
                           "      |             |             |\n" \
                           "      |             |           #####\n" \
                           "     ###            |          #######\n" \
                           "#############  ###########    #########\n" \
                           "63"
    end
  end

  context 'with nine discs and a goal turn of 435' do
    it 'draws stacks of [3, 4, 7], [1, 2, 5, 6], [8, 9]' do
      result = play_game(number_of_discs: 9, goal_turn: 435)

      expect(result).to eq "         |                   |                   |\n" \
                           "         |                   |                   |\n" \
                           "         |                   |                   |\n" \
                           "         |                   |                   |\n" \
                           "         |                   |                   |\n" \
                           "         |                  ###                  |\n" \
                           "      #######              #####                 |\n" \
                           "     #########          ###########      #################\n" \
                           "  ###############      #############    ###################\n" \
                           "511"
    end
  end

  context 'with ten discs and a goal turn of 512' do
    it 'draws a half done game' do
      result = play_game(number_of_discs: 10, goal_turn: 512)

      expect(result).to eq "          |                     |                     |\n" \
                           "          |                    ###                    |\n" \
                           "          |                   #####                   |\n" \
                           "          |                  #######                  |\n" \
                           "          |                 #########                 |\n" \
                           "          |                ###########                |\n" \
                           "          |               #############               |\n" \
                           "          |              ###############              |\n" \
                           "          |             #################             |\n" \
                           "          |            ###################  #####################\n" \
                           "1023"
    end
  end
end
