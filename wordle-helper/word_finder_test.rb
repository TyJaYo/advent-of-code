require 'test/unit'
require_relative 'word_finder'

class WordFinderTest < Test::Unit::TestCase
  def test_model_exists
    assert_not_nil WordFinder, 'WordFinder class does not exist'
  end

  def test_find
    word_finder = WordFinder.new
    assert_equal %w[aa ab ba aba baa].sort, word_finder.find('aab').sort, 'Did not return the correct words'
    assert_equal %w[as at ta sac act cat sat tas acts cast cats scat].sort, word_finder.find('tcsa').sort, 'Did not return the correct words'
    assert_equal [
      "aa", "ab", "ba", "ad", "ae", "ar", "be", "de", "ed", "er", "re", "aba", "baa", "cab",
      "bad", "dab", "arb", "bar", "bra", "cad", "ace", "arc", "car", "rad", "are", "ear",
      "era", "bed", "deb", "bee", "reb", "cee", "rec", "dee", "red", "ere", "ree", "area",
      "carb", "crab", "abed", "bade", "bead", "bard", "brad", "darb", "drab", "bare", "bear",
      "brae", "aced", "cade", "dace", "card", "acre", "care", "race", "dare", "dear", "read",
      "bred", "beer", "bree", "cede", "cere", "deer", "dere", "dree", "rede", "reed", "baaed",
      "areca", "areae", "acerb", "brace", "caber", "ardeb", "barde", "bared", "beard", "bread",
      "debar", "acred", "arced", "cadre", "cared", "cedar", "raced", "eared", "rebec", "brede",
      "breed", "ceder", "cered", "creed", "abrade", "arcade", "braced", "decare"
    ].sort, word_finder.find('abecedar').sort
  end
end
