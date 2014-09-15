require 'test_helper'

require "#{Rails.root}/app/models/idea_relations"

# Need to rewrite tests using a separate instance of Neo4j.
# Tests currently depend on the state of the database, and the way queries are
# structured.
class IdeaRelationsTest < ActiveSupport::TestCase
  include IdeaRelations

  test 'relations? returns true when relations exist for an idea' do
    assert_equal true, relations?("A")
  end

  # All ideas must have at least one relation
  test 'relations? returns false when relations do not exist for an idea' do
    assert_equal false, relations?("zzzzzzzzzzzzzzzzzzzzzzzz")
  end

  test 'categorical_relations returns false when the idea is not in the database' do
    assert_equal false, categorical_relations("not a category", "zzzzzzzzzzzzzzzzzzzzzzzz")
  end

  # Found a bug where categories with numbers?(doubtful) certain symbols throw an
  # error BadRequest. I think its the same Lucene bug where the string has to be
  # escaped. params[:category]
  # Try searching Constantinople

  # Easier to write once I have a separate instance of Neo4j.
  # test 'categorical_relations returns false when there are no categorical relations' do
  #   assert_equal false, categorical_relations idea_without_categorical_relations
  # end

  test 'categorical_relations returns relations when the idea has categorical relations' do
    relations = categorical_relations("Names", "Constantinople")
    assert_equal "Eastern Orthodox Church", relations[0]
    assert_equal "Turkey", relations[1]
    assert_equal "Turkish language", relations[2]
    assert_equal "Greek language", relations[3]
    assert_equal "Rome", relations[4]
  end

  test 'find_categories returns false when the idea is not in the database' do
    assert_equal false, find_categories("zzzzzzzzzzzzzzzzzzzzzzzz")
  end

  test 'find_categories returns categories when the idea is in the database' do
    categories = find_categories("Epic poetry")
    assert_equal " Other epics ", categories[0][1]
    assert_equal "Modern epics (from 1500)", categories[1][1]
    assert_equal "The sources", categories[2][1]
    assert_equal "Homer", categories[3][1]
  end

  test 'find_relations returns false when the idea is not in the database' do
    assert_equal false, find_relations("zzzzzzzzzzzzzzzzzzzzzzzz")
  end

  test 'find_relations returns relations when the idea is in the database' do
    relations = find_relations("Alabaster")
    assert_equal "white", relations[0]
    assert_equal "Metonymy", relations[1]
    assert_equal "hydrochloric acid", relations[2]
    assert_equal "effervescence", relations[3]
    assert_equal "Mohs scale of mineral hardness", relations[4]
    assert_equal "limestone", relations[5]
    assert_equal "stalagmitic", relations[6]
    assert_equal "carbonate", relations[7]
    assert_equal "calcite", relations[8]
    assert_equal "calcium", relations[9]
  end
end
